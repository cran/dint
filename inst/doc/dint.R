## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(dint)

## ------------------------------------------------------------------------

# date_* Objects can be created using explicit constructors...
date_yq(2015, 1)
date_ym(c(2015, 2016), c(1, 2))


# ...or through coercion of dates or integers
as_date_yq(Sys.Date())
as_date_yq(20141)   # the last digit is interpreted as quarter
as_date_ym(201412)  # the last two digits are interpreted as month



## ------------------------------------------------------------------------

# You can coerce dates to any date_xx object with as_date_**
d <- as.Date("2018-05-12")
as_date_yq(d)
as_date_ym(d)
as_date_y(d)


# Conversely, you can convert date_xx objects back to the various R Date formats
q <- date_yq(2015, 1)
as.Date(q)
as.POSIXlt(q)


# as.POSIXct creates datetimes in UTC/GMT, so the result might not always be as
# expected, depending on your local timezone.
as.POSIXct(q)
as.POSIXct(q, tz = "GMT")
print(as.POSIXct(q), tz = "GMT")
print(as.POSIXct(q), tz = "CET")


## ------------------------------------------------------------------------
# Quarters
q <- date_yq(2014, 4)
q
q + 1
seq(q -2, q + 2)


# Months
m <- date_ym(2014, 12)
m
m + 1
seq(m -2, m + 2)


## ------------------------------------------------------------------------
q <- date_yq(2014, 4)
get_year(q)
get_quarter(q)
get_month(q) # defaults to first month of quarter


m <- date_ym(2014, 12)
get_year(m)
get_quarter(m)
get_month(m)

## ------------------------------------------------------------------------
stopifnot(requireNamespace("lubridate"))

lubridate::year(q)
lubridate::quarter(q)
lubridate::month(q)


## ------------------------------------------------------------------------
q <- date_yq(2015, 1)
first_day_of_quarter(q)  # the same as as.Date(q), but more explicit
last_day_of_quarter(q)  # the same as as.Date(q), but more explicit


# These functions work with normal dates
d <- as.Date("2018-05-12")
first_day_of_quarter(d)
last_day_of_quarter(d)
first_day_of_month(d)
last_day_of_month(d)
first_day_of_year(d)
last_day_of_year(d)


# Alternativeley you can also use these:
first_day_yq(2012, 2)
last_day_ym(2012, 2)
last_day_y(2012)


## ------------------------------------------------------------------------
q <- date_yq(2014, 4)
format(q, "iso")  # default
format(q, "short")
format(q, "shorter")


m <- date_ym(2014, 12)
format(m, "iso")  # default
format(m, "short")
format(m, "shorter")

## ------------------------------------------------------------------------
library(ggplot2)

x <- data.frame(
  time  = seq(as.Date("2016-01-01"), as.Date("2016-08-08"), by = "day")
)

x$value <- rnorm(nrow(x))

p <- ggplot(
  x,
  aes(
    x = time, 
    y = value)
  ) + geom_point()


print(p)
print(p + scale_x_date(labels = format_date_yq_iso))
print(p + scale_x_date(labels = format_date_ym_short))


