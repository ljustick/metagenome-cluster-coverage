function merge_anvio_summary(in1,in2,in3)
% Function to merge anvio summary files
%   argument 1 is the desired file type to merge
%       Ex: "-gene_coverages.txt"
%   argument 2 is the directory where summary files are found
%   argument 3 is the name you want to be applied to the merged files

file_type = in1; %example "-gene_coverages.txt"
folder = in2; %example "C13-Summaries"
database = in3; %example "C13"

mkdir(database);

% Isolate all samples in the given folder
samples = ls(folder) ;
samples = split(convertCharsToStrings(samples)) ;

% Collect all bins/genomes in folder
genomes = ls(strjoin([folder "/" samples(1,1) "/bin_by_bin"],"")) ;
genomes = split(convertCharsToStrings(genomes)) ;

%% Merge Files Together

%Collect Number of Samples and genomes
[r,~]=size(samples);
[rr,~]=size(genomes);


for i = 1:rr-1 %Loop through each bin/genome
    %i=1;
    bin = strjoin([folder "/" samples(1,1) "/bin_by_bin/" genomes(i,1) "/" genomes(i,1) file_type],"");
    save = readtable(bin,'ReadVariableNames',false);
    jj=2;
    for j = 1:r-1 %Loop through each sample
        bin = strjoin([folder "/" samples(j,1) "/bin_by_bin/" genomes(i,1) "/" genomes(i,1) file_type],"");
        add = readtable(bin,'ReadVariableNames',false);
        [rrr,ccc]=size(add);
        add=add(:,2:ccc);
        save(:,jj:jj+ccc-2) = add ;       
        jj=jj+ccc-1;
    end
    %save.Properties.VariableNames = cellstr(horzcat('gene_callers_id',strrep(samples(1:r-1).',"-SUMMARY","")));
    save.Properties.VariableNames = table2cell(save(1,:));
    save=save(2:rrr,:);
    writetable(save,strjoin([database "/" database "-" genomes(i,1) file_type],''));
end

end