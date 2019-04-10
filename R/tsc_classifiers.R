#' Return available classifiers
#'
#' Run `tsc_classifiers()` to obtain available classifiers.
#'
#' The following classifiers are available: \cr
#' **Ensemble Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN` \cr
#'     Elastic Ensemble of Nearest Neighbour Algorithms \cr
#'     Hyperparameters: *None*
#'
#'   \item `timeseriesweka.classifiers.FlatCote` \cr
#'    Collective of Transformation Ensembles (Bagnall et al.,2015) \cr
#'    Hyperparameters: *None*
#'
#'   \item `timeseriesweka.classifiers.ElasticEnsemble` \cr
#'    Combination of nearest neighbour (NN) classifiers that use elastic distance measures \cr
#'    Hyperparameters: *None*
#' }
#'
#' **Dictionary based Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.BOSS` \cr
#'   Bag of SFA Symbols
#'   Hyperparameters:
#'   \itemize{
#'     \item `setMaxEnsembleSize`: `integer(1)` range: [1, Inf]
#'   }
#' }
#'
#' **Shapelet based Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.ShapeletTransformClassifier` \cr
#'   Shapelet transformation that separates the shapelet discovery from the classifier by
#'   finding the top k shapelets in a single run \cr
#'   Hyperparameters:
#'   \itemize{
#'     \item `setTransformType`: character(1) \cr
#'       values: "univariate","uni","shapeletd","shapeleti"
#'     \item `setNumberOfShapelets`: `integer(1)` range: [1, Inf]
#'   }
#' }
#'
#' **Interval based Classifiers**
#' \itemize{
#'   \item `timeseriesweka.classifiers.TSF` \cr
#'   Time Series Forest (Deng et al.,2013) \cr
#'   Hyperparameters:
#'   \itemize{
#'     \item `setNumTrees`: `integer(1)` range: [1, Inf]
#'   }
#' }
#'
#' **Time-Series Classifiers**
#' \itemize{
#'   \item timeseriesweka.classifiers.LearnShapelets \cr
#'     Learned Shapelets (Grabocka et al., 2014) \cr
#'     Hyperparameters:
#'   \item timeseriesweka.classifiers.NN_CID \cr
#'
#' }
#'
#' **Weka-based Classifiers**
#' Several WEKA classifiers have been implemented in the Time-Series Classification
#' Bake-off. The use of those classifiers is discouraged from within TSClassification,
#' but nonetheless implemented for completeness.
#' We advise to use the official implementations from package [RWeka] for greater
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
#' @return [`character`]
#' @export
tsc_classifiers = function() {
    c(
      # Ensembles
      "timeseriesweka.classifiers.ElasticEnsemble",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN",
      "timeseriesweka.classifiers.HIVECote",
      "timeseriesweka.classifiers.FlatCote",

      # Single Classifiers
      "timeseriesweka.classifiers.FastShapelets",
      "timeseriesweka.classifiers.BOSS",
      "timeseriesweka.classifiers.LearnShapelets",
      "timeseriesweka.classifiers.NN_CID",
      "timeseriesweka.classifiers.TSBF",
      "timeseriesweka.classifiers.TSF",
      "timeseriesweka.classifiers.DTD_C",
      "timeseriesweka.classifiers.RISE",
      "timeseriesweka.classifiers.LPS",
      "timeseriesweka.classifiers.SAXVSM",
      "timeseriesweka.classifiers.ShapeletTransformClassifier", # broken
      "timeseriesweka.classifiers.DD_DTW",
      "timeseriesweka.classifiers.BagOfPatterns",

      # Weka Classifiers:
      "weka.classifiers.bayes.BayesNet",
      "weka.classifiers.bayes.NaiveBayes",
      "weka.classifiers.functions.Logistic",
      "weka.classifiers.functions.MultilayerPerceptron",
      "weka.classifiers.functions.SMO",
      "weka.classifiers.meta.RotationForest",
      "weka.classifiers.trees.J48",
      "weka.classifiers.trees.RandomForest"
    )
}
