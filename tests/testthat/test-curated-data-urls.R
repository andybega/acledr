


test_that("URLs are valid and working", {

  skip()

  library(httr)

  urls <- curated_data_urls()

  for (url in urls) {
    response <- HEAD(url)
    expect_equal(status_code(response), 200)
  }

})


