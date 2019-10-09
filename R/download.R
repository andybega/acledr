
#' Download ACLED data
#'
#' Download the curated ACLED .xlsx data files
#'
#' @param to_dir destination directory, if NULL set options
#' @param which which region to download, by default all.
#'
#' @export
download_acled <- function(to_dir = NULL, which = "all") {
  if (which=="all") {
    which <- NULL
  }
  urls     <- curated_data_urls(which)
  outpaths <- acled_data_path(paste0(names(urls), ".xlsx"))
  for (i in 1:length(urls)) {
    cat(sprintf("Downloading %s\n", basename(outpaths[[i]])))
    utils::download.file(urls[[i]], destfile = outpaths[[i]])
  }
  invisible(outpaths)
}

#' Read ACLED data
#'
#' Read ACLED data into memory
#'
#' @param data_path path to data folder, if NULL (default) set by consulting
#'   [acled_data_path()].
#'
#' @export
read_acled <- function(data_path = NULL) {
  if (is.null(data_path)) {
    data_path <- acled_data_path()
  }
  data_files <- dir(data_path, full.names = TRUE)
  events <- lapply(data_files, readxl::read_xlsx)
  events <- do.call(rbind, events)
  colnames(events) <- tolower(colnames(events))

  events$event_date <- as.Date(events$event_date)

  events$gwcode <- countrycode::countrycode(events[["iso"]], "iso3n", "cown")
  events$gwcode[events$gwcode==679] <- 678L  # Yemen
  events$gwcode[events$ISO==275]    <- 667L  # Palestine

  events
}


