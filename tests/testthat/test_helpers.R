test_classifier = function(classifName) {
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_numeric(p)
  invisible(TRUE)
}
