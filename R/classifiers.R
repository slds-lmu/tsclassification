#' Time Seriess Classifier
#'
#' Allows training and predicting on time-series classification data.
#' Members:
#'   - train()
#'   - predict()
#' @export
TSClassifier = R6::R6Class("TSClassifier",
  public = list(
    data = NULL,
    classifier = NULL,
    model_path = NULL,
    trained = FALSE,
    initialize = function(data = NULL, classifier, model_path = NULL) {
      # assert_choice("classifier", get_tsc_classifier_names())
      self$data = data_to_path(data)
      self$classifier = classifier
      if(is.null(model_path))
        self$model_path = tempfile(pattern = "tsc_model", fileext = ".txt")
      assert_path_for_output(self$model_path)
    },
    train = function(par.vals = NULL) {
      train_tsc(self$classifier, self$data, par.vals, self$model_path)
      self$trained = TRUE
      },
    predict = function(newdata) {
      if(!self$trained)
        stop("Classifier has not been trained, please call 'train()'")
      predict_tsc(self$model_path, newdata)
    }
  )
)

#' Train a time-series classifier
#'
#' Retrieve a Java instance of SpellCorrector, with the training file
#' specified. Language model is trained before the instance is returned.
#' The spell corrector is adapted from Peter Norvig's demonstration.
#'
#' @param classifier Character describing the classifier.
#' @param filepath Path to the dataset.
#' @param par.vals (Optional) Hyperparameters for the models. Currently not used.
#' @param model.path Path where the resulting model should be saved.
#' @return a Java instance of TrainAndPredict
#' @export
train_tsc = function(classifier, data, par.vals, model.path) {
  data = data_to_path(data)
  # Initialize Java
  .jinit()
  .jaddClassPath(path = "inst/java/TimeSeriesClassification.jar")
  trainAndPredict = .jnew("myimpl.TrainAndPredict")
  # Set up the call to the .jar
  par.vals = par_vals_to_string(par.vals)
  args_train = c(data, model.path, classifier, par.vals)
  J(trainAndPredict, "train", args_train)
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
#' @return A vector of predictions
#' @export
predict_tsc = function(model_path, newdata) {
  assert_true(file.exists(model_path))
  # Save newdata in case
  newdata = data_to_path(newdata)
  # Init Java
  .jinit()
  .jaddClassPath(path = "inst/java/TimeSeriesClassification.jar")
  trainAndPredict = .jnew("myimpl.TrainAndPredict")
  args_predict = c(model_path, test_data)
  # Predict
  J(trainAndPredict, "predict", args_predict)
}
