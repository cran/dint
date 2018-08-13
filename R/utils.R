assert_lubridate <- function(x){
  if (!require_lubridate())
    stop(paste0(
      "This function requires the package 'lubridate'.",
      "You can install it via install.packages('lubridate')"
    ))
}




require_lubridate <- function(x){
  requireNamespace("lubridate", quietly = TRUE)
}





tz <- function(x){
  tzone <- attr(x, "tzone")[[1]]
  if (is.character(tzone) && nzchar(tzone)){
    tzone
  } else {
    "UTC"
  }
}




is_POSIXlt <- function(x){
  inherits(x, "POSIXlt")
}




make_date <- function(y, m, d){
  if (require_lubridate()){
    lubridate::make_date(y, m, d)
  } else {
    as.Date(ISOdate(y, m, d))
  }
}




substr_right <- function(x, n){
  nc <- nchar(x)
  substr(x, nc - n + 1, nc)
}




dyn_register_s3_method <- function(
  pkg,
  generic,
  class,
  fun = NULL
){
  stopifnot(is_scalar_character(pkg))
  stopifnot(is_scalar_character(generic))
  stopifnot(is_scalar_character(class))

  if (is.null(fun)) {
    fun <- get(paste0(generic, ".", class), envir = parent.frame())
  } else {
    stopifnot(is.function(fun))
  }

  if (pkg %in% loadedNamespaces()) {
    registerS3method(generic, class, fun, envir = asNamespace(pkg))
  }

  # Always register hook in case package is later unloaded & reloaded
  setHook(
    packageEvent(pkg, "onLoad"),
    function(...) {
      registerS3method(generic, class, fun, envir = asNamespace(pkg))
    }
  )
}




ifelse_simple <- function(x, true, false){
  assert(is.logical(x))
  assert(is_equal_length(x, true, false))
  assert(identical(class(true), class(false)))
  false[x] <- true[x]
  false
}