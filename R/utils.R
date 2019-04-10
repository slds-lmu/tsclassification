#' Dump a data.frame to a .arff file.
#'
#' Saves a data.frame to an arff, so it can be used for the time-series
#' classifier.
#' @param data [`data.frame` | `character`] \cr
#'   Either a `data.frame` containing the data, or the file path.
#'   In the latter case, nothing happens and the file path is only checked for consistency.
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
  if (is.character(data)) {
    data_path = assert_file_exists(data)
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

#' Delete a file.
#'
#' @param data_path [`character`] Path to save data to. If null, a
#'   temporary file is created.
#' @return NULL
delete_data_from_path = function(data_path) {
  file.remove(data_path)
}

#' Flatten a list of parameter values to a single string
#'
#' Transforms e.g. `list(a = "5")` to a string "a = 5".
#' Multiple elements are concatenated using a ','.
#' @param par_vals [`list`] Parameter values.
#' @return [`character`]
par_vals_to_string = function(par_vals) {
  assert_list(par_vals, null.ok = TRUE, names = "named")
  if (length(par_vals) == 0) {
    pv = ""
  } else {
    pv = unlist(par_vals)
    pv = paste0(names(pv), "=", pv, collapse = ",")
  }
  return(pv)
}


#' Return available classifiers
#'
#' Run `tsc_classifiers()` to obtain available classifiers.
#'
#' The following classifiers are available: \cr
#' **Ensemble Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN` \cr
#'     Elastic Ensemble of Nearest Neighbour Algorithms \cr
#'     Hyperparameters: *None*
#'
#'   \item `timeseriesweka.classifiers.FlatCote` \cr
#'    Collective of Transformation Ensembles (Bagnall et al.,2015) \cr
#'    Hyperparameters: *None*
#'
#'   \item `timeseriesweka.classifiers.ElasticEnsemble` \cr
#'    Combination of nearest neighbour (NN) classifiers that use elastic distance measures \cr
#'    Hyperparameters: *None*
#' }
#'
#' **Dictionary based Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.BOSS` \cr
#'   Bag of SFA Symbols
#'   Hyperparameters:
#'   \itemize{
#'     \item `setMaxEnsembleSize`: integer(1)
#'   }
#' }
#'
#' **Shapelet based Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.ShapeletTransformClassifier` \cr
#'   Shapelet transformation that separates the shapelet discovery from the classifier by
#'   finding the top k shapelets in a single run \cr
#'   Hyperparameters:
#'   \itemize{
#'     \item `setTransformType`: character(1) \cr
#'       values: univariate,uni,shapeletd,shapeleti
#'     \item `setNumberOfShapelets`: integer(1)
#'   }
#' }
#'
#' **Interval based Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.TSF` \cr
#'   Time Series Forest (Deng et al.,2013) \cr
#'   Hyperparameters:
#'   \itemize{
#'     \item `setNumTrees`: integer(1)
#'   }
#' }
#'
#' **Time-Series Classifiers**
#' \itemize{
#'   \item timeseriesweka.classifiers.LearnShapelets \cr
#'     Learned Shapelets (Grabocka et al., 2014) \cr
#'     Hyperparameters:
#'   \item timeseriesweka.classifiers.NN_CID \cr
#'
#' }
#'
#' **Weka-based Classifiers**
#' Several WEKA classifiers have been implemented in the Time-Series Classification
#' Bake-off. The use of those classifiers is discouraged from within TSClassification,
#' but nonetheless implemented for completeness.
#' We advise to use the official implementations from package [RWeka] for greater
#' flexibility and improved support for setting hyperparameters. \cr
#' \itemize{
#'   \item weka.classifiers.functions.Logistic
#'   \item weka.classifiers.bayes.BayesNet
#'   \item weka.classifiers.bayes.NaiveBayes
#'   \item weka.classifiers.functions.Logistic
#'   \item weka.classifiers.functions.MultilayerPerceptron
#'   \item weka.classifiers.functions.SMO
#'   \item weka.classifiers.meta.RotationForest
#'   \item weka.classifiers.trees.J48
#'   \item weka.classifiers.trees.RandomForest
#' }
#'
#' @return [`character`]
#' @export
tsc_classifiers = function() {
    c(
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN",
      "timeseriesweka.classifiers.FastShapelets",
      "timeseriesweka.classifiers.BOSS",
      "timeseriesweka.classifiers.LearnShapelets",
      "timeseriesweka.classifiers.NN_CID",
      "timeseriesweka.classifiers.TSBF",
      "timeseriesweka.classifiers.TSF",
      "timeseriesweka.classifiers.DTD_C",
      "timeseriesweka.classifiers.RISE",
      "timeseriesweka.classifiers.LPS",
      "timeseriesweka.classifiers.SAXVSM",
      # "timeseriesweka.classifiers.ShapeletTransformClassifier", # broken
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

#' Check whether classifier name is valid. (Case-insensitive)
#' In case only a substring is given, returns the full name
#' of the classifier.
#'
#' @param classifier [`character`] \cr
#'   Classifier from tsc_classifiers() or short identifier (substring).
#' @return [`character`]
check_classifier = function(classifier) {
  avail = tsc_classifiers()
  # Allow for substrings
  clf = avail[grepl(tolower(classifier), tolower(avail), fixed = TRUE)]
  if (length(clf) == 0) stop(sprintf("Classifier %s not available!", classifier))
  if (length(clf) >  2) stop(sprintf("Classifier %s is ambigous! Please supply an unambigous identifier!", classifier))
  return(clf)
}
