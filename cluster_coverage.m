%% Calculate Gene Coverages , Input Files
cd /Users/lucasustick/Desktop/Global_Nutrient_Stress/Gene_Clusters;
%Pick what species and nutrient you want to work on
nutrient_species='chrom_final';
species_nutrient_file=['nutrient_ref/' nutrient_species '_nut_clus.csv'];
Dataset='C13';

nutrient_gene_table = readtable(species_nutrient_file);

%% Calculate Coverage of genes

% bins = ls(['Merged_Gene_Coverages/' Dataset]) ; %ALL bins
% bins = split(convertCharsToStrings(bins)) ; %ALL bins
% save = readtable([ 'Merged_Gene_Coverages/' Dataset '/' char(bins(1,1)) ]);
% [clus,~] = size(unique(nutrient_gene_table(:,1))); % Number of clusters
% save = save(1:clus,:);
% [~,c] = size(save); c=c-1; % Number of samples

bins = ls(['Merged_Gene_Coverages/' Dataset]) ; %ALL bins
bins = split(convertCharsToStrings(bins)) ; %ALL bins
save = readtable([ 'Merged_Gene_Coverages/' Dataset '/' char(bins(1,1)) ]);
[clus,~] = size(unique(nutrient_gene_table(:,1))); % Number of clusters
[~,c] = size(save);  
save(1:clus,:) = array2table(zeros(clus,c));
c=c-1; % Number of samples

[r,~] = size(nutrient_gene_table(:,1)); % Number of rows in nutrient file

i=1;
ii=1;
while ii <= clus  %Loop through each gene cluster
    gclus_id = string(table2array(nutrient_gene_table (i,1)));
    disp(gclus_id)
    rr=1; %table2array(nutrient_gene_table(i,5));%Number of genes in gene cluster
    if i+rr < r %Prevent from breaking on last entry
        while table2array(nutrient_gene_table(i,1)) == table2array(nutrient_gene_table(i+rr,1))
            rr=rr+1;
            if i+rr > r %Prevent it from failing on last entry
                break
            end
        end
    end
    disp(rr)
    %rr=rr-1;
    cluster_coverage=zeros(rr,c);
    save(ii,1) = nutrient_gene_table(i,1);
    disp(i)
    
    for j = 1:rr %Loop through every ID in the cluster
        genome_name = char(table2array(nutrient_gene_table(i,2))); 
        genome_name = strrep(genome_name,'_','-'); %Change characters such as underlines giving issues
        coverage_path =[ 'Merged_Gene_Coverages/' Dataset '/' Dataset '-' genome_name '-gene_coverages.txt' ];
        coverage_file = readtable(coverage_path,'ReadRowNames',true);
        gc_id = string(table2array(nutrient_gene_table (i,3)));
        cluster_coverage(j,:) = table2array(coverage_file(gc_id,:));
        i=i+1;
        %disp(i)
    end
    [num_in_clus,~]=size(cluster_coverage);
    if num_in_clus == 1
        save(ii,2:c+1)=array2table(cluster_coverage);
    else
        save(ii,2:c+1)=array2table(sum(cluster_coverage));
    end
    ii=ii+1;
    %i=i+1;
    
end
save1 = save (1:clus,:);
%% Save Coverages
writetable(save1,['Merged_Gene_Coverages/Nutrient_Coverages/' Dataset '-' nutrient_species '-coverage.csv']);
