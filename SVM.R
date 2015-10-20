svmFunction <- function(){
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
  print("SVM")
  print(accuracy)
  return(accuracy)
}