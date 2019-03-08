#' Time Seriess Classifier
#'
#' Allows training and predicting on time-series classification data.
#' Internally writes the data to an `.arff` file and reads them from
#' the command line in the Java Virtual Machine.
#' In some cases, the memory of the JVM is not sufficient.
#' In this case, the memory for the JVM can be set to 2 GB by setting
#' `options(java.options = "-Xmx2048m")` before loading the package.
#' Members:
#'   - train(data, par_vals): Delegates to [train_tsc]
#'   - predict(newdata):      Delegates to [predict_tsc]
#'   - cleanup():             Remove saved model files.
#' @param classifier [`character(1)`] \cr
#'   Classifier to use, see `?tsc_classifiers` for a list of available classifiers.
#' @param model_path [`character(1)`] \cr
#'   Path to store the resulting model to. Default `NULL` creates a temporary file.
#'
#' @export
TSClassifier = R6::R6Class("TSClassifier",
  public = list(
    classifier = NULL,
    model_path = NULL,
    trained = FALSE,
    initialize = function(classifier, model_path = NULL) {
      # assert_choice("classifier", tsc_classifiers())
      self$classifier = classifier
      if (is.null(model_path))
        model_path = tempfile(pattern = "tsc_model", fileext = ".txt")
      self$model_path = assert_path_for_output(model_path)
    },
    train = function(data, par_vals = NULL) {
      train_tsc(data, self$classifier, par_vals, self$model_path)
      self$trained = TRUE
    },
    predict = function(newdata) {
      if (!self$trained)
        stop("Classifier has not been trained, please call 'train()'")
      predict_tsc(newdata, self$model_path)
    },
    print = function() {
      cat("TimeSeries Classifier Object\n")
      cat("Classifier:", self$classifier, "\n")
      cat("Methods: .$train(data), .$predict(newdata)\n")
      cat("Models are saved to ", self$model_path, "\n")
      cat("Status:", ifelse(self$trained, "Trained", "Untrained"), "\n")
    },
    clean = function() {
      if (file.exists(self$model_path)) file.remove(self$model_path)
    }
  )
)

#' Train a time-series classifier
#'
#' Set the "java.options" option to use a higher memory
#' if required (e.g. `"-Xmx2048m"`).
#' @param data [`character(1)`|`data.frame`] \cr
#'   Either a path to the dataset or a data.frame that should be saved to disk
#'   for modeling. In case a `data.frame` is provided, the dataset is saved to disk
#'   via `data_to_path`.
#' @param classifier [`character(1)`] \cr
#'   Character describing the classifier.
#' @param par_vals [`list`] \cr
#'   (Optional) Hyperparameters for the models. Currently not used.
#' @param model_path [`character(1)`] \cr
#'   Path where the resulting model should be saved.
#' @param cleanup_data [`logical(1)`] \cr
#'   Should the data be deleted from disk after training?
#' @return NULL, Writes a Java instance of TrainAndPredict to model_path
#' @export
train_tsc = function(data, classifier, par_vals, model_path, cleanup_data = FALSE) {
  data = data_to_path(data)
  # Initialize Java
  .jaddClassPath(path = "inst/java/TimeSeriesClassification.jar")
  trainAndPredict = .jnew("timeseries_classification.TrainAndPredict")
  # Set up the call to the .jar
  par_vals = par_vals_to_string(par_vals)
  args_train = c(data, model_path, classifier, "0", par_vals)
  J(trainAndPredict, "train", args_train)
  if (cleanup_data) file.remove(data)
  invisible(NULL)
}

#' Predict using a TrainAndPredict Object.
#'
#' Predicts newdata using the model obtained
#'
#' @param newdata [`data.frame` | `character`] \cr
#'   Either a `data.frame` containing
#'   the data, or the file path. In the latter case, nothing happens and the
#'   file path is only checked for consistency.
#' @param model_path [`character(1)`] \cr
#'   Path where the prediction model should be obtained from.
#' @param cleanup_data [`logical(1)`] \cr
#'   Should newdata be deleted from disk after training?
#' @return A vector of predictions
#' @export
predict_tsc = function(newdata, model_path, cleanup_data = FALSE) {
  assert_true(file.exists(model_path))
  # Save newdata in case
  newdata = data_to_path(newdata)
  # Init Java
  .jaddClassPath(path = "inst/java/TimeSeriesClassification.jar")
  trainAndPredict = .jnew("timeseries_classification.TrainAndPredict")
  args_predict = c(model_path, newdata)
  # Predict
  preds = J(trainAndPredict, "predict", args_predict)
  if (cleanup_data) file.remove(data)
  return(preds)
}
