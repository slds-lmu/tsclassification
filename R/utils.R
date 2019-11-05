#' Dump a data.frame to a .arff file.
#'
#' Saves a data.frame to an arff, so it can be used for the time-series
#' classifier.
#'
#' @param data [`data.frame`] | [`character`] \cr
#'   Either a `data.frame` containing the data, or the file path.
#'   In the latter case, nothing happens and the file path is only checked for consistency.
#' @param target [`character`] \cr
#'   Target variable.
#' @param data_path [`character`] \cr
#'  Path to save data to. If NULL, a temporary file is created.
#' @param step [`character`] \cr
#'   Step in the procedure, either "train or "test".
#'   Some additional steps are performed in case "train".
#' @return The file path
#' @examples
#'   data = data.frame(matrix(rnorm(300), nrow = 30))
#'   data$class = factor(sample(letters[1:2], 10, replace = TRUE))
#'   data_to_path(data, target = "class", data_path = tempfile(), step = "train")
#' @export
data_to_path = function(data, target = "target", data_path = NULL, step = "train") {
  # Data is either a path that points to the data or a data.frame
  # containing the data.
  assert(check_string(data), check_data_frame(data), combine = "or")
  assert_choice(step, c("train", "predict"))
  assert_string(target, null.ok = TRUE)
  assert_string(data_path, null.ok = TRUE)

  if (is.character(data)) {
    data_path = assert_file_exists(data)
  }

  # Write the data.frame to a file.
  if (is.data.frame(data)) {
    # Make sure target variable is the last column.
    cn = colnames(data)
    if (step == "train") {
      assert_choice(target, cn)
      data = data[, c(setdiff(cn, target), target)]
      data[[target]] = as.factor(data[[target]])
    }

    # Create a filepath.
    if (is.null(data_path))
      data_path = tempfile(pattern = "tsclassif_data", fileext = ".arff")
    if (file.exists(data_path)) {
      warning(sprintf("File %s already exists, will not be overwritten!", data_path))
    } else {
      farff::writeARFF(data, data_path)
    }
  }
  return(data_path)
}

# Delete a file.
#
# @param data_path [`character`] Path to save data to. If null, a
#   temporary file is created.
# @return NULL
delete_data_from_path = function(data_path) {
  file.remove(data_path)
}

# Flatten a list of parameter values to a single string
#
# Transforms e.g. `list(a = "5")` to a string "a = 5".
# Multiple elements are concatenated using a ','.
# @param par_vals [`list`] Parameter values.
# @return [`character`]
par_vals_to_string = function(par_vals) {
  assert_list(par_vals, null.ok = TRUE, names = "named")
  if (length(par_vals) == 0) {
    pv = ""
  } else {
    pv = unlist(par_vals)
    pv = paste0(names(pv), "_", pv, collapse = ",")
  }
  return(pv)
}

# Check whether classifier name is valid. (Case-insensitive)
# In case only a substring is given, returns the full name
# of the classifier.
#
# @param classifier [`character`] \cr
#   Classifier from tsc_classifiers() or short identifier (substring).
# @return [`character`]
check_classifier = function(classifier) {
  avail = tsc_classifiers()
  # Allow for substrings
  clf = avail[grepl(tolower(classifier), tolower(avail), fixed = TRUE)]
  if (length(clf) == 0) stop(sprintf("Classifier %s not available!", classifier))
  if (length(clf) >= 2) stop(sprintf("Classifier %s is ambigous! Please supply an unambigous identifier!", classifier))
  return(clf)
}
