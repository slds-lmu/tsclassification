[![Build Status](https://travis-ci.org/compstat-lmu/TSClassification.svg?branch=master)](https://travis-ci.org/compstat-lmu/TSClassification)
[![codecov](https://codecov.io/gh/compstat-lmu/TSClassification/branch/master/graph/badge.svg)](https://codecov.io/gh/compstat-lmu/TSClassification)

# TSClassification

A large number of time-series classifiers have been implemented in
Java for the benchmark study **The Great Time Series Classification Bake Off (Bagnall et al. (2018))**.

The R-package **TSClassification** interfaces an adapted version of implementations provided by Bagnall et al. (2018),
in order to make implemented algorithms available for general machine learning purposes.


## Installation

The package can be installed from Github via

```r
devtools::install_github("compstat-lmu/TSClassification")
```

## Usage

We showcase the usage for a simulated data set:
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
  tsc$predict(data[!train_set, ])
```
For a more in-depth example, please consult the
[vignette](https://github.com/compstat-lmu/TSClassification/blob/master/vignettes/TimeSeriesClassification.Rmd).

## Currently available classifiers:
The package currently supports most of the algorithms implemented in the Bakeoff.


- **Time Domain Distance Based Classifiers**
    - timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN
    - timeseriesweka.classifiers.ensembles.elastic_ensemble.TWE1NN
    - timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN

- **Differential Distance Based Classifiers**
    - timeseriesweka.classifiers.NN_CID
    - timeseriesweka.classifiers.DD_DTW
    - timeseriesweka.classifiers.DTD_C

- **Dictionary Based Classifiers**
    - timeseriesweka.classifiers.BagOfPatterns
    - timeseriesweka.classifiers.SAX_1NN
    - timeseriesweka.classifiers.SAXVSM
    - timeseriesweka.classifiers.BOSS

- **Shapelet Based Classifiers**
    - timeseriesweka.classifiers.FastShapelets
    - timeseriesweka.classifiers.ShapeletTransformClassifier
    - timeseriesweka.classifiers.LearnShapelets

- **Interval Based Classifiers**
    - timeseriesweka.classifiers.TSF
    - timeseriesweka.classifiers.TSBF
    - timeseriesweka.classifiers.LPS


- **Ensemble Classifiers**
    - timeseriesweka.classifiers.ElasticEnsemble
    - timeseriesweka.classifiers.FlatCote



## Contribute & Support

### Contribute to the software

Contributions and new ideas are welcome, feel free to open an issue or pull request on [GitHub](https://github.com/compstat-lmu/TSClassification). It is advised to contact the Authors before (via Email or an Issue) in order to avoid duplicate work.

### Issues or Support with the software

If you encounter errors with the software or require assistance, contact us on [GitHub](https://github.com/compstat-lmu/TSClassification).

### Java refactoring

The code for the `.jar` file underlying `TSClassification` can be obtained from the [jTSC4R repository](https://github.com/compstat-lmu/jTSC4R). We aim to track changes made by the authors of the TimeSeries Classification Bakeoff there.
