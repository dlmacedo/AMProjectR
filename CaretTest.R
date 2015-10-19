# install.packages("e1071")
# klar is needed for nb (naive bayes)??? I guess so...
library(caret)
library(klaR)
library(MASS)
library(e1071)
# load the iris dataset
tictactoe <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
# define training control
#train_control <- trainControl(method="none")
# train the model 
#model <- train(V10 ~ ., data=tictactoe, method="nb")
model <- train(V10 ~ ., data=tictactoe, method="nnet", tuneGrid=data.frame(size=3, decay=0.01), trControl=trainControl(method="none"))
# make predictions
predictions <- predict(model, tictactoe[,1:9])
# summarize results
confusionMatrix(predictions, tictactoe$V10)