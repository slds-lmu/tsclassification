context("test-classifier")

test_that("TSC can be built from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN")
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  expect_class(tsc, classes = c("TSClassifier", "R6"))
})

test_that("TSC can be trained from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN")
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
  expect_class(tsc, classes = c("TSClassifier", "R6"))
  expect_true(tsc$trained)
})

test_that("TSC can be tested from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST")
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_numeric(p)
})

test_that("Test different impls", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST")
  classifName = "weka.classifiers.meta.OptimisedRotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
  tsc$predict(test_data)
})
