test_classifier = function(classifName) {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  tsc = TSClassifier$new(classifName)
  expect_output(print(tsc), "Untrained")

  tsc$train(train_data)
  expect_true(tsc$trained)
  expect_output(print(tsc), paste0("Classifier: ", classifName), fixed = TRUE)
  expect_output(print(tsc), "Trained", fixed = TRUE)

  p = tsc$predict(test_data)
  expect_numeric(p)
  expect_output(print(tsc), "Trained", fixed = TRUE)
  invisible(TRUE)
}
