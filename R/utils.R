#' Dump a data.frame to a .arff file.
#'
#' Saves a data.frame to an arff, so it can be used for the time-series
#' classifier.
#' @param data [`data.frame` | `character`] \cr
#'   Either a `data.frame` containing
#'   the data, or the file path. In the latter case, nothing happens and the
#'   file path is only checked for consistency.
#' @param target [`character`] \cr
#'   Target variable.
#' @param data_path [`character`] Path to save data to. If null, a
#'   temporary file is created.
#' @return The file path
#' @export
data_to_path = function(data, target = "target", data_path = NULL) {
  # Data is either a path that poins to the data or a data.frame
  # containing the data.
  assert(check_string(data), check_data_frame(data), combine = "or")
  if(is.character(data)) {
    data_path = data
  }
  # Write the data.frame to a file.
  if (is.data.frame(data)) {
    # Make sure target var is the last column.
    cn = colnames(data)
    assert_choice(target, cn)
    data = data[, c(setdiff(cn, target), target)]
    data[[target]] = as.factor(data[[target]])

    # Create a filepath.
    if (is.null(data_path))
      data_path = tempfile(pattern = "data_train", fileext = ".arff")
    if (file.exists(data_path)) {
      warning(sprintf("File %s already exists, will not be overwritten!", data_path))
    } else {
      farff::writeARFF(data, data_path)
    }
  }
  return(data_path)
}

#' Delete a .arff file.
#'
#' @param data_path [`character`] Path to save data to. If null, a
#'   temporary file is created.
#' @return NULL
#' @export
delete_data_from_path = function(data_path) {
  file.remove(data_path)
}

#' Flatten a list of parameter values to a single string
#'
#' Transforms e.g. `list(a = "5")` to a string "a = 5".
#' Multiple elements are concatenated using a ','.
#' @param par.vals [`list`] Parameter values.
#' @return [`character`]
par_vals_to_string = function(par.vals) {
  assert_list(par.vals, null.ok = TRUE)
  if (length(par.vals) == 0) {
    pv = ""
  } else {
    pv = unlist(par.vals)
    paste0(names(pv), "=", pv, collapse = ",")
  }
  return(pv)
}


#' Return a vector of available classifiers
#'
#' @return [`character`]
#' @export
list_classifiers = function() {
    c(
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN",
      # "timeseriesweka.classifiers.FastShapelets", # broken
      "timeseriesweka.classifiers.LearnShapelets",
      "timeseriesweka.classifiers.NN_CID",
      "timeseriesweka.classifiers.TSBF",
      "timeseriesweka.classifiers.TSF",
      "timeseriesweka.classifiers.DTD_C",
      "timeseriesweka.classifiers.BOSS",
      "timeseriesweka.classifiers.RISE",
      "timeseriesweka.classifiers.LPS", # slow
      "timeseriesweka.classifiers.SAXVSM",
      "timeseriesweka.classifiers.ShapeletTransformClassifier",
      "timeseriesweka.classifiers.DD_DTW",
      "timeseriesweka.classifiers.BagOfPatterns",
      "weka.classifiers.bayes.BayesNet",
      "weka.classifiers.bayes.NaiveBayes",
      "weka.classifiers.functions.Logistic",
      "weka.classifiers.functions.MultilayerPerceptron",
      "weka.classifiers.functions.SMO",
      "weka.classifiers.meta.RotationForest",
      # "vector_classifiers.CAWPE", # broken
      "weka.classifiers.trees.J48",
      "weka.classifiers.trees.RandomForest"
    )
}
