knnFunction <- function(){
  # Define the train control to train just one model with full resampling in each epoch
  knnCtrl <- trainControl(method="none")
  # Train the kNN model. The hamming 
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
  print("kNN")
  print(accuracy)
  return(accuracy)
}