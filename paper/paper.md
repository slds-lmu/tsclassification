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
date: 
bibliography: paper.bib
---

# Summary
Time series classification problems has extensively studied due to its wide range of applications, and the release of UCR time series archive stimulate the growth of publications proposing time series classification algorithms in this field. At least one thousand published papers made use of at least one dataset from archive[1]. Due the discrepency of the dataset and different framework where the algorithms implemented, it is difficult to compare different algorithms.To address these problems, 20 different TSC algorithms in a common Java framework, integrated with the WEKA toolkit[3] have been implemented by Bagnall et al.(2018)[2]. Based on a the common jave framwork, comparision between different algorithms and against standard benchmark classifiers has been feasible by performing resampling experiments on 85 datasets from an extended UCR time series archive. And the hypothese test based on the results from experiments indicates that only 9 of these algorithms are significantly outperform both benchmark and other algorithms. However, there is no such a common R framework so that the algorithm comparision in R is difficult. Our package provide an java interface for R environment to make these algorithms available in R environment.

Our package provide train and prediction method for over 30 time series classification method including weka classifiers.





# References
[1]Hoang Anh Dau, Eamonn Keogh, Kaveh Kamgar, Chin-Chia Michael Yeh, Yan Zhu, Shaghayegh Gharghabi , Chotirat Ann Ratanamahatana, Yanping Chen, Bing Hu, Nurjahan Begum, Anthony Bagnall , Abdullah Mueen and Gustavo Batista (2018). The UCR Time Series Classification Archive. URL https://www.cs.ucr.edu/~eamonn/time_series_data_2018/

[2]Anthony Bagnall, Jason Lines, Aaron Bostrom, James Large and Eamonn Keogh, The Great Time Series Classification Bake Off: a Review and Experimental Evaluation of Recent Algorithmic Advances, Data Mining and Knowledge Discovery, 31(3), 2017

[3] M. Hall, E. Frank, G. Holmes, B. Pfahringer,P. Reutemann, and I. Witten. The WEKA data mining software. SIGKDD Explorations, 11(1), 2009.
