## code to prepare `DATASET` dataset goes here

events <- read_acled()

usethis::use_data(acled_sample, overwrite = TRUE)
