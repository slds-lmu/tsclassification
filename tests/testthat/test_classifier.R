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
  expect_factor(p, len = 150L)
})

test_that("TSC works from data.frame", {
  set.seed(3)
  m = matrix(rnorm(300), nrow = 30, ncol = 10)
  y = as.integer(apply(m, 1, mean) > 0)
  dftrain = data.frame(m[1:15, ], "class" = y[1:15])
  dftest = data.frame(m[16:30, ], "class" = y[16:30])
  classifName = "ElasticEnsemble"
  tsc = TSClassifier$new(classifName)
  expect_class(tsc, "TSClassifier")
  tsc$train(dftrain, target = "class")
  expect_true(tsc$trained)
  p = tsc$predict(dftest)
  expect_factor(p, len = 15L)
})

test_that("TSC works for edge cases", {
  set.seed(7)
  m = matrix(rnorm(300), nrow = 30, ncol = 10)
  y = as.integer(apply(m, 1, mean) > 0)

  # 1 row
  dftrain = data.frame(m[1, , drop = FALSE], "class" = y[1])
  dftest = data.frame(m[2:30, ], "class" = y[2:30])
  classifName = "ElasticEnsemble"
  tsc = TSClassifier$new(classifName)
  expect_class(tsc, "TSClassifier")
  tsc$train(dftrain, target = "class")
  expect_true(tsc$trained)
  p = tsc$predict(dftest)
  expect_factor(p, len = 29L)
  expect_true(length(unique(p)) == 1)

  # 1 column
  dftrain = data.frame(m[1:15, , drop = FALSE], "class" = y[1:15])
  dftest = data.frame(m[16:30, ], "class" = y[16:30])
  classifName = "ElasticEnsemble"
  tsc = TSClassifier$new(classifName)
  expect_class(tsc, "TSClassifier")
  tsc$train(dftrain, target = "class")
  expect_true(tsc$trained)
  p = tsc$predict(dftest)
  expect_factor(p, len = 15L)
})

test_that("TSC works with factors", {
  set.seed(11)
  m = matrix(rnorm(300), nrow = 30, ncol = 10)
  y = factor(apply(m, 1, mean) > 0, labels = c("a", "b"))
  dftrain = data.frame(m[1:15, ], "class" = y[1:15])
  dftest = data.frame(m[16:30, ], "class" = y[16:30])
  classifName = "weka.classifiers.trees.J48"
  tsc = TSClassifier$new(classifName)
  expect_class(tsc, "TSClassifier")
  tsc$train(dftrain, target = "class")
  expect_true(tsc$trained)
  p = tsc$predict(dftest)
  expect_factor(p, len = 15L, levels = c("a", "b"))

  # Predict single instances
  p = tsc$predict(dftest[1,])
  expect_factor(p, len = 1L, levels = "a")

  # Predict single instances
  p = tsc$predict(dftest[3,])
  expect_factor(p, len = 1L, levels = "b")
})


test_that("TSC predict works without target", {
  set.seed(30)
  m = matrix(runif(400, -1, 1), nrow = 40, ncol = 10)
  y = factor(apply(m, 1, mean) > 0, labels = c("a", "b"))
  m[,1] = ifelse(y == "a", m[,1] + 2, m[,1] - 2)
  dftrain = data.frame(m[1:20, ], "class" = y[1:20])
  dftest = data.frame(m[21:40, ], "class" = y[21:40])
  classifName = "weka.classifiers.trees.J48"
  tsc = TSClassifier$new(classifName)
  expect_class(tsc, "TSClassifier")
  tsc$train(dftrain, target = "class")
  expect_true(tsc$trained)
  dftest$class = NA
  p = tsc$predict(dftest)
  expect_factor(p, len = 20L, levels = c("a", "b"))

  # Predict single instances
  p = tsc$predict(dftest[1,])
  expect_factor(p, len = 1L, levels = "a")

  # Predict single instances
  p = tsc$predict(dftest[2,])
  expect_factor(p, len = 1L, levels = "b")
})

test_that("TSC predict works in several arcane cases", {
  set.seed(30)
  m = matrix(runif(400, -1, 1), nrow = 80, ncol = 5)
  y = factor(sample(c("a", "b", "c"), 80, replace = TRUE))
  m[,1] = ifelse(y == "a", m[,1] + 2, m[,1] - 2)
  m[,2] = ifelse(y == "b", m[,2] + 2, m[,2] - 2)
  m[,3] = ifelse(y == "c", m[,3] + 2, m[,3] - 2)
  m[,4] = ifelse(y == "a", m[,4] + 2, m[,4] - 2)
  m[,5] = ifelse(y == "c", m[,5] + 2, m[,5] - 2)
  dftrain = data.frame(m[1:40, ], "class" = y[1:40])
  dftest = data.frame(m[41:80, ], "class" = y[41:80])

  # Binary: Should work
  file_train = tempfile(pattern = "train", fileext = ".arff")
  file_test = tempfile(pattern = "test", fileext = ".arff")
  farff::writeARFF(dftrain[dftrain$class != "a", ], file_train, overwrite = TRUE)
  farff::writeARFF(dftest[dftest$class != "a", ], file_test, overwrite = TRUE)
  train_test_on_dataset("weka.classifiers.trees.J48", file_train, file_test, len = nrow(dftest[dftest$class != "a", ]))

  # No target in test: Should work
  file_train = tempfile(pattern = "train", fileext = ".arff")
  file_test = tempfile(pattern = "test", fileext = ".arff")
  farff::writeARFF(dftrain[dftrain$class != "a", ], file_train, overwrite = TRUE)
  dftest_nocl = dftest[dftest$class != "a", ]
  dftest_nocl$class = NULL
  farff::writeARFF(dftest_nocl, file_test, overwrite = TRUE)
  train_test_on_dataset("weka.classifiers.trees.J48", file_train, file_test, len = nrow(dftest_nocl))

  # NA target in test: Should work
  file_test = tempfile(pattern = "test", fileext = ".arff")
  dftest_nocl$class = NA
  farff::writeARFF(dftest_nocl, file_test, overwrite = TRUE)
  train_test_on_dataset("weka.classifiers.trees.J48", file_train, file_test, len = nrow(dftest_nocl))

  # Multiclass
  file_train = tempfile(pattern = "train", fileext = ".arff")
  file_test = tempfile(pattern = "test", fileext = ".arff")
  farff::writeARFF(dftrain, file_train, overwrite = TRUE)
  farff::writeARFF(dftest, file_test, overwrite = TRUE)
  train_test_on_dataset("weka.classifiers.trees.J48", file_train, file_test, len = nrow(dftest))

  # Full NA Data during train: This should error / reduce to majorityclass
  dftrain_na = dftrain
  dftrain_na[1:10, 1:5] = NA
  file_train = tempfile(pattern = "train", fileext = ".arff")
  farff::writeARFF(dftrain_na[1:10,], file_train, overwrite = TRUE)
  expect_error(train_on_dataset("weka.classifiers.trees.J48", file_train), class = "IOException")

  # NA labels during train: This should error!
  dftrain_na = dftrain
  dftrain_na[, 6] = NA
  file_train = tempfile(pattern = "train", fileext = ".arff")
  farff::writeARFF(dftrain_na, file_train, overwrite = TRUE)
  expect_error(train_on_dataset("weka.classifiers.trees.J48", file_train), class = "IOException")

  # Partial NA Data during train: At least a warning
  dftrain_na2 = dftrain[dftrain$class != "a", ]
  dftrain_na2[1:10, 1:5] = NA
  file_train = tempfile(pattern = "train", fileext = ".arff")
  farff::writeARFF(dftrain_na[1:20,], file_train, overwrite = TRUE)
  expect_error(train_on_dataset("weka.classifiers.trees.J48", file_train), class = "IOException")

  # Full NA during test: This should error
  file_train = tempfile(pattern = "train", fileext = ".arff")
  farff::writeARFF(dftrain[dftrain$class != "a", ], file_train, overwrite = TRUE)
  file_test = tempfile(pattern = "test", fileext = ".arff")
  dftest_na = dftest
  dftest_na[1:10, 1:5] = NA
  farff::writeARFF(dftest_na[1:10,], file_test, overwrite = TRUE)
  expect_error(train_test_on_dataset("weka.classifiers.trees.J48", file_train, file_test, len = 10), class = "IOException")

  # NA Data during test: At least warn or majority class
  file_test = tempfile(pattern = "test", fileext = ".arff")
  dftest_na = dftest
  dftest_na[1:10, 1:5] = NA
  farff::writeARFF(dftest_na, file_test, overwrite = TRUE)
  expect_error(train_test_on_dataset("weka.classifiers.trees.J48", file_train, file_test), class = "IOException")
})


