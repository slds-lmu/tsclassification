context("test-classifier")

test_that("TSC can be built from file path", {
  train_data = "inst/arff/GunPoint_TRAIN.arff"
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(train_data, classifName)
})

test_that("TSC can be trained from file path", {
  train_data = "inst/arff/GunPoint_TRAIN.arff"
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
})

test_that("TSC can be tested from file path", {
  train_data = "inst/arff/GunPoint_TRAIN.arff"
  test_data = "inst/arff/GunPoint_TEST.arff"
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
  tsc$predict(test_data)
})

test_that("Test different impls", {
  train_data = "inst/arff/GunPoint_TRAIN.arff"
  test_data = "inst/arff/GunPoint_TEST.arff"
  classifName = "weka.classifiers.meta.OptimisedRotationForest"
  tsc = TSClassifier$new(train_data, classifName)
  tsc$train()
  tsc$predict(test_data)
})
