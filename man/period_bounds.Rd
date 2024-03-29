% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/predicates.R
\name{is_quarter_bounds}
\alias{is_quarter_bounds}
\alias{is_first_of_quarter}
\alias{is_last_of_quarter}
\alias{is_year_bounds}
\alias{is_first_of_year}
\alias{is_last_of_year}
\alias{is_Date}
\alias{is_POSIXlt}
\title{Useful Predicates for Dates}
\usage{
is_quarter_bounds(first, last)

is_first_of_quarter(x)

is_last_of_quarter(x)

is_year_bounds(first, last)

is_first_of_year(x)

is_last_of_year(x)

is_Date(x)

is_POSIXlt(x)
}
\arguments{
\item{x, first, last}{\code{Date} vectors}
}
\value{
a \code{logical} vector
}
\description{
\code{is_first_of_quarter()}, \code{is_last_of_quarter()}, \code{is_first_of_year()} and
\code{is_last_of_year()} check whether a \code{Date} is the first or respectively the
last day of a quarter/year. \code{is_quarter_bounds()} and \code{is_year_bounds} checks
whether two \code{Date} vectors mark the bounds of (the same) quarters
}
\examples{
x <- as.Date(c("2018-01-01", "2018-03-31", "2018-02-14"))
is_first_of_year(x)
is_first_of_quarter(x)
is_last_of_quarter(x)
is_quarter_bounds(x[[1]], x[[2]])
is_quarter_bounds(x[[2]], x[[3]])

}
