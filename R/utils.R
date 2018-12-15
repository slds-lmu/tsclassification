#' Dump a data.frame to a .arff file.
#'
#' Saves a data.frame to an arff, so it can be used for the time-series
#' classifier.
#' @param data [`data.frame` | `character`] Either a `data.frame` containing
#'   the data, or the file path. In the latter case, nothing happens and the
#'   file path is only checked for consistency.
#' @param data_path [`character`] Path to save data to. If null, a
#'   temporary file is created.
#' @return The file path
#' @export
data_to_path = function(data, data_path = NULL) {
  # Data is either a path that poins to the data or a data.frame
  # containing the data.
  assert(check_string(data), check_data_frame(data), combine = "or")
  if(is.character(data)) {
    data_path = data
  }
  # Write the data.frame to a file
  # FIXME: How do we encode target column.
  if (is.data.frame(data)) {
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
#' Transforms `list(a = "5")` to a string "a = 5".
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

# Return all possible classifiers.
get_tsc_classifier_names = function() {
  c("WeightedEnsemble","FixedIntervalForest","J48","NaiveBayes",
    "SMO","SMO","BayesNet","MultilayerPerceptron","OptimisedRotationForest",
    "Logistic","NN_CID","LearnShapelets","FastShapelets","ST_Ensemble",
    "DTW_1NN","DTW_1NN","DD_DTW","DTD_C","TSF","ACF_Ensemble","PS_Ensemble",
    "TSBF","BagOfPatterns","BOSSEnsemble","SAXVSM","LPS")
}
