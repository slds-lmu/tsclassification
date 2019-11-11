context("mlr3 learner")

test_that("mlr3 learner works for iris", {
  skip_if_not(require("mlr3"))
  library(mlr3)
  tsk = mlr_tasks$get("iris")
  lrn = LearnerClassifTSClassification$new()
  expect_class(lrn, "Learner")
  expect_class(lrn, "LearnerClassif")
  expect_class(lrn, "R6")

  # Train the classifier
  lrn$train(tsk)
  assert_class(lrn$model, "TSClassifier")
  assert_true(lrn$model$trained)

  # Predict again
  prds = lrn$predict(tsk)
  expect_class(prds, "PredictionClassif") 
  # Check that error is < 33%
  expect_true(sum(diag(prds$confusion)) > 100)
})
