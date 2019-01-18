context("test-all-classifiers")

test_that("Test a basic set of classifiers", {
  train_data = file.path(system.file("arff", package="tsclassification"), "GunPoint_TRAIN")
  test_data  = file.path(system.file("arff", package="tsclassification"), "GunPoint_TEST")

  if (FALSE) {
    classifiers = c(
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.WDTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.DTW1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.MSM1NN",
      # "timeseriesweka.classifiers.FastShapelets", # broken
      "timeseriesweka.classifiers.LearnShapelets",
      "timeseriesweka.classifiers.NN_CID",
      "timeseriesweka.classifiers.TSBF", # slow or broken
      "timeseriesweka.classifiers.TSF",
      "timeseriesweka.classifiers.DTD_C",
      "timeseriesweka.classifiers.BOSS",
      "timeseriesweka.classifiers.RISE",
      "timeseriesweka.classifiers.LPS", # slow
      "timeseriesweka.classifiers.SAXVSM",
      # "timeseriesweka.classifiers.ShapeletTransformClassifier", # broken
      "timeseriesweka.classifiers.DD_DTW",
      "timeseriesweka.classifiers.BagOfPatterns",
      "weka.classifiers.bayes.BayesNet",
      "weka.classifiers.bayes.NaiveBayes",
      "weka.classifiers.functions.Logistic",
      "weka.classifiers.functions.MultilayerPerceptron",
      "weka.classifiers.functions.SMO",
      "weka.classifiers.meta.RotationForest",
      # "vector_classifiers.CAWPE", # broken
      "weka.classifiers.trees.J48",
      "weka.classifiers.trees.RandomForest"
    )
  } else {
    classifiers = c(
      "timeseriesweka.classifiers.ensembles.elastic_ensemble.ED1NN",
      "weka.classifiers.bayes.NaiveBayes",
      "weka.classifiers.functions.Logistic",
      "weka.classifiers.trees.J48",
      "weka.classifiers.trees.RandomForest"
    )
  }

  untested =  c(
    "timeseriesweka.classifiers.TSF",
    "timeseriesweka.classifiers.DTD_C"
  )

  for (classifierName in classifiers) {
    print(classifierName)
    expect_true(test_classifier(classifierName))
  }

})


