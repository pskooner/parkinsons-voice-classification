packages <- c(
  "tidyverse", "corrplot", "caret", "pROC", "randomForest",
  "e1071", "glmnet", "kernlab", "nnet"
)

missing <- packages[!vapply(packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) install.packages(missing)
