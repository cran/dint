# year --------------------------------------------------------------------

#' Get Year, Quarter, Month or Isoweek
#'
#'
#' @details
#' If you use \pkg{lubridate} in addition to dint,
#' you can also use [lubridate::year()], [lubridate::month()] and
#' [lubridate::quarter()] with dint objects.
#'
#' @param x a [date_xx] or any \R object that can be coerced to `POSIXlt`
#'
#' @export
#' @rdname getters
#' @return
#'   an `integer` vector.
#'
#' @seealso
#'   [lubridate::year()],
#'   [lubridate::month()],
#'   [lubridate::quarter()]
#'
#' @examples
#' x <- date_yq(2016, 2)
#' get_year(x)
#' \dontrun{
#' library(lubridate)
#' year(x)
#' }
#'
get_year <- function(x){
  UseMethod("get_year")
}




#' @export
get_year.date_y <- function(x){
  as.integer(x)
}




#' @export
get_year.date_yw <- function(x){
  x <- as.integer(x)
  as.integer(sign(x) * (abs(x) %/% 100L))
}




#' @export
get_year.date_ym <- function(x){
  x <- as.integer(x)
  as.integer(sign(x) * (abs(x) %/% 100L))
}




#' @export
get_year.date_yq <- function(x){
  x <- as.integer(x)
  as.integer(sign(x) * (abs(x) %/% 10L))
}




#' @export
get_year.default <- function(x){
  as.POSIXlt(x, tz = tz(x))$year + 1900L
}




#' Get Year, Quarter or Month (lubridate Compatibility)
#'
#' See [lubridate::year()] and [lubridate::month()]
#'
#' @inheritParams get_year
#' @seealso [get_year]
#' @rdname year
#' @aliases month year
year.date_xx <- function(x){
  get_year(x)
}




# quarter -----------------------------------------------------------------

#' @rdname getters
#' @export
#' @examples
#' x <- date_yq(2016, 2)
#' get_quarter(x)
#' \dontrun{
#' library(lubridate)
#' quarter(x)
#' }
#'
get_quarter <- function(x){
  UseMethod("get_quarter")
}




#' @export
get_quarter.default <- function(x){
  as.integer(ceiling(get_month(x) / 3L))
}




#' @export
get_quarter.date_y <- function(x){
  stop("Not supported for date_y objects")
}




#' @export
get_quarter.date_yq <- function(x){
  as.integer(abs(x)) %% 10L
}




# month -------------------------------------------------------------------

#' @export
#' @rdname getters
#' @examples
#' x <- date_yq(2016, 2)
#' get_month(x)
#' \dontrun{
#' library(lubridate)
#' month(x)
#' }
get_month <- function(x){
  UseMethod("get_month")
}




#' @export
get_month.default <- function(x){
  as.POSIXlt(x, tz = tz(x))$mon + 1L
}




#' @export
get_month.date_y <- function(x){
  stop("Not supported for date_y objects")
}




#' @export
get_month.date_ym <- function(x){
  as.integer(as.integer(x) %% 100L)
}




#' @export
get_month.date_yq <- function(x){
  c(1L, 4L, 7L, 10L)[get_quarter(x)]
}




#' @inheritParams lubridate::month
#' @rdname year
#'
#'
#' @examples
#'
#' \dontrun{
#'   library(lubridate)
#'   month(x)
#'   month(x, label = TRUE)
#' }
month.date_xx <- function(
  x,
  label = FALSE,
  abbr = TRUE,
  locale = Sys.getlocale("LC_TIME")
){
  assert_namespace("lubridate")
  lubridate::month(get_month(x), label = label, abbr = abbr, locale = locale)
}




# week -------------------------------------------------------------------

#' @export
#' @rdname getters
#' @examples
#' x <- date_yw(2016, 2)
#' get_isoweek(x)
#'
get_isoweek <- function(x){
  UseMethod("get_isoweek")
}




# The ISO 8601 definition for week 01 is the week with the Gregorian year's
# first Thursday in it.
#' @export
get_isoweek.default <- function(x){
  get_isoweek(as_date_yw(x))
}




#' @export
get_isoweek.date_yw <- function(x){
  as.integer(x) %% 100L
}




#' @inheritParams lubridate::month
#' @rdname year
#'
#'
#' @examples
#'
#' \dontrun{
#'   library(lubridate)
#'   isoweek(x)
#' }
isoweek.date_xx <- get_isoweek




# isoyear -----------------------------------------------------------------

#' @export
#' @rdname getters
#' @examples
#' get_isoyear(as.Date("2018-01-01"))
#' get_isoyear(as.Date("2016-01-01"))
get_isoyear <- function(x){
  UseMethod("get_isoyear")
}




#' @export
get_isoyear.default <- function(x){
  x <- as.POSIXlt(x)
  date <- make_date(get_year(x), get_month(x), x$mday)
  wday <- x$wday
  date <- date + (4L - wday)
  jan1 <- make_date(get_year(date), 1L, 1L)
  get_year(jan1)
}




#' @export
get_isoyear.date_yw <- function(x){
  as.integer(x) %/% 100
}




# utils -------------------------------------------------------------------

get_isowday <- function(x){
  x <- as.POSIXlt(x)
  ifelse(x$wday == 0, 7L, x$wday)
}
