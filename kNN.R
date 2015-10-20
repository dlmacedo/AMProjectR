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
knnCtrl <- trainControl(method="none")
# Train the kNN model
knnModel <- train(V10 ~ ., data=training, method="knn", tuneGrid=data.frame(k=5), trControl=knnCtrl)
print(knnModel)
# Make predictions using the trained model
knnPredictions <- predict(knnModel, test[,1:9])
print(knnPredictions)
# Summarize results
knnResults <- confusionMatrix(knnPredictions, test$V10)
print(knnResults)
# Return accuracy
accuracy <- knnResults$overall["Accuracy"]
print(accuracy)