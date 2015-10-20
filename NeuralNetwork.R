# Load the libraries
library(caret)
library(klaR)
# Load tic-tac-toe dataset
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
# Create structured partition (folds) based on desired class
folds <- createFolds(data$V10)
# Define the training sample excluding fold i
training <- data[-folds[[1]],]
nrow(training)
# Define the test sample using only fold i
test <- data[folds[[1]],]
nrow(test)

# Define the train control to train just one model with full resampling in each epoch
nnetCtrl <- trainControl(method="none")
# Train the neural network model. Dummy variables is doing automatcly in R
nnetModel <- train(V10 ~ ., data=training, method="nnet", tuneGrid=data.frame(size=9, decay=0.01), trControl=nnetCtrl)
print(nnetModel)
# Make predictions using the trained model
nnetPredictions <- predict(nnetModel, test[,1:9])
print(nnetPredictions)
# Summarize results
nnetResults <- confusionMatrix(nnetPredictions, test$V10)
print(nnetResults)
# Return accuracy
accuracy <- nnetResults$overall["Accuracy"]
print(accuracy)