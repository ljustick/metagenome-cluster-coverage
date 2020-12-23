# metagenomic-nut-lim

### to do:
Example Script | dummy dataset zipped on gdrive
1. make function | input robust | clear function header | final text desctiption  
2. **merge_anvio_summary** ~~make function~~ | input robust | clear function header | final text desctiption  
3. make function | input robust | clear function header | final text desctiption  
4. make function | input robust | clear function header | final text desctiption  

# Analysis
### Anvi'o
Anvi'o Metagenomic Tutorial: http://merenlab.org/2016/06/22/anvio-tutorial-v2/  
Anvi'o Pangenomic Tutorial: http://merenlab.org/2016/11/08/pangenomics-v2/
### 1. Identify clusters of interest
### 2. Merge summaries together
Matlab function to merge Anvi'o summary files together, all inputs must be strings.
```matlab
merge_anvio_summary(file_type,dir_sumaries_are_in,name)
```
example:
```matlab
merge_anvio_summary("-gene_coverages.txt","SUMMARIES","TEST")
```
This will results in the following. All gene coverage files will be merged into a single file per reference genome **get ANVIO NAMING**
found in the directory TEST-MERGED-SUMMARY.
### 3. Extract raw read abundances
