nnetFunction <- function(){
  # Define the train control to train just one model with full resampling in each epoch
  nnetCtrl <- trainControl(method="none")
  # Train the neural network model. Dummy variables is doing automatcly in CARET
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
  print("NEURAL NETWORK")
  print(accuracy)
  return(accuracy)
}