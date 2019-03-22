context("test-helpers")

test_that("Can be found by name or short name", {
  expect_equal("timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN", check_classifier("WDTW1NN"))
  expect_equal("timeseriesweka.classifiers.LearnShapelets", check_classifier("learnShapelets"))
  expect_equal("timeseriesweka.classifiers.TSF", check_classifier("TSF"))
  expect_equal("timeseriesweka.classifiers.BOSS", check_classifier("Boss"))
  expect_equal("weka.classifiers.functions.MultilayerPerceptron", check_classifier("MultilayerPerceptron"))
  expect_equal("timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
    check_classifier("timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN"))
})


test_that("Fails if no matches or not specific", {
  expect_error(check_classifier("classifier"))
  expect_error(check_classifier("foo"))
  expect_error(check_classifier(""))
  expect_error(check_classifier("nn"))
  expect_error(check_classifier("timeseriesweka.classifiers"))
  expect_error(check_classifier("timeseriesweka.BOSS"))
})


test_that("tsc_classifiers works", {
  expect_class(tsc_classifiers(), "character")
  expect_true(length(tsc_classifiers()) > 1L)
})


test_that("par_vals_to_string works", {
  expect_equal(par_vals_to_string(list(a = 5)), "a=5")
  expect_equal(par_vals_to_string(list(a = 5, b = 7)), "a=5,b=7")
  expect_error(par_vals_to_string(c(a = 5)))
  expect_error(par_vals_to_string(list(5)))
  expect_equal(par_vals_to_string(NULL), "")
})
