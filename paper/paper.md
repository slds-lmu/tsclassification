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
   affiliation: LMU Munich
affiliations:
 - name: LMU Munich
   index: 1
 - name: TU Munich
   index: 2

date: 31.07.2019
bibliography: paper.bib
---

# Summary
Time series classification problems arise in many different domains such as speech recognition, medical signal pattern extraction, gesture recognition [@geurts2001pattern], or in industry often as a byproduct of measuring production processes.
A prominent example for time-series data are ECG data, where the heart's electrical activity is measured over time.

Due to the widespread application domains, algorithms for time-series classification have been widely studied.
In order to compare different algorithms, 20 different TSC algorithms were implemented in a common Java framework integrated with the WEKA toolkit [@hallweka] by [@Bagnall2017].
This made a benchmark comparison between different algorithms feasible.
[@Bagnall2017] find that several methods, such as *HIVE-COTE* [@hivecote] outperform many other methods including convolutional neural networks.

[@Bagnall2017] implement many current state-of-the-art algorithms, such as *HIVE*, *HIVE-COTE*, *BOSS* and others.
Because of a focus on a reproducible benchmark, no real user-interface for training and testing on datasets is made available.
We aim to make these algorithms available to a wider audience. We adapt the code base from [@Bagnall2017] in order to enable training and prediction on user-supplied and hyperparameters.
Currently state-of-the art algorithms are only available in Java. The R ecosystem on the other hand already offers several implementations for pre-processing, smoothing and imputation of time-series data, and users might often need the best of both worlds.

With this software, we aim to make algorithms available to scientists and users requiring access to state-of-the-art algorithms for time-series classification. Users can train over 30 time-series classification methods with specified hyper-parameters and use the learned models to predict on future data. Training is models is available from *data.frames* and *arff* files.
The software currently focuses on 1-dimensional time-series measured on evenly spaced grids.
We aim to extend the software, once implementations of multi-dimensional algorithms are made available.

We interface the Java methods using **rJava** [@urbanek2013rjava] in order to provide an easily accessible interface to the R [@team2013r] computing language.
Additionally, we provide full documentation for the integrated methods which is not easily available from [@Bagnall2017].
This enables seamless access from R, and allows users to combine many different methods implemented in R, e.g. for time-series preprocessing with several state-of-the art time-series classifiers.

The software is available at https://github.com/compstat-lmu/TSClassification.

# References
