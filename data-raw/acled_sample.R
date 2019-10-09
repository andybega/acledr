

events <- read_acled()

set.seed(1234)
idx <- sample(nrow(events), 100)

acled_sample <- events[idx, ]

usethis::use_data(acled_sample, overwrite = TRUE)
