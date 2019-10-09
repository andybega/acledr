

.onAttach <- function(libname, pkgname) {
  path <- getOption("acledr.data_dir")
  if (is.null(path)) {
    packageStartupMessage("Could not find path for acledr data directory location, consider setting 'option(acledr.data_dir = ...)'")
  } else {
    packageStartupMessage("Storing artifacts at '", path, "'")
  }
}


#' Data path
#'
#' Path to folder containing data
#'
#' @param ... additional elements to splice into path, e.g. file name
#'
#' @export
acled_data_path <- function(...) {
  dots <- list(...)
  path <- c(getOption("acledr.data_dir"), dots)
  do.call(file.path, path)
}
