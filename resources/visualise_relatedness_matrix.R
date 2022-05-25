library("readr")
library("dplyr")
library("pheatmap")

#Import relatedness results
relatedness_df = readr::read_tsv("~/Downloads/relatedness_matrix.tsv")

#Make a heatmap
rel_mat = relatedness_df[,-1] %>% as.matrix()
row.names(rel_mat) = relatedness_df$iid
pheatmap(rel_mat)

pairwise_relatedness = tidyr::pivot_longer(relatedness_df, !iid, names_to = "other_iid", values_to = "relatedness") %>% 
  dplyr::filter(iid != other_iid) %>% dplyr::arrange(-relatedness)
pairwise_relatedness
