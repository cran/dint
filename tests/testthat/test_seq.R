context("seq and rep")

# 2007 starts on jan 1st
# 2008 is a leaop year
# 2009 has 53 weeks
# 2010 is a gernic year without special properties


# seq ---------------------------------------------------------------------

test_that("seq.date_yw works", {
  x <- seq(date_yw(2007, 1), date_yw(2010, 52))
  expect_identical(
    as.integer(x),
    c(200701:200752, 200801:200852, 200901:200953, 201001:201052)
  )

  tdat  <- date_yw(c(2002, 2020), c(50, 2))
  tdat2 <- date_yw(c(2002, 2020), c(50, 50))

  expect_identical(
    seq(tdat[1], tdat[2]),
    as_date_yw(seq(as.Date("2002-12-10"), as.Date("2020-01-07"), by = "7 days"))
  )

  expect_identical(
    seq(tdat[1], tdat[2], by = 3),
    as_date_yw(seq(as.Date("2002-12-10"), as.Date("2020-01-07"), by = "21 days"))
  )
})




test_that("seq.date_yq works", {
  x <- as_date_yq(c(20072, 20093))

  expect_identical(
    seq(x[1], x[2]),
    as_date_yq(c(20072:20074, 20081:20084, 20091:20093))
  )

  expect_identical(
    seq(x[1], x[2], by = 2),
    as_date_yq(c(20072L, 20074L, 20082L, 20084L, 20092L))
  )

  expect_identical(
    seq(x[1], x[2], by = 3),
    as_date_yq(c(20072L, 20081L, 20084L, 20093L))
  )

  expect_identical(
    seq(x[1], x[2], by = 4),
    as_date_yq(c(20072L, 20082L, 20092L))
  )

  expect_identical(
    seq(x[1], x[2], by = 5),
    as_date_yq(c(20072L, 20083L))
  )


  # reverse
  expect_identical(
    seq(x[2], x[1], by = 3),
    as_date_yq(rev(c(20072L, 20081L, 20084L, 20093L)))
  )

  # invalid inputs
  expect_error(
    seq(x[2], x[1], by = -3)
  )

  expect_error(
    seq(x[2], x[1], by = 1.2)
  )
})




test_that("seq.date_ym works", {
  x <- as_date_ym(c(200706, 200910))
  eres <- as_date_ym(c(200706:200712, 200801:200812, 200901:200910))

  expect_identical(
    seq(x[1], x[2]),
    eres
  )

  expect_identical(
    seq(x[1], x[2], by = 2),
    eres[c(TRUE, FALSE)]
  )

  expect_identical(
    seq(x[1], x[2], by = 3),
    eres[c(TRUE, FALSE, FALSE)]
  )

  expect_identical(
    seq(x[1], x[2], by = 4),
    eres[c(TRUE, FALSE, FALSE, FALSE)]
  )

  expect_identical(
    seq(x[1], x[2], by = 5),
    eres[c(TRUE, FALSE, FALSE, FALSE, FALSE)]
  )

  # reverse
  expect_identical(
    seq(x[2], x[1], by = 3),
    rev(eres)[c(TRUE, FALSE, FALSE)]
  )

  # invalid inputs
  expect_error(
    seq(x[2], x[1], by = -3)
  )

  expect_error(
    seq(x[2], x[1], by = 1.2)
  )
})




test_that("seq.date_ym works", {
  # test corner cases, normal case are tested above

  expect_error(
    seq_date_xx(
      date_yq(integer(), integer()),
      date_yq(integer(), integer()),
      by = 1,
      base = 4L,
      ctor = date_yq
    ),
    "scalar"
  )

  expect_error(
    seq_date_xx(
      date_yq(NA_integer_, NA_integer_),
      date_yq(2018, 1),
      by = 1,
      base = 4L,
      ctor = date_yq
    ),
    "positive"
  )

  expect_error(
    seq_date_xx(date_yq(-10, 3), date_yq(-8, 2), by = 1, base = 4L, ctor = date_yq),
    "positive"
  )
})




# rep ---------------------------------------------------------------------

test_that("rep.date_xx and min/max work", {

  expect_identical(
    rep(date_yq(2016, 1), 5),
    as_date_yq(rep(20161, 5))
  )

  expect_identical(
    rep(date_ym(2016, 1), times = 5),
    as_date_ym(rep(201601, times = 5))
  )

  expect_identical(
    rep(date_yw(2016, 1:2), each = 5),
    as_date_yw(rep(201601:201602, each = 5))
  )

  expect_true(
    length(rep(date_yq(2016, 1:2), length.out = 6)) == 6
  )

})

