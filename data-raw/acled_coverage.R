#
#   Extract country coverage from relevant PDF note
#

library("httr")
library("tabulizer")
library("stringr")
library("countrycode")

url <- "https://www.acleddata.com/wp-content/uploads/dlm_uploads/2018/02/Country-and-Time-Period-coverage_updatedJune2019-1.pdf"

r <- httr::GET(url)
if (httr::status_code(r)!=200) {
  stop("URL seems to not be valid anymore, response code ", httr::status_code(r))
}

writeBin(content(r, as = "raw"), "data-raw/pdf/coverage.pdf")

coverage <- extract_tables("data-raw/pdf/coverage.pdf")
coverage <- do.call(rbind, coverage)
coverage <- as.data.frame(coverage, stringsAsFactors = FALSE)
colnames(coverage) <- c("country", "start")
coverage <- coverage[!coverage$start %in% c("", "Time period"), ]

date <- str_extract(coverage$start, "[0-9/]+")
date <- paste0("1/", date)
coverage$start <- as.Date(date, format = "%d/%m/%Y")

coverage$gwcode <- countrycode(coverage$country, "country.name", "cown")
coverage$gwcode[coverage$country=="Serbia"]   <- 340
coverage$gwcode[coverage$country=="eSwatini"] <- 572
coverage$gwcode[coverage$country=="Yemen"]    <- 678
coverage$gwcode[coverage$country=="Vietnam"]  <- 816

coverage <- coverage[, c("country", "gwcode", "start")]
coverage <- coverage[order(coverage$country), ]

acled_coverage <- coverage

usethis::use_data(acled_coverage, overwrite = TRUE)




