# metagenomic-cluster-coverage
Test dataset: https://drive.google.com/drive/folders/1ysmM95UsyMB_pQ84owqQrmuTLhFBpTnF?usp=sharing  
Data for part 1 is provided in the file `pro_Fe_nut_clus.csv`
Code was made for matlab ver. R2018b
### Anvi'o
Anvi'o Metagenomic Tutorial: http://merenlab.org/2016/06/22/anvio-tutorial-v2/  
Anvi'o Pangenomic Tutorial: http://merenlab.org/2016/11/08/pangenomics-v2/
### 1. Identify clusters of interest
The user first needs to identify the gene clusters you are interested in. To calculate the coverage you will need a csv with the following information in the following format. You will need the gene cluster/clusters you are interested in, and the corresponding reference genomes and the gene calller id's that fall within the cluster. 
Example:
| Cluster ID | Genome Name | Gene Caller ID |
| ---- | ---- | ---- |
| 001 | genome1 | GCID |
| 001 | genome2 | GCID |
| ... | ... | ... |
  
This information can be generated using the above Anvi'o pipelines. The pangenomic summary file contains all the required information to create this table.

### 2. Sum coverages of genes in clusters of interest
Matlab function to extract gene cluster read coverages, all inputs must be character arrays.
```matlab
cluster_coverage(cluster_file,dataset,output_file)
```
example:
```matlab
cluster_coverage('pro_Fe_nut_clus.csv','TEST','test.csv')
```
this will results in a file named ` test.csv ` with the calculated gene coverages.