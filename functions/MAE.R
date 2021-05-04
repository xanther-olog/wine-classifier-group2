#function to calculate MAE
MAE <- function(actual, predicted) {
  mean(abs(actual - predicted))
}