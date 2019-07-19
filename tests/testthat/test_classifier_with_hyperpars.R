#' `timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN`
#' `setWindow`: `double` range: [1, Inf]
test_that("TSC can be predicted from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  classifName = "timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN"
  tsc = TSClassifier$new(classifName)
  tsc$train(train_data, par_vals = list("setWindow" = 100))
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_factor(p, len = 150L)
})

#' timeseriesweka.classifiers.BOSS
#' setMaxEnsembleSize
test_that("TSC can be predicted from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  classifName = "timeseriesweka.classifiers.BOSS"
  tsc = TSClassifier$new(classifName)
  tsc$train(train_data, par_vals = list("setMaxEnsembleSize" = 1))
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_factor(p, len = 150L)
})

# Wrong inputs
test_that("TSC can be predicted from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  classifName = "timeseriesweka.classifiers.BOSS"
  tsc = TSClassifier$new(classifName)
  expect_error(tsc$train(train_data, par_vals = list("setMaxEnsembleSize" = "A")), class = "NumberFormatException")
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_factor(p, len = 150L)
})

# Test resampling
test_that("TSC can be predicted from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  classifName = "weka.classifiers.trees.J48"
  tsc = TSClassifier$new(classifName)
  tsc$resample(train_data)
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_factor(p, len = 150L)
})
