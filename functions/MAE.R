MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))
}