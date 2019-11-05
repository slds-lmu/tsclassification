## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
# Load tsclassification
library(tsclassification)

## ------------------------------------------------------------------------
train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN.arff")
test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST.arff")

## ------------------------------------------------------------------------
classif_name = "ensemble.DTW1NN"
tsc = TSClassifier$new(classif_name)

## ------------------------------------------------------------------------
tsc$train(train_data)

## ------------------------------------------------------------------------
p = tsc$predict(test_data)

## ------------------------------------------------------------------------
library(farff)
train_set = readARFF(train_data)

## ------------------------------------------------------------------------
dim(train_set)

## ---- echo = FALSE-------------------------------------------------------
plot(as.numeric(train_set[1, -151]), col = "red", type = "l")
lines(as.numeric(train_set[2, -151]), col = "red")
lines(as.numeric(train_set[3, -151]), col = "blue")
lines(as.numeric(train_set[4, -151]), col = "blue")

## ------------------------------------------------------------------------
tsc = TSClassifier$new("timeseriesweka.classifiers.BOSS")
tsc$train(train_set, target = "target")

## ------------------------------------------------------------------------
test_set = readARFF(test_data)
tsc$predict(test_set)

## ------------------------------------------------------------------------
tsc$model_path

## ------------------------------------------------------------------------
tsc$cleanup()

## ---- eval = FALSE-------------------------------------------------------
#  tsc = TSClassifier$new("timeseriesweka.classifiers.BOSS")
#  tsc$train(train_data, par_vals = list(setMaxEnsembleSize = 1))
#  tsc$predict(test_data)

## ---- eval = FALSE-------------------------------------------------------
#  tsc = TSClassifier$new("timeseriesweka.classifiers.TSBF")
#  tsc$train(train_data, par_vals = list(setZLevel = 0.5))
#  tsc$predict(test_data)

## ------------------------------------------------------------------------
tsc = TSClassifier$new("weka.classifiers.trees.J48")
tsc$resample(train_data)

## ------------------------------------------------------------------------
data_to_path(train_set, target = "target", data_path = NULL)

## ------------------------------------------------------------------------
model_path = tempfile()
mod = train_tsc(train_data, classifier = "weka.classifiers.trees.J48", model_path = model_path)
predict_tsc(test_data, model_path = model_path)

