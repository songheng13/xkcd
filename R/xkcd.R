#' @title Retrieve metadata about xkcd comic
#'
#' @description Given an xkcd number, this function retrieves a JSON object
#' describing that comic from the official xkcd API.
#'
#' @title Retrieve metadata about an xkcd comic
#'
#' @describeIn Given an xkcd comic number, this function retrieves a JSON object
#'   describing that comic from the official xkcd API
#'
#' @param number A scaler numeric vector identifying an xkcd comic by number.
#'
#' @return A list of class xkcd with the following elements
#' * month: A scalar character vector identifying the month of the year the comic was published
#' * num: A scalar numeric vector identifying the comic by number
#' * link
#' * year
#' * safe_title
#' * transcript
#' * title
#' * day
#'
#' Note that many of these elements may hold missing data
#'
#' @examples
#' first_comic <- xkcd(1)
#' print(first_comic)
#'
#' @importFrom jsonlite read_json
#' @export
#'
#'
#'
xkcd <- function(number) {
  url <- file.path("https://xkcd.com", number, "info.0.json")
  results <- jsonlite::read_json(url)
  x <- new_xkcd(results)
  x <- validate_xkcd(x)
  return(x)
}

new_xkcd <- function(x) {

  stopifnot(is.list(x))

  structure(x,
            class = "xkcd")
}

#' @title Visualize xkcd comics
#'
#' @description
#' Given an [`xkcd`] object, this [`base::plot`] method retrieves the image file
#' associated with this comic from the xkcs website and displays it in the
#' currently active graphic devices
#'
#' @importFrom httr GET
#' @importFrom png readPNG
#' @importFrom jpeg readJPEG
#' @importFrom grid grid.raster
#' @importFrom graphics plot.new

#' @param x an [`xkcd`] object
#' @param ... currently ignored
#'
#' @examples
#' first_comic <- xkcd(1)
#' plot(first_comic)
#' @exportS3Method
plot.xkcd <- function(x, ...) {

  img_type <- tools::file_ext(x$img)

  tmp <- httr::GET(url = x$img)

  if (img_type == "png") {
    p <- png::readPNG(tmp$content)
  } else if (img_type == "jpg" || img_type == "jepg") {
    p <- jpeg::readHPEG(tmp$content)
  }

  graphics::plot.new()
  grid::grid.raster(p)
}
