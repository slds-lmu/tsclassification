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

test_that("TSC can be predicted from file path", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")
  classifName = "weka.classifiers.trees.J48"
  tsc = TSClassifier$new(classifName)
  tsc$train(train_data)
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_numeric(p, len = 150L)
})

test_that("TSC works from data.frame", {
  set.seed(3)
  m = matrix(rnorm(300), nrow = 30, ncol = 10)
  y = as.integer(apply(m, 1, mean) > 0)
  dftrain = data.frame(m[1:15, ], "class" = y[1:15])
  dftest = data.frame(m[16:30, ], "class" = y[16:30])
  classifName = "ElasticEnsemble"
  tsc = TSClassifier$new(classifName)
  tsc$train(dftrain, target = "class")
  expect_true(tsc$trained)
  p = tsc$predict(test_data)
  expect_numeric(p, len = 150L)
})
