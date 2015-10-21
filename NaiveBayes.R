nbFunction <- function(){
  # Define the train control to train just one model with full resampling in each epoch
  nbCtrl <- trainControl(method="none")
  # Train the naive bayes model. Dummy variables is doing automatcly in CARET (for also NB???)
  nbModel <- train(V10 ~ ., data=training, method="nb", tuneGrid=data.frame(fL=0, usekernel=FALSE), trControl=nbCtrl)
  print(nbModel)
  # Make predictions using the trained model. If use the option type="prob", the probability of the outputs are returned
  nbPredictions <- predict(nbModel, test[,1:9])
  print(nbPredictions)
  # Summarize results
  nbResults <- confusionMatrix(nbPredictions, test$V10)
  print(nbResults)
  # Return accuracy
  accuracy <- nbResults$overall["Accuracy"]
  print("Naive Bayes")
  print(accuracy)
  return(accuracy)
}