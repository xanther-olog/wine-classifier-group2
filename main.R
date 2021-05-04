library(rpart)
library(plotly)
library(rpart.plot)
library(RColorBrewer)
library(rattle)
source("C:/Users/Arkadeep/Documents/MBA-BITS/Sem 2/BA/FinalProj/functions/MAE.r")
wineQualityDataset <-
  read.csv(
    "C:/Users/Arkadeep/Documents/MBA-BITS/Sem 2/BA/FinalProj/wine-quality-dataset.csv"
  )
plot_ly(data = wineQualityDataset,
        x = ~ quality,
        type = "histogram")
wineQualityDatasetForBoxPlot <- wineQualityDataset
wineQualityDatasetForBoxPlot$qual <-
  ifelse(
    wineQualityDatasetForBoxPlot$quality == 3,
    "A_qThree",
    ifelse(
      wineQualityDatasetForBoxPlot$quality == 4,
      "B_qFour",
      ifelse(
        wineQualityDatasetForBoxPlot$quality == 5,
        "C_qFive",
        ifelse(
          wineQualityDatasetForBoxPlot$quality == 6,
          "D_qSix",
          ifelse(
            wineQualityDatasetForBoxPlot$quality == 7,
            "E_qSeven",
            ifelse(
              wineQualityDatasetForBoxPlot$quality == 8,
              "F_qEight",
              "G_qNine"
            )
          )
        )
      )
    )
  )
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ alcohol,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ density,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ fixed.acidity,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ volatile.acidity,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ citric.acid,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ residual.sugar,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ chlorides,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ free.sulfur.dioxide,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ total.sulfur.dioxide,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ pH,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)
plot_ly(
  data = wineQualityDatasetForBoxPlot,
  x = ~ qual,
  y = ~ sulphates,
  color = ~ qual,
  type = "box",
  colors = "Dark2"
)

trainingData <- wineQualityDataset[1:457,]
validationData <- wineQualityDataset[458:653,]
modelForTrainingData <- rpart(quality ~ . , data = trainingData)
fancyRpartPlot(modelForTrainingData, uniform = TRUE, main = "Unmoderated regression tree")
testModelPrediction <- predict(modelForTrainingData, validationData)
print("Summary of unmoderated tree model:")
print(summary(testModelPrediction))
print("Summary of actual data:")
print(summary(validationData$quality))
sprintf(
  "Mean Absolute Error using RPart: %f",
  MAE(validationData$quality, testModelPrediction)
)
print("Displaying CP table for unmoderated tree model:")
printcp(modelForTrainingData)
sprintf("CP with least cross-validated error is: %f",
        modelForTrainingData$cptable[which.min(modelForTrainingData$cptable[, "xerror"]), "CP"])
plotcp(modelForTrainingData)
prunedTree <- prune(modelForTrainingData,
                    cp = modelForTrainingData$cptable[which.min(modelForTrainingData$cptable[, "xerror"]), "CP"])
fancyRpartPlot(prunedTree, uniform = TRUE,
               main = "Pruned Regression Tree")
testModelPredictionForPrunedTree <-
  predict(prunedTree, validationData)
print("Summary of pruned tree model:")
print(summary(testModelPredictionForPrunedTree))
print("Summary of actual data:")
print(summary(validationData$quality))
sprintf(
  "Mean Absolute Error using RPart Pruned Tree: %f",
  MAE(validationData$quality, testModelPredictionForPrunedTree)
)

#test for one sample
test <-
  data.frame(
    fixed.acidity = 8.5,
    volatile.acidity = 0.33,
    citric.acid = 0.42,
    residual.sugar = 10.5,
    chlorides = 0.065,
    free.sulfur.dioxide = 47,
    total.sulfur.dioxide = 186,
    density = 0.9955,
    pH = 3.10,
    sulphates = 0.40,
    alcohol = 9.9
  )
testPrediction <- predict(prunedTree, test)
sprintf("The wine quality for the following parameters is estimated to be: %f",
        testPrediction)

copyOfDataset <- wineQualityDataset
copyOfDataset$quality_level <-
  ifelse(
    copyOfDataset$quality < 5,
    "Poor",
    ifelse(copyOfDataset$quality >= 7,
           "Good",
           "Moderate")
  )
copyOfTrainingData <- copyOfDataset[1:457,]
copyOfValidationData <- copyOfDataset[458:653,]
classificationTreeModel <-
  rpart(
    quality_level ~ fixed.acidity + volatile.acidity + citric.acid + residual.sugar + chlorides + free.sulfur.dioxide + total.sulfur.dioxide + density + pH + sulphates + alcohol ,
    data = copyOfTrainingData
  )
fancyRpartPlot(classificationTreeModel, uniform = TRUE, main = "Classification tree")
classificationPredictionModel <-
  predict(classificationTreeModel, copyOfValidationData)

print("Confusion matrix before pruning:")
table(round(testModelPrediction), validationData$quality)
print("Confusion matrix after pruning:")
table(round(testModelPredictionForPrunedTree), validationData$quality)