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

date: 31.07.2019
bibliography: paper.bib
---

# Summary
Time series classification problems arise in many different domains such as speech recognition, medical signal pattern extraction, gesture recognition,etc[@geurts2001pattern], often as a byproduct of a process.
As a result, algorithms for time-series classification have been widely studied.
A prominent example for time-series data are ECG data, where the heart's electrical activity is measured over time.
Being able to classify ECG curves for example, could help doctors improve their diagnosis and certain disease could be early prevented. 

The release of the UCR time series archive [@chen2015ucr] is often used for the comparison of such algorithms.
As a result many different well-tested algorithms for such time-series data are available.
Due to the discrepancy of different framework where algorithms are implemented, it is difficult to compare different algorithms.
To address these problems, 20 different TSC algorithms were implemented in a common Java framework integrated with the WEKA toolkit [@hallweka] by [@Bagnall2017].
Based on a common Java framework, comparison between different algorithms and against standard benchmark classifiers is made feasible.
By comparison, Flat-COTE outperformed all other methods including deep learning method that use the convolutional neural network by ensemble individual classifiers into a flat hierarchy. Based on the experimental result, HIVE-COTE improved the Flat-COTE by adding new components and arranging components in a modular hierarchical structure and introduced a probabilistic voting scheme to make the final prediction. Finally, HIVE-COTE performed more accurate and became a new state-of-art algorithm for TSC[@hivecote].
As [@Bagnall2017] implement many current state-of-the-art algorithms, such as *HIVE*, *HIVE-COTE*, *BOSS* and others, we aim to make these algorithms available to a wider audience, as these methods are currently not available in R, and the comparison between different algorithms is not feasible in R.
Because of a focus on a reproducible benchmark, no real user-interface for training and testing on datasets is made available.
We adapt the code base from [@Bagnall2017] in order to enable training and prediction on user-supplied datasets using user-supplied hyperparameters.
Currently state-of-the art algorithms are only available in Java. The R ecosystem on the other hand already offers several implementations for
pre-processing and smoothing of functional data, and users might often need the best of both worlds.

With this software, we aim to make the algorithms available to scientists and users requiring access to state-of-the-art algorithms for time-series classification.
The software currently focuses on 1-dimensional time-series measured on evenly spaced grids.
We aim to extend the software, once implementations of multi-dimensional algorithms are made available.

We interface the Java methods using **rJava** [@urbanek2013rjava] in order to provide an easily accessible interface to the R [@team2013r] computing language. Our package provides train and prediction methods for over 30 time series classification methods including several weka classifiers.
Classifiers can be trained with different hyperparameters by writing datasets to disk and calling the corresponding Java methods.
Additionally, we provide full documentation for the integrated methods which is not easily available from [@Bagnall2017].
This enables seamless access from R, and allows users to combine many different methods implemented in R, e.g. for time-series preprocessing with several state-of-the art time-series classifiers.

The software is available at https://github.com/compstat-lmu/TSClassification.

# References
