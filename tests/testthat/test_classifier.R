context("test-classifier")
test_that("TSC can be built from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(classifName)
  expect_class(tsc, classes = c("TSClassifier", "R6"))
})

test_that("TSC can be trained from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(classifName)
  tsc$train(train_data)
  expect_class(tsc, classes = c("TSClassifier", "R6"))
  expect_true(tsc$trained)
})

test_that("TSC can be tested from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(classifName)
  tsc$train(train_data)
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_numeric(p)
})
