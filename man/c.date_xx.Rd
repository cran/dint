% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/date_xx.R
\name{c.date_xx}
\alias{c.date_xx}
\title{Concatenate date_xx Objects}
\usage{
\method{c}{date_xx}(...)
}
\arguments{
\item{...}{\code{date_yq}, \code{date_ym}, \code{date_yw} or \code{date_y} vectors. All inputs
must be of the same type (or its unclassed integer equivalent) or faulty
output is to be expected}
}
\value{
a vector of the same \code{date_xx} subclass as the first element of \code{...}
}
\description{
Concatenate date_xx Objects
}
\examples{

c(date_yq(2000, 1:2), date_yq(2000, 3:3))

# raises an error
try(c(date_yq(2000, 1:2), date_ym(2000, 1:12)))

}
