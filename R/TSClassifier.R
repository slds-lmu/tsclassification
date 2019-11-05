##' Time Seriess Classifier
#'
#' Allows training and predicting on time-series classification data.
#' Internally writes the data to an `.arff` file and reads it from
#' the command line in the Java Virtual Machine.
#' In some cases, the memory of the JVM is not sufficient.
#' In this case, the memory for the JVM can be set e.g. to 2 GB by setting
#' `options(java.options = "-Xmx2048m")` before loading the package.
#'
#' @details
#' Expects the data to either be a [`data.frame`] or a [`character`] path to a
#' data set in the **'.arff'** format. In case a `data.frame` is provided, the
#' data is saved to '.$model_path' and then read into the JVM from there.
#' The target variable's name is assumed to be 'target'.
#'
#' @section Methods:
#'   * new(classifier, model_path): Initialize the class.
#'   * train(data, target, par_vals, data_path): Delegates to \code{\link{train_tsc}}.
#'   * predict(newdata): Delegates to \code{\link{predict_tsc}}.
#'   * resample(data, target, par_vals, data_path): Delegates to \code{\link{resample_tsc}}.
#'   * cleanup(): Remove saved model files.
#'
#' @section Fields:
#'   * classifier: `character(1)` \cr
#'     Classifier to use, see `?tsc_classifiers` for a list of available classifiers.
#'   * target: `character(1)` \cr
#'     Target variable.
#'   * data: `character(1)` | [`data.frame`] \cr
#'     Either a path to the dataset or a data.frame that should be saved to disk
#'     for modeling. In case a `data.frame` is provided, the dataset is saved to disk
#'     via `data_to_path`.
#'   * newdata: `character(1)` | [`data.frame`] \cr
#'     Data to predict on. See `data`.
#'   * par_vals: [`list`] \cr
#'     Named list of hyperparamter_values.
#'   * data_path: `character(1)` \cr
#'     Save path for the data.
#'   * target_levels: [`character`] \cr
#'     Levels of the target variable, if a data.frame is supplied.
#'   * model_path: `character(1)` \cr
#'     Path to store the resulting model to. Default `NULL` creates and stores to
#'     a temporary file.
#'   * trained: `logical(1)` \cr
#'     Was the model trained?
#'
#' @examples
#'   data = data.frame(matrix(rnorm(300), nrow = 30))
#'   data$class = factor(sample(letters[1:2], 10, replace = TRUE))
#'   tsc = TSClassifier$new("timeseriesweka.classifiers.BOSS")
#'   tsc$train(data[1:15,], target = "class", par_vals = list(setMaxEnsembleSize = 1))
#'   p = tsc$predict(data[10:20,])
#' @export
TSClassifier = R6::R6Class("TSClassifier",
  public = list(
    classifier = NULL,
    model_path = NULL,
    target = NULL,
    par_vals = NULL,
    data_path = NULL,
    target_levels = NULL,
    trained = FALSE,

    initialize = function(classifier, model_path = NULL) {
      self$classifier = check_classifier(classifier)
      if (is.null(model_path))
        model_path = tempfile(pattern = "tsc_model_", fileext = ".txt")
      self$model_path = assert_path_for_output(model_path)
      .jaddLibrary('TimeSeriesClassification', "inst/java/TimeSeriesClassification.jar")
      .jaddClassPath("inst/java/TimeSeriesClassification.jar")
    },
    train = function(data, target = NULL, par_vals = NULL, data_path = NULL) {
      self$target = target
      self$par_vals = par_vals
      if (is.data.frame(data)) self$target_levels = levels(factor(data[[target]]))

      train_tsc(data, self$target, self$classifier, self$par_vals, self$model_path)
      self$trained = TRUE
      invisible(self)
    },
    predict = function(newdata) {
      if (!self$trained)
        stop("Classifier has not been trained, please call 'train()'")
      p = predict_tsc(newdata, self$target, self$model_path)
      if (!is.null(self$target_levels)) p = factor(p, labels = self$target_levels[unique(p) + 1])
      return(factor(p))
    },
    resample = function(data, target = NULL, par_vals = NULL, data_path = NULL) {
      self$target = target
      self$par_vals = par_vals
      if (is.data.frame(data)) self$target_levels = levels(factor(data[[target]]))
      resample_tsc(data, self$target, self$classifier, self$par_vals, self$model_path)
      self$trained = TRUE
      invisible(self)
    },
    print = function() {
      cat("TimeSeries Classifier Object\n")
      cat("Classifier:", self$classifier, "\n")
      cat("Methods: .$train(data), .$predict(newdata)\n")
      cat("Models saved to: ", self$model_path, "\n")
      cat("Status:", ifelse(self$trained, "Trained", "Untrained"), "\n")
    },
    cleanup = function() {
      if (file.exists(self$model_path)) file.remove(self$model_path)
    }
  )
)

#' Train a time-series classifier
#'
#' Set the "java.options" option to use a higher memory
#' if required (e.g. `"-Xmx2048m"`).
#' @param data `character(1)` | [`data.frame`] \cr
#'   Either a path to the dataset or a data.frame that should be saved to disk
#'   for modeling. In case a `data.frame` is provided, the dataset is saved to disk
#'   via `data_to_path`.
#' @param target `character(1)` \cr
#'   Name of the target variable.
#' @param classifier `character(1)` \cr
#'   Character describing the classifier. See `?tsc_classifiers`.
#' @param par_vals [`list`] \cr
#'   (Optional) Hyperparameters for the models. \cr
#'   See `?tsc_classifiers` for hyperparameters.
#' @param model_path `character(1)` \cr
#'   Path where the resulting model should be saved to.
#' @param data_path `character(1)` \cr
#'   Path where train and test data should be saved to. Defaults to a temporary file.
#' @param cleanup_data `logical(1)` \cr
#'   Should the data be deleted from disk after training / prediction?
#' @return NULL, Writes a Java instance of TrainAndPredict to `model_path`.
#' @examples
#'   data = data.frame(matrix(rnorm(300), nrow = 30))
#'   data$class = factor(sample(letters[1:2], 10, replace = TRUE))
#'   model_path = tempfile()
#'   train_tsc(data, target = "class", classifier = "weka.classifiers.trees.J48",
#'     model_path = model_path)
#' @export
train_tsc = function(data, target = NULL, classifier, par_vals = NULL, model_path = NULL,
  data_path = NULL, cleanup_data = FALSE) {
  data = data_to_path(data, target, data_path)
  classifier = check_classifier(classifier)
  assert_string(model_path)
  assert_flag(cleanup_data)
  # Initialize Java
  trainAndPredict = .jnew("timeseries_classification.TrainAndPredict")
  # Set up the call to the .jar
  par_vals = par_vals_to_string(par_vals)
  args_train = c(data, model_path, classifier, "0")
  if(par_vals != "") args_train = c(args_train, par_vals)
  J(trainAndPredict, "train", args_train)
  # Handle errors and clean up
  if (!is.null(e<-.jgetEx())) stop("Error during training!")
  if (cleanup_data & !is.null(data_path)) file.remove(data)
  invisible(NULL)
}

#' Predict using a TrainAndPredict Object.
#'
#' Predicts `newdata` using the model obtained during training.
#'
#' @param newdata `character(1)` | [`data.frame`] \cr
#'   Either a `data.frame` containing
#'   the data, or a file path to data used for prediction.
#' @param target `character(1)` \cr
#'   Name of the target variable. Can be `NULL`.
#' @param model_path `character(1)` \cr
#'   Path where the prediction model should be obtained from.
#' @param data_path `character(1)` \cr
#'   Path where train and test data should be saved to. Defaults to a temporary file.
#' @param cleanup_data `logical(1)` \cr
#'   Should newdata be deleted from disk after training?
#' @return [`factor`] Vector of predictions.
#' @examples
#'   data = data.frame(matrix(rnorm(300), nrow = 30))
#'   data$class = factor(sample(letters[1:2], 10, replace = TRUE))
#'   model_path = tempfile()
#'   train_tsc(data, target = "class", classifier = "weka.classifiers.trees.J48",
#'     model_path = model_path)
#'   predict_tsc(data, target = "class", model_path = model_path)
#' @export
predict_tsc = function(newdata, target = NULL, model_path, data_path = NULL, cleanup_data = FALSE) {
  # Save newdata in case
  newdata = data_to_path(newdata, target, data_path, step = "predict")
  assert_file_exists(model_path)
  assert_flag(cleanup_data)
  trainAndPredict = .jnew("timeseries_classification.TrainAndPredict")
  args_predict = c(model_path, newdata)
  # Predict
  preds = J(trainAndPredict, "predict", args_predict)
  if (!is.null(e<-.jgetEx())) stop("Error during prediction!")
  if (cleanup_data & !is.null(data_path)) file.remove(newdata)
  return(preds)
}

#' Resample a time-series classifier.
#' Can be used to replicate the benchmark in the Time-Series Classification Bake-Off by Bagnall et al. 2017
#' Currently prints out the resampling accuracy.
#'
#' @param data `character(1)` | [`data.frame`] \cr
#'   Either a path to the dataset or a data.frame that should be saved to disk
#'   for modeling. In case a `data.frame` is provided, the dataset is saved to disk
#'   via `data_to_path`.
#' @param target `character(1)` \cr
#'   Name of the target variable.
#' @param classifier `character(1)` \cr
#'   Character describing the classifier. See `?tsc_classifiers`.
#' @param par_vals [`list`] \cr
#'   (Optional) Hyperparameters for the models. \cr
#'   See `?tsc_classifiers` for hyperparameters.
#' @param model_path `character(1)` \cr
#'   Path where the resulting model should be saved to.
#' @param data_path `character(1)` \cr
#'   Path where train and test data should be saved to. Defaults to a temporary file.
#' @param cleanup_data `logical(1)` \cr
#'   Should the data be deleted from disk after training / prediction?
#' @return NULL, Writes a Java instance of TrainAndPredict to `model_path`.
#' @examples
#' \dontrun{
#'   data = data.frame(matrix(rnorm(300), nrow = 30))
#'   data$class = factor(sample(letters[1:2], 10, replace = TRUE))
#'   resample_tsc(data, target = "class", classifier = "weka.classifiers.trees.J48", model_path = tempfile())
#' }
#' @export
resample_tsc = function(data, target = NULL, classifier, par_vals = NULL, model_path = NULL,
  data_path = NULL, cleanup_data = FALSE) {
  data = data_to_path(data, target, data_path)
  classifier = check_classifier(classifier)
  assert_path_for_output(model_path)
  # Initialize Java
  trainAndPredict = .jnew("timeseries_classification.TrainAndPredict")
  # Set up the call to the .jar
  par_vals = par_vals_to_string(par_vals)
  args_train = c(data, model_path, classifier, "1")
  if(par_vals != "") args_train = c(args_train, par_vals)
  J(trainAndPredict, "train", args_train)
  if (!is.null(e<-.jgetEx())) stop("Error during training!")
  if (cleanup_data & !is.null(data_path)) file.remove(data)
  invisible(NULL)
}
