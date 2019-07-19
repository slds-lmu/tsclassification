---
title: 'Time Series Classification in R'
tags:
  - Time Series Classification
  - Functional Data
authors:
 - name: Florian Pfisterer
   orcid:
   affiliation: LMU Munich
 - name: Yu Wang
   orcid:
   affiliation: TU Munich
 - name: Xudong Sun
   orcid:
   affiliation: TU Munich
affiliations:
 - name: LMU Munich
   index: 1
 - name: TU Munich
   index: 2

date:
bibliography: paper.bib
---

# Summary
Time series classification problems has extensively studied due to its wide range of applications.
The release of the UCR [@chen2015ucr] time series archive stimulated the growth of publications proposing time series classification algorithms in this field.
As a result many different algorithms for time-series data are available.
Due to the discrepancy of the dataset and different framework where algorithms are implemented, it is difficult to compare different algorithms.
To address these problems, 20 different TSC algorithms were implemented in a common Java framework integrated with the WEKA toolkit [@hallweka] by [@Bagnall2017].
Based on a a common Java framework, comparison between different algorithms and against standard benchmark classifiers is made feasible.

As [@Bagnall2017] implement many current state-of-the-art algorithms, such as *HIVE*, *HIVE-COTE*, *BOSS* and others, we aim to make these algorithms available to a wider audience, as these methods are currently not available in R, and the comparison between different algorithms is not feasible in R.
Because of a focus on a reproducible benchmark, no real user-interface for training and testing on datasets is made available.
We adapt the code base from [@Bagnall2017] in order to enable training and prediction on user-supplied datasets using user-supplied hyperparameters.

The aim of this software is two fold: We aim to make the implementations algorithms available to scientists and users
requiring access to state-of-the-art algorithms.

We then interface the Java methods using **rJava** [@urbanek2013rjava] in order to provide an easily accessible interface to the R [@team2013r] computing language. Our package provides train and prediction methods for over 30 time series classification methods including several weka classifiers.

Classifiers can be trained with different hyperparameters by writing datasets to disk and calling the corresponding Java methods.
Additionally, we provide full documentation for the integrated methods which is not easily available from [@Bagnall2017].
This enables seamless access from R, and allows users to combine many different methods implemented in R, e.g. for time-series preprocessing with several state-of-the art time-series classifiers.
The software is available at https://github.com/compstat-lmu/TSClassification.

# References
