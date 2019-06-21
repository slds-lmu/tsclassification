---
title: 'Time Series Classification in R'
tags:
  - 
  - 
  - 
authors:
 - name: 
   orcid: 
   affiliation: 
 - name: 
   orcid: 
   affiliation: 
affiliations:
 - name: 
   index: 
 - name: 
   index: 
affiliations:
 - name: 
   index: 
 - name: 
   index: 
date: 
bibliography: paper.bib
---

# Summary
Time series classification problems has extensively studied due to its wide range of applications, and the release of UCR time series archive stimulate the growth of publications proposing time series classification algorithms in this field. At least one thousand published papers made use of at least one dataset from time-series classification archive[1].
Due to the discrepency of the dataset and different framework where algorithms are implemented, it is difficult to compare different algorithms. To address these problems, 20 different TSC algorithms were implemented in a common Java framework integrated with the WEKA toolkit[3] by Bagnall et al.(2018)[2]. 
Based on a a common java framwork, comparision between different algorithms and against standard benchmark classifiers is made feasible.
As [2] implement many current state-of-the-art algorithms, such as *HIVE*, *HIVE-COTE*, *BOSS* and others, we aim to make these algorithms available to a wider audience, as these methods are currently not available in R.
Because [2] focus on a reproducible benchmark, no real user-interface for training and testing on datasets is made available.
We adapt the code base from [2] in order to enable training and prediction on user-supplied datasets using user-supplied hyperparameters.
We then interface the java methods using **rJava** [4] in order to provide an easily accessible interface to the R [5] computing language.
Our package provides train and prediction methods for over 30 time series classification methods including several weka classifiers.
Classifiers from [2] can be trained with different hyperparameters by writing datasets to disk and calling the corresponding java methods. Additionally, we provide full documentation for the integrated methods which is not easily available from [2].
This enables seamless access from R, and allows users to combine many different methods implemented in R, e.g. for time-series preprocessing with several state-of-the art time-series classifiers.



# References
[1]Hoang Anh Dau, Eamonn Keogh, Kaveh Kamgar, Chin-Chia Michael Yeh, Yan Zhu, Shaghayegh Gharghabi , Chotirat Ann Ratanamahatana, Yanping Chen, Bing Hu, Nurjahan Begum, Anthony Bagnall , Abdullah Mueen and Gustavo Batista (2018). The UCR Time Series Classification Archive. URL https://www.cs.ucr.edu/~eamonn/time_series_data_2018/

[2]Anthony Bagnall, Jason Lines, Aaron Bostrom, James Large and Eamonn Keogh, The Great Time Series Classification Bake Off: a Review and Experimental Evaluation of Recent Algorithmic Advances, Data Mining and Knowledge Discovery, 31(3), 2017

[3] M. Hall, E. Frank, G. Holmes, B. Pfahringer,P. Reutemann, and I. Witten. The WEKA data mining software. SIGKDD Explorations, 11(1), 2009.

[4] Urbanek, S. rJava: Low-Level R to Java Interface, 2019.

[5] R Core Team. R: A Language and Environment for Statistical Computing. R Foundation for Statistical Computing, Vienna, Austria. 2014.

