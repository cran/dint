context("arithmetic")


test_that("range.date_xx and min/max work", {
  q <- date_yq(2014, c(1, 1, 1, 1:4))
  m <- date_ym(2014, c(1, 1, 1, 1:12))
  w <- date_yw(2014, c(1, 1, 1, 1:52))
  y <- date_y(c(2014, 2014, 2015, 2015, 2015))

  expect_identical(range(q), date_yq(2014, c(1, 4)))
  expect_identical(range(m), date_ym(2014, c(1, 12)))
  expect_identical(range(w), date_yw(2014, c(1, 52)))
  expect_identical(range(y), date_y(2014:2015))

  expect_identical(min(q), date_yq(2014, 1))
  expect_identical(max(q), date_yq(2014, 4))

  expect_error(
    max(date_yq(2014, 1), date_ym(2014, 5)),
    "subclass"
  )
})




test_that("round.date_xx works", {

  x <- date_yq(2018, 1:4)

  expect_identical(floor(x), date_yq(2018, c(1, 1, 1, 1)))
  expect_identical(ceiling(x), date_yq(2019, c(1, 1, 1, 1)))
  expect_identical(round(x), date_yq(c(2018, 2018, 2019, 2019), 1))

  x <- date_ym(2018, 1:12)

  expect_identical(floor(x), date_ym(2018, rep(1, 12)))
  expect_identical(ceiling(x), date_ym(2019, rep(1, 12)))
  expect_identical(round(x), date_ym(c(rep(2018, 6), rep(2019, 6)), 1))

  x <- date_yw(2018, 1:53)

  expect_identical(floor(x), date_yw(2018, rep(1, 53)))
  expect_identical(ceiling(x), date_yw(2019, rep(1, 53)))
  expect_identical(round(x), date_yw(c(rep(2018, 26), rep(2019, 27)), 1))
})



test_that("comparison ops work", {
  for (ctor in list(date_yq, date_ym, date_yw)){
    for (op in list(`<`, `>`, `==`, `!=`, `<=`, `>=`)){
      q1 <- ctor(2014, 1)
      q2 <- ctor(2015, 1)
      expect_identical(op(q1, q2), op(as.integer(q1), as.integer(q2)))
      expect_identical(op(q1, q1), op(as.integer(q1), as.integer(q1)))
      expect_identical(op(q1, as.integer(q2)), op(as.integer(q1), as.integer(q2)))
      expect_identical(op(q1, as.integer(q1)), op(as.integer(q1), as.integer(q1)))
      expect_error(op(q1, as_date_y(q1)))
    }
  }
})




test_that("y+.date_ym works", {
  expect_identical(
    date_ym(2017, 1) %y+% 1,
    date_ym(2018, 1)
  )

  expect_identical(
    date_ym(2017, 1) %y-% 1,
    date_ym(2016, 1)
  )
})




test_that("y+.date_yq arithmetic works", {
  expect_identical(
    date_yq(2017, 1) %y+% 1,
    date_yq(2018, 1)
  )

  expect_identical(
    date_yq(2017, 1) %y-% 1,
    date_yq(2016, 1)
  )
})




test_that("+ works for date_xx", {
  expect_identical(
    date_yq(2017, 4) + 1,
    date_yq(2018, 1)
  )

  expect_identical(
    date_ym(2017, 12) + 1,
    date_ym(2018, 1)
  )

  expect_identical(
    date_yw(2017, 52) + 1:52,
    date_yw(2018, 1:52)
  )
})



test_that("- works for two date_xx", {

  for(i in 1:100){
    x <- random_date_xx(2, "date_yq")
    diff <- x[[1]] - x[[2]]
    sequence <- seq(x[[1]], x[[2]])
    expect_identical(abs(diff), length(sequence) - 1L)
    expect_identical(x[[2]] + diff, x[[1]])
  }


  for(i in 1:100){
    x <- random_date_xx(2, "date_ym")
    diff <- x[[1]] - x[[2]]
    sequence <- seq(x[[1]], x[[2]])
    expect_identical(abs(diff), length(sequence) - 1L)
    expect_identical(x[[2]] + diff, x[[1]])
  }

  for(i in 1:100){
    x <- random_date_xx(2, "date_yw")
    diff <- x[[1]] - x[[2]]
    sequence <- seq(x[[1]], x[[2]])
    expect_identical(abs(diff), length(sequence) - 1L)
    expect_identical(x[[2]] + diff, x[[1]])
  }


})







test_that("scalar dates are recycled for simple arithmethic operations (#5)",  {
  expect_identical(date_yq(2020, 1) + 2:4, as_date_yq(c(20203L, 20204L, 20211L)))
  expect_identical(date_yq(2020, 3) - 2:4, as_date_yq(c(20201L, 20194L, 20193L)))

  expect_identical(date_ym(2020, 1) + 2:4, as_date_ym(c(202003L, 202004L, 202005L)))
  expect_identical(date_ym(2020, 3) - 2:4, as_date_ym(c(202001L, 201912L, 201911L)))

  expect_identical(date_yw(2020, 1) + 2:4, as_date_yw(c(202003L, 202004L, 202005L)))
  expect_identical(date_yw(2020, 3) - 2:4, as_date_yw(c(202001L, 201952L, 201951L)))

  # only recyle if date is length 1 or equal length with the subtract vector
  expect_error(date_yw(2020, 2:5) - 2:3)
})
