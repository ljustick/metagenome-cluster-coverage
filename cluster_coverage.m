function cluster_coverage(in1,in2,in3)
% Function to calculate gene cluster coverage
%   argument 1 is the gene cluster file to be referenced
%   argument 2 is the dataset you want to extract coverages from
%   argument 3 is the output file name

%% Calculate Gene Coverages , Input Files

%Pick what species and nutrient you want to work on
%species_nutrient_file='pro_Fe_nut_clus.csv';
%Dataset='TEST';
%out_file='test.csv';

species_nutrient_file=in1;
Dataset=in2;
out_file=in3;

nutrient_gene_table = readtable(species_nutrient_file);

%% Calculate Coverage of genes

bins = ls(Dataset) ; %ALL bins
bins = split(convertCharsToStrings(bins)) ; %ALL bins
save = readtable([  Dataset '/' char(bins(1,1)) ]);
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
    rr=1; %Number of genes in gene cluster
    if i+rr < r %Prevent from breaking on last entry
        while table2array(nutrient_gene_table(i,1)) == table2array(nutrient_gene_table(i+rr,1))
            rr=rr+1;
            if i+rr > r %Prevent it from failing on last entry
                break
            end
        end
    end

    cluster_cov=zeros(rr,c);
    save(ii,1) = nutrient_gene_table(i,1);
    
    for j = 1:rr %Loop through every ID in the cluster
        genome_name = char(table2array(nutrient_gene_table(i,2))); 
        coverage_path =[  Dataset '/' Dataset '-' genome_name '-gene_coverages.txt' ];
        coverage_file = readtable(coverage_path,'ReadRowNames',true);
        gc_id = string(table2array(nutrient_gene_table (i,3)));
        cluster_cov(j,:) = table2array(coverage_file(gc_id,:));
        i=i+1;
    end
    [num_in_clus,~]=size(cluster_cov);
    if num_in_clus == 1
        save(ii,2:c+1)=array2table(cluster_cov);
    else
        save(ii,2:c+1)=array2table(sum(cluster_cov));
    end
    ii=ii+1;
    
end
save1 = save (1:clus,:);
%% Save Coverages
writetable(save1,out_file);

end
