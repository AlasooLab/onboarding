# If eQTLUtils not yet installed then run
#remotes::install_github("kauralasoo/eQTLUtils")

library("eQTLUtils")
library("purrr")

#Import all files from the MBV directory
mbv_results = eQTLUtils::mbvImportData("~/Downloads/BLUEPRINT_monocytes_H3K4me1/MBV_results/")

#Find the best match for each mbv sample
mbv_df = purrr::map_df(mbv_results, eQTLUtils::mbvFindBestMatch, .id = "sample_id")

#Remove cases where the het_min_dist or hom_min_dist are NA. Thse represent cases where
#the best natch was different when using hom_consistent_frac and het_consistent_frac and are 
# thus unlikely to represent true matches
mbv_df = dplyr::filter(mbv_df, !is.na(het_min_dist))

#Note that the "best" match might still not be very good, if the second closets match is also very similar.
#These cases can be discovered by looking at he histograms of het_min_dist and hom_min_dist
hist(mbv_df$het_min_dist)
hist(mbv_df$hom_min_dist)

#Tell-tale sign of a problem is a bimodel distribution on the histogram where 
# some samples are very close to 0 and others have much higher values. The samples
# that have close to zero values shoud typically be removed.
mbv_df = dplyr::filter(mbv_df, het_min_dist > 0.25)re