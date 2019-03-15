[![Travis build status](https://travis-ci.org/compstat-lmu/TSClassification?branch=master)](https://travis-ci.org/compstat-lmu/TSClassification)
[![Coverage status](https://codecov.io/gh/compstat-lmu/TSClassification/branch/master/graph/badge.svg)](https://codecov.io/github/compstat-lmu/TSClassification?branch=master)

# TSClassification

A large number of time-series classifiers have been implemented in
Java bei Bagnall et al. (2018) for a benchmark study "The Great Time Series Classification Bake Off".
This package interfaces an adapted version of implementations provided by Bagnall et al., in order
to make algorithms available to a wider audience.

We showcase this for a simulated data set.
Note that we expect the `target` name to be 'target'.

```r
  data = data.frame(matrix(rnorm(500), nrow = 100))
  data$target = sample(c(1, 0), 100, replace = TRUE)
  train_set = sample(c(TRUE, FALSE), 100, replace = TRUE)
```

```r
  # Instantiate the model
  tsc = TSClassifier$new("weka.classifiers.meta.RotationForest")
  # Call train and predict function on the different data splits
  tsc$train(data[train_set, ])
  tsc$predict(data[train_set, ])
```

# Java refactoring
https://github.com/smilesun/tsc4R
