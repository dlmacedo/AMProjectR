# load the libraries
library(caret)
library(klaR)
# load the iris dataset
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
folds <- createFolds(data$V10)
# define an 80%/20% train/test split of the dataset
# trainIndex <- createDataPartition(iris$Species, p=0.80, list=FALSE)
#data_train <- iris[ trainIndex,]
#data_test <- iris[-trainIndex,]
training <- data[-folds[[1]],]
test <- data[folds[[1]],]
# train a naive bayes model
ctrl <- trainControl(method="none")
model <- train(V10 ~ ., data=training, method="nnet", tuneGrid=data.frame(size=3, decay=0.01), trControl=ctrl)
# make predictions
model
predictions <- predict(model, test[,1:9])
# summarize results
confusionMatrix(predictions, test$V10)
