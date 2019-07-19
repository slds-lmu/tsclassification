test_classifier = function(classifName, len = 150) {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  tsc = TSClassifier$new(classifName)
  expect_output(print(tsc), "Untrained")

  tsc$train(train_data)
  expect_true(tsc$trained)
  expect_output(print(tsc), paste0("Classifier: ", classifName), fixed = TRUE)
  expect_output(print(tsc), "Trained", fixed = TRUE)

  p = tsc$predict(test_data)
  expect_factor(p)
  expect_true(length(p) == len)
  expect_output(print(tsc), "Trained", fixed = TRUE)
  invisible(TRUE)
}


train_test_on_dataset = function(classifName, train_data, test_data, len = 150L) {
  tsc = TSClassifier$new(classifName)
  expect_output(print(tsc), "Untrained")

  capture.output({tsc$train(train_data)})
  expect_true(tsc$trained)
  expect_output(print(tsc), paste0("Classifier: ", classifName), fixed = TRUE)
  expect_output(print(tsc), "Trained", fixed = TRUE)

  capture.output({p <- tsc$predict(test_data)})
  expect_factor(p)
  expect_true(length(p) == len)
  expect_output(print(tsc), "Trained", fixed = TRUE)
  invisible(TRUE)
}

train_on_dataset = function(classifName, train_data) {
  tsc = TSClassifier$new(classifName)
  expect_output(print(tsc), "Untrained")

  capture.output({tsc$train(train_data)})
  expect_true(tsc$trained)
  expect_output(print(tsc), paste0("Classifier: ", classifName), fixed = TRUE)
  expect_output(print(tsc), "Trained", fixed = TRUE)
  invisible(TRUE)
}
