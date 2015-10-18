# install.packages("e1071")
# klar is needed for nb (naive bayes)??? I guess so...
library(caret)
library(klaR)
library(MASS)
library(e1071)
# load the iris dataset
data(iris)
# define training control
train_control <- trainControl(method="repeatedcv", number=10, repeats=3)
# train the model 
model <- train(Species~., data=iris, trControl=train_control, method="nb")
# make predictions
predictions <- predict(model, iris[,1:4])
# summarize results
confusionMatrix(predictions, iris$Species)