#' Curated data URLs
#'
#' URLs for the ACLED curated data files
#'
#' @param which Which region's URL to return; NULL (default) will return all
#'
#' @return a named list containing the URL(s)
#'
#' @export
curated_data_urls <- function(which = NULL) {
  urls <- list(
    "africa"      = "https://www.acleddata.com/download/2909/",
    "middle_east" = "https://www.acleddata.com/download/2915/",
    "asia"        = "https://www.acleddata.com/download/2912/",
    "europe"      = "https://www.acleddata.com/download/14515/"
  )
  if (is.null(which)) {
    return(urls)
  }
  if (!which %in% names(urls)) {
    stop(sprintf("Could not find URL for which = '%s'; valid options are [%s]",
                 which,
                 paste(names(urls), collapse = ", ")))
  }
  urls[which]
}
