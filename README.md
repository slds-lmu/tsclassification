[![Build Status](https://travis-ci.org/compstat-lmu/TSClassification.svg?branch=master)](https://travis-ci.org/compstat-lmu/TSClassification)
[![codecov](https://codecov.io/gh/compstat-lmu/TSClassification/branch/master/graph/badge.svg)](https://codecov.io/gh/compstat-lmu/TSClassification)

# TSClassification

A large number of time-series classifiers have been implemented in
Java for the benchmark study [**The Great Time Series Classification Bake Off (Bagnall et al., 2018)**](http://timeseriesclassification.com/).
**[Paper](https://arxiv.org/abs/1602.01711)**

The R-package **tsclassification** interfaces an adapted version of implementations provided by Bagnall et al. (2018),
in order to make implemented algorithms available for general machine learning purposes.


[Package Website](https://compstat-lmu.github.io/tsclassification)

## Installation

The package can be installed from Github via

```r
devtools::install_github("compstat-lmu/tsclassification")
```

See the **Troubleshooting** section of this README for more info if the installation fails.

## Usage
Note that our package name is in lowercase letters.
```r
library(tsclassification)
```

We showcase the usage for a simulated data set.

First we generate some artificial data:

```r
  data = data.frame(matrix(rnorm(500), nrow = 100))
  data$target = sample(c(1, 0), 100, replace = TRUE)
  train_set = sample(c(TRUE, FALSE), 100, replace = TRUE)
```

**Training a model:**
Then we train a `RotationForest` model.
The API is similar to python's `scikit-learn` API.
It offers a `train()` method, that trains a model, and a `predict()` method that uses the trained
model in order to predict future, unseen data.

```r
  # Instantiate the model
  tsc = TSClassifier$new("weka.classifiers.meta.RotationForest")
  # Call train and predict function on the different data splits
  tsc$train(data[train_set, ],target = "target")
  tsc$predict(data[!train_set, ])
```
For a more in-depth example, please consult the
[vignette](https://compstat-lmu.github.io/tsclassification/articles/TimeSeriesClassification.html).

### mlr3 connector

The package offers also offers connector to the machine learning toolbox `mlr3`.
Learners contained in the package can directly be used in conjunction
with the powerful functionalities of `mlr3` like **resampling**, **tuning** and so on.

An example of doing this for the popular *iris* dataset (considering the features as "functional")
is shown below:

```r
  library(mlr3)
  tsk = mlr_tasks$get("iris")
  lrn = LearnerClassifTSClassification$new()

  # Train the classifier
  lrn$train(tsk)

  # Predict
  prds = lrn$predict(tsk)
```

For a more in-depth introduction to `mlr3`, please consult the
[mlr3 book](https://mlr3book.mlr-org.com/).
Additionally, the [vignette](https://compstat-lmu.github.io/tsclassification/articles/TimeSeriesClassification.html).
contains an example for *tuning* a time-series classifier.


---

## Currently available classifiers:
The package currently supports most of the algorithms implemented in the Bake-Off.


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


---

## Troubleshooting

On some systems, installing `rJava` does not work out of the box.
Various topics regarding this are available on [stackoverflow](https://stackoverflow.com/questions/3311940/r-rjava-package-install-failing).

On unix based systems, a simple fix that often works is to run `sudo R CMD javareconf` in the command line before restarting R and installing again.

## Will there be a CRAN release?
Unfortunately our software requires a java binary. This binary has around 40 MB, which is to big for CRAN packages.

## Contribute & Support

We appreciate bug-reports and contributions! Feel free to contact us if any questions arise!

### Contribute to the software

Contributions and new ideas are welcome, feel free to open an issue or pull request on [GitHub](https://github.com/compstat-lmu/TSClassification). It is advised to contact the Authors before (via Email or an Issue) in order to avoid duplicate work.

### Issues or Support with the software

If you encounter errors with the software or require assistance, contact us on [GitHub](https://github.com/compstat-lmu/TSClassification).

### Java refactoring

The code for the `.jar` file underlying `TSClassification` can be obtained from the [jTSC4R repository](https://github.com/compstat-lmu/jTSC4R). We aim to track changes made by the authors of the TimeSeries Classification Bakeoff there.
