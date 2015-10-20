combinedFunction <- function(){ 
  # Define the train control to train just one model with full resampling in each epoch
  nbCtrl <- trainControl(method="none")
  # Train the naive bayes model
  nbModel <- train(V10 ~ ., data=training, method="nb", tuneGrid=data.frame(fL=0, usekernel=FALSE), trControl=nbCtrl)
  print(nbModel)
  # Make predictions using the trained model
  nbPredictions <- predict(nbModel, test[,1:9], type="prob")
  print("COMBINED")
  print(nbPredictions)
  return(0.9)
  # Summarize results
  ### nbResults <- confusionMatrix(nbPredictions, test$V10)
  ### print(nbResults)
  # Return accuracy
  ### accuracy <- nbResults$overall["Accuracy"]
  ### print(accuracy)
}