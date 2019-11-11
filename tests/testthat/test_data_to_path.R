context("test-data_to_path")

test_that("writing / deleting arff works ", {
  df = data.frame(matrix(rnorm(100), nrow = 10))
  df$target = sample(c(1, 0), 10, replace = TRUE)
  fp = data_to_path(df)
  expect_true(file.exists(fp))
  df2 = farff::readARFF(fp)
  expect_equal(dim(df), dim(df2))
  delete_data_from_path(fp)
  expect_true(!file.exists(fp))
})

test_that("Training on data.frame's works ", {
  train_data = data.frame(matrix(rnorm(100), nrow = 10))
  train_data$target = sample(c(1, 0), 10, replace = TRUE)
  classifName = "weka.classifiers.meta.RotationForest"
  tsc = TSClassifier$new(classifName)
  expect_silent(tsc$train(train_data, target = "target"))
  expect_factor(tsc$predict(train_data))
})


test_that("data_to_path", {
  train_data = data.frame(matrix(rnorm(100), nrow = 10))
  train_data$target = as.factor(sample(c(1, 0), 10, replace = TRUE))
  file = tempfile()
  data_path = data_to_path(train_data, "target", data_path = file)
  expect_file_exists(data_path)
  expect_warning(data_to_path(train_data, "target", data_path = file))
  df = farff::readARFF(data_path)
  expect_equal(train_data, df)
})


test_that("iris works", {
  train_data = iris
  file = tempfile()
  data_path = data_to_path(train_data, "Species", data_path = file)
  expect_file_exists(data_path)
  expect_warning(data_to_path(train_data, "Species", data_path = file))
  df = farff::readARFF(data_path)
  expect_true(all(colnames(df) == c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "target")))
})