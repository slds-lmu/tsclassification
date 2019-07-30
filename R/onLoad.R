#' @import checkmate
#' @import rJava
#' @import R6
.onLoad = function(libname, pkgname) { # nocov start
  .jpackage(pkgname, morePaths = "inst/java/TimeSeriesClassification.jar", lib.loc = libname)
} # nocov stop
