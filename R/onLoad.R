.onLoad = function(libname, pkgname) {
  packageStartupMessage(sprintf("loading jar from %s", libname))
  jar_rel_path = "inst/java/TimeSeriesClassification.jar"
  jar_abs_path = file.path(libname, pkgname, jar_rel_path)  # libname is the directory beyond where the package lies
  .jpackage(pkgname, morePaths = jar_abs_path, lib.loc = libname)
}
