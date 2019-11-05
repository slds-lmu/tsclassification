#' Return available classifiers
#'
#' Run `tsc_classifiers()` to obtain available classifiers
#'
#' The following classifiers are available:
#'
#' @section Ensemble Classifiers:
#'
#' \itemize{
#'
#'   \item `timeseriesweka.classifiers.ElasticEnsemble` \cr
#'    Combination of nearest Neighbour (NN) classifiers that use elastic distance measures \cr
#'    Hyperparameters: *None*
#'
#'   \item `timeseriesweka.classifiers.FlatCote` \cr
#'    Collective of Transformation Ensembles (Bagnall et al.,2015) \cr
#'    Hyperparameters: *None*
#'
#'   Base-learners of ElasticEnsemble: \cr
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN` \cr
#'     Elastic Ensemble of Nearest Neighbour Algorithms: \cr
#'     Weighted Dynamic Time Warping 1 Nearest Neighbour \cr
#'     Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN` \cr
#'    Euclidean distance with 1 nearest neighbor \cr
#'    Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN` \cr
#'    Dynamic time warping with 1 nearest neighbor \cr
#'    Hyperparameters: \cr
#'          \itemize{
#'          \item `setWindow`: `double` range: \[1, Inf\]
#'          }
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.ERP1NN` \cr
#'    edit distance with real penalty with 1 nearest neighbor \cr
#'    Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.LCSS1NN` \cr
#'    longest common subsequence with 1 nearest neighbor \cr
#'    Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.TWE1NN` \cr
#'    Time Warp Edit with 1 nearest neighbor \cr
#'    Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN` \cr
#'    Move-Split-Merge with 1 nearest neighbor \cr
#'    Hyperparameters: *None*
#'
#'
#' }
#'
#' @section Differential Distance Based Classifiers:
#' \itemize{
#'
#'    \item `timeseriesweka.classifiers.NN_CID` \cr
#'    Complexity Invariant distance with k nearest neighbor \cr
#'    Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.DD_DTW` \cr
#'    Derivative dynamic time warping \cr
#'    Hyperparameters: *None*
#'
#'    \item `timeseriesweka.classifiers.DTD_C` \cr
#'    Derivative transform distance \cr
#'    Hyperparameters: *None*
#'
#' }
#'
#' @section Dictionary based Classifiers:
#' \itemize{
#'   \item `timeseriesweka.classifiers.BOSS` \cr
#'   Bag of SFA Symbols \cr
#'   Hyperparameters: \cr
#'   \itemize{
#'     \item `setMaxEnsembleSize`: `integer(1)` range: \[1, Inf\]
#'   }
#'
#'   \item `timeseriesweka.classifiers.BagOfPatterns` \cr
#'   Bag of Patterns \cr
#'   Hyperparameters: *None* \cr
#'
#'   \item `timeseriesweka.classifiers.SAX_1NN` \cr
#'   Symbolic Aggregate Approximation \cr
#'   Hyperparameters: *None* \cr
#'
#'   \item `timeseriesweka.classifiers.SAXVSM` \cr
#'   Symbolic Aggregate Approximation - Vector Space Model \cr
#'   Hyperparameters: *None* \cr
#' }
#'
#' @section Shapelet based Classifiers:
#' \itemize{
#'   \item `timeseriesweka.classifiers.ShapeletTransformClassifier` \cr
#'   Shapelet transformation that separates the Shapelet discovery from the classifier by
#'   finding the top k Shapelets in a single run \cr
#'   Hyperparameters:
#'   \itemize{
#'     \item `setTransformType`: character(1) \cr
#'       values: "univariate","uni","shapeletd","shapeleti"
#'     \item `setNumberOfShapelets`: `integer(1)` range: \[1, Inf\]
#'   }
#'
#'   \item `timeseriesweka.classifiers.FastShapelets` \cr
#'   Fast Shapelets (FS) \cr
#'   Hyperparameters: *None* \cr
#'
#'   \item `timeseriesweka.classifiers.LearnShapelets` \cr
#'   Learned Shapelets (LS): \cr
#'   Hyperparameters: *None* \cr
#'
#' }
#'
#' @section Interval based Classifiers:
#' \itemize{
#'   \item `timeseriesweka.classifiers.TSF` \cr
#'   Time Series Forest (Deng et al.,2013) \cr
#'   Hyperparameters: \cr
#'   \itemize{
#'     \item `setNumTrees`: `integer(1)` range: \[1, Inf\]
#'   }
#'
#'   \item `timeseriesweka.classifiers.TSBF` \cr
#'   Time Series Bag of Features (TSBF) \cr
#'   Hyperparameters: \cr
#'   \itemize{
#'     \item `setZLevel`: `double(1)`
#'   }
#'
#'   \item `timeseriesweka.classifiers.LPS` \cr
#'   Learned Pattern Similarity (LPS) \cr
#'   Hyperparameters: *None* \cr
#' }
#'
#' @section Time Series Classifier:
#' \itemize{
#'   \item `timeseriesweka.classifiers.DTW_kNN` \cr
#'   specialization of kNN that can only be used with the efficient DTW distance \cr
#'   Hyperparameters: \cr
#'   \itemize{
#'     \item `setMaxR`: `double(1)` range: \\[0, 1\] set max window size
#'   }
#'
#'   \item `timeseriesweka.classifiers.FastDTW_1NN` \cr
#'   fast Dynamic time warping with 1 nearest neighbor \cr
#'   Hyperparameters: \cr
#'   \itemize{
#'     \item `setR`: `double(1)`
#'   }
#'
#'   \item `timeseriesweka.classifiers.SlowDTW_1NN` \cr
#'   compare with FastDTW_1NN \cr
#'   Hyperparameters: \cr
#'   \itemize{
#'     \item `setR`: `double(1)`
#'   }
#' }
#'
#'
#' @section Weka Classifiers:
#' Several WEKA classifiers have been implemented in the Time-Series Classification
#' Bake-off. \cr
#' The use of those classifiers is discouraged from within TSClassification,
#' but nonetheless implemented for completeness. \cr
#' We advise to use the official implementations from package RWeka
#' (\url{https://cran.r-project.org/web/packages/RWeka/index.html}) for greater
#' flexibility and improved support for setting hyperparameters. \cr
#' \itemize{
#'   \item weka.classifiers.functions.Logistic
#'   \item weka.classifiers.bayes.BayesNet
#'   \item weka.classifiers.bayes.NaiveBayes
#'   \item weka.classifiers.functions.Logistic
#'   \item weka.classifiers.functions.MultilayerPerceptron
#'   \item weka.classifiers.functions.SMO
#'   \item weka.classifiers.meta.RotationForest
#'   \item weka.classifiers.trees.J48
#'   \item weka.classifiers.trees.RandomForest
#' }
#'
#' @return [`character`] Names of available classifiers.
#' @examples
#' tsc_classifiers()
#' @export
tsc_classifiers = function() {
    c(
      # Ensemble Classifiers
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ERP1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.LCSS1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.TWE1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN",
      "timeseriesweka.classifiers.ElasticEnsemble",
      "timeseriesweka.classifiers.FlatCote",

      #Differential Distance Based Classifiers
      "timeseriesweka.classifiers.NN_CID",
      "timeseriesweka.classifiers.DD_DTW",
      "timeseriesweka.classifiers.DTD_C",

      #Dictionary Based Classifiers
      "timeseriesweka.classifiers.BagOfPatterns",
      "timeseriesweka.classifiers.SAX_1NN",
      "timeseriesweka.classifiers.SAXVSM",
      "timeseriesweka.classifiers.BOSS",

      #Shapelet Based Classifiers
      "timeseriesweka.classifiers.FastShapelets",
      "timeseriesweka.classifiers.ShapeletTransformClassifier",
      "timeseriesweka.classifiers.LearnShapelets",

      #Interval Based Classifiers
      "timeseriesweka.classifiers.TSF",
      "timeseriesweka.classifiers.TSBF",
      "timeseriesweka.classifiers.LPS",

      # Weka Classifiers
      "weka.classifiers.bayes.BayesNet",
      "weka.classifiers.bayes.NaiveBayes",
      "weka.classifiers.functions.Logistic",
      "weka.classifiers.functions.MultilayerPerceptron",
      "weka.classifiers.functions.SMO",
      "weka.classifiers.meta.RotationForest",
      "weka.classifiers.trees.J48",
      "weka.classifiers.trees.RandomForest",

      # single classifier
      "timeseriesweka.classifiers.DTW_kNN",
      "timeseriesweka.classifiers.FastDTW_1NN",
      "timeseriesweka.classifiers.RISE",
      "timeseriesweka.classifiers.SlowDTW_1NN"

    )
}
