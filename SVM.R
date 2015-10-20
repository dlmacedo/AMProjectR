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
svmCtrl <- trainControl(method="none")
# Train the SVM model. Dummy variables is doing automatcly in R
svmModel <- train(V10 ~ ., data=training, method="svmRadial", tuneGrid=data.frame(sigma=0.1, C=1), trControl=svmCtrl)
print(svmModel)
# Make predictions using the trained model
svmPredictions <- predict(svmModel, test[,1:9])
print(svmPredictions)
# Summarize results
svmResults <- confusionMatrix(svmPredictions, test$V10)
print(svmResults)
# Return accuracy
accuracy <- svmResults$overall["Accuracy"]
print(accuracy)