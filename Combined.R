#library(caret)
combinedFunction <- function(){ 
  # Define the train control to train just one model with full resampling in each epoch
  nbCtrl <- trainControl(method="none")

  # Train the naive bayes model
  nbModel <- train(V10 ~ ., data=training, method="nb", tuneGrid=data.frame(fL=0, usekernel=FALSE), trControl=nbCtrl)
  print(nbModel)
  # Make predictions using the trained model
  nbPredictions <- predict(nbModel, test[,1:9], type="prob")
  print(nbPredictions)

  # Train the kNN model. Dummy variables is doing automatcly in CARET. This is doing this great performance???
  knnModel <- train(V10 ~ ., data=training, method="knn", tuneGrid=data.frame(k=3), trControl=nbCtrl)
  print(knnModel)
  # Make predictions using the trained model
  knnPredictions <- predict(knnModel, test[,1:9], type="prob")
  print(knnPredictions)
  
  sumPredictions <- nbPredictions
  print(sumPredictions)
  
  hard <- test[,10]
  
  for(i in 1:length(sumPredictions[,1])){
    sumPredictions[i,1] <- nbPredictions[i,1] + knnPredictions[i,1] - 0.347
    sumPredictions[i,2] <- nbPredictions[i,2] + knnPredictions[i,2] - 0.653
    
    if(sumPredictions[i,1] >= sumPredictions[i,2])
      { hard[i] <- "negative" } else { hard[i] <- "positive" }
  }
  
  print(hard)
  #for(i in 1:length(nbPredictions[,1]))
  #if(nbPredictions[i,1]<=0.5) { nbPredictions[i,1] <- "positive" } else { nbPredictions[i,1] <- "negative" }
  
  #nbPredictions[] <- nbPredictions[]<=0.5
  #print(nbPredictions[,1])
  print(test[,10])
  g <- test[,10]==hard[]
  print(g)
  accuracy <- mean(g)
  return(accuracy)
  ### print(accuracy)
}
#combinedFunction()