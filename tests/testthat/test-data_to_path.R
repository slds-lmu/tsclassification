context("test-data_to_path")

test_that("writing / deleting arff works ", {
  df = data.frame(matrix(rnorm(100), nrow = 10))
  fp = data_to_path(df)
  delete_data_from_path(fp)
  expect_true(!file.exists(fp))
})
