library("readr")
library("data.table")

is_diploid <- function(vector){
  vector %like% "\\|"
}

#Import genotypes
gt_matrix = readr::read_tsv("~/Downloads/chrX.phased.vcf.gz", comment = "##")
gt_mat = gt_matrix[,-c(1:9)]

#Identify deploid genotypes
diploid_tibble = dplyr::mutate(gt_mat, across(everything(), is_diploid))
diploid_count = colSums(as.matrix(diploid_tibble))
selection = diploid_count == max(diploid_count) | diploid_count == 0
selected_idvs = gt_mat[,!selection]

#Build final table
problematic_individuals = dplyr::bind_cols(gt_matrix[,c(1:9)], selected_idvs)