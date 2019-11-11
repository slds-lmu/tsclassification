#' @title Time Series Classification Learner
#'
#' @usage NULL
#' @aliases mlr_learners_classif.tsclassification
#' @format [R6::R6Class()] inheriting from [mlr3::LearnerClassif].
#'
#' @section Construction:
#' ```
#' LearnerClassifTSClassification$new()
#' mlr3::mlr_learners$get("classif.tsclassification")
#' mlr3::lrn("classif.tsclassification")
#' ```
#'
#' @description
#' This class interfaces
#' Time-Series Classification Bake-off classifiers
#' Calls [tsclassification::TSClassifier()] from package \pkg{tsclassification}.
#'
#' @references
#' Bagnall et al., 2018, The great time-series classification bakeoff
#'
#' @export
#' @examples
#' \dontrun{
#'   library(mlr3)
#'   tsk = mlr_tasks$get("iris")
#'   lrn = LearnerClassifTSClassification$new()
#'   # Train the classifier
#'   lrn$train(tsk)
#'   # Predict again
#'   lrn$predict(tsk)
#' }
#'
LearnerClassifTSClassification = R6Class("LearnerClassifTSClassification", inherit = mlr3::LearnerClassif,
  public = list(
    initialize = function() {
      ps = paradox::ParamSet$new(list(
        paradox::ParamFct$new("classifier", default = "timeseriesweka.classifiers.FastDTW_1NN", levels = tsc_classifiers(), tags = "train"),
        paradox::ParamDbl$new("setR", default = 0.1, lower = 0, upper = 1, tags = "train")
      ))
      ps$values = list(classifier = "timeseriesweka.classifiers.FastDTW_1NN")
      ps$add_dep("setR", "classifier", paradox::CondAnyOf$new(c("timeseriesweka.classifiers.FastDTW_1NN", "timeseriesweka.classifiers.SlowDTW_1NN")))

      super$initialize(
        id = "classif.tsclassification",
        param_set = ps,
        predict_types = c("response"),
        feature_types = c("integer", "numeric"),
        properties = c("twoclass", "multiclass"),
        packages = "tsclassification",
        man = "tsclassification::mlr_learners_classif.tsclassification"
      )
    },

    train_internal = function(task) {
      par_vals = self$param_set$get_values(tag = "train")
      tsc = TSClassifier$new(par_vals[["classifier"]])
      mlr3misc::invoke(tsc$train, data = as.data.frame(task$data()), target = task$target_names,
        par_vals = par_vals[setdiff(names(par_vals), "classifier")])
      return(tsc)
    },

    predict_internal = function(task) {
      pars = self$param_set$get_values(tags = "predict")
      if (!is.null(pars$predict.method)) {
        pars$method = pars$predict.method
        pars$predict.method = NULL
      }

      newdata = task$data(cols = task$feature_names)
      p = mlr3misc::invoke(self$model$predict, newdata = newdata)
      PredictionClassif$new(task = task, response = p)
    }
  )
)
