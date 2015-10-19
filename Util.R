library(caret)
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
folds <- createFolds(data$V10)
training <- data[-folds[[1]],]
test <- data[folds[[1]],]
nrow(training)
nrow(test)
training
test
#mlpFit <- train(Class ~ ., data = training, method = "mlp", size = 9)
#nnetFit <- train(Class ~ ., data = training, method = "nnet", size = 9)
