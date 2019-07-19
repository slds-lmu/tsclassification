
# Table of implemented classifiers

|Classifier                                                    |Description                                                                                                        |
|:-------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
|**Used in Ensembles**                                            |                                                                                                                   |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN   |Euclidian distance with 1 nearest neighbor                                                                         |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN  |Dynamic time warping with 1 nearest neighbor                                                                       |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.ERP1NN  |edit distance with real penalty with 1 nearest neighbor                                                            |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.LCSS1NN |longest common subsequence with 1 nearest neighbour                                                                |
|**Time Domain Distance Based Classifiers**                    |                                                                                                                   |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN |Weighted dynamic time warping with 1 nearest neighbor                                                              |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.TWE1NN  |Time Warp Edit with 1 nearest neighbor                                                                             |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN  |Move-Split-Merge with 1 nearest neighbor                                                                           |
|**Differential Distance Based Classifiers**                   |                                                                                                                   |
|timeseriesweka.classifiers.NN_CID                             |Complexity Invariant distance with k nearest neighbor                                                              |
|timeseriesweka.classifiers.DD_DTW                             |Derivative dynamic time warping                                                                                    |
|timeseriesweka.classifiers.DTD_C                              |Derivative transform distance                                                                                      |
|**Dictionary Based Classifiers**                              |                                                                                                                   |
|timeseriesweka.classifiers.BagOfPatterns                      |Bag of Patterns                                                                                                    |
|timeseriesweka.classifiers.SAXVSM                             |Symbolic Aggregate Approximation - Vector Space Model                                                              |
|timeseriesweka.classifiers.BOSS                               |Bag of SFA Symbols                                                                                                 |
|Shapelet Based Classifiers                                    |                                                                                                                   |
|timeseriesweka.classifiers.FastShapelets                      |Fast Shapelets (FS)                                                                                                |
|timeseriesweka.classifiers.ShapeletTransformClassifier        |Shapelet Transform (ST)                                                                                            |
|timeseriesweka.classifiers.LearnShapelets                     |Learned Shapelets (LS)                                                                                             |
|Interval Based Classifiers                                    |                                                                                                                   |
|timeseriesweka.classifiers.TSF                                |Time Series Forest (TSF)                                                                                           |
|timeseriesweka.classifiers.TSBF                               |Time Series Bag of Features (TSBF)                                                                                 |
|timeseriesweka.classifiers.LPS                                |Learned Pattern Similarity (LPS)                                                                                   |
|Ensemble Classifiers                                          |                                                                                                                   |
|timeseriesweka.classifiers.ElasticEnsemble                    |Elastic Ensemble (EE)                                                                                              |
|timeseriesweka.classifiers.FlatCote                           |Collective of Transformation Ensembles (COTE)                                                                      |
|                                                              |                                                                                                                   |
|**Benchmark**                                                 |                                                                                                                   |
|weka.classifiers.functions.Logistic                           |logistic Regression                                                                                                |
|weka.classifiers.trees.J48                                    |C4.5 (C45)                                                                                                         |
|weka.classifiers.bayes.NaiveBayes                             |naive Bayes (NB)                                                                                                   |
|weka.classifiers.bayes.BayesNet                               |Bayes net (BN)                                                                                                     |
|weka.classifiers.functions.SMO                                |support vector machine with linear (SVML)                                                                          |
|weka.classifiers.functions.SMO                                |quadratic kernel (SVMQ)                                                                                            |
|weka.classifiers.functions.MultilayerPerceptron               |multilayer perceptron (MLP)                                                                                        |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN   |1-NN with Euclidean distance (ED)                                                                                  |
|timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN  |Dynamic time warping (DTW)                                                                                         |
|weka.classifiers.trees.RandomForest                           |Random forest (with 500 trees) (RandF)                                                                             |
|weka.classifiers.meta.RotationForest                          |rotation forest (with 50 trees) (RotF)                                                                             |
|                                                              |                                                                                                                   |
|**Time Series Classifiers**                                   |                                                                                                                   |
|timeseriesweka.classifiers.DTW_kNN                            | Specialization of kNN that can only be used with the efficient DTW distance                                       |
|timeseriesweka.classifiers.FastDTW_1NN                        | This class has option of searching for the optimal window length                                                  |
|timeseriesweka.classifiers.HiveCote                           | The Hierarchical Vote Collective of Transformation-Based Ensembles, include:EE                                    |
|timeseriesweka.classifiers.HiveCote2                          |                                                                                                                   |
|timeseriesweka.classifiers.RISE                               |                                                                                                                   |
|timeseriesweka.classifiers.SlowDTW_1NN                        |This classifier does the full 101 parameter searches for window.                                                   |
                                              |




##  Currently broken or not implemented

|Classifier                                                    |Description                                                                                                        |
|:-------------------------------------------------------------|:------------------------------------------------------------------------------------------------------------------|
|timeseriesweka.classifiers.SAX_1NN                            |Symbolic Aggregate Approximation                                                                                   |
|                                                              |DTW Features (DTWF )                                                                                               |
