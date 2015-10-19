## sink("AMProjectR.out")
## nrow(testing)
## library("caret", lib.loc="C:/Program Files/R/R-3.2.2/library")
## install.packages("caret", dependencies = c("Depends", "Suggests"))
library(caret)
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
head(data, 10)
tail(data, 10)
str(data)
summary(data)
data[data$V10=="positive",]
data[data$V10=="negative",]
folds <- createFolds(data$V10)
folds
str(folds)
folds$Fold01
data[folds$Fold01,]
data[-folds$Fold01,]
data[folds[[1]],]
data[-folds[[1]],]
source("FriedmanNemenyi.R", echo = TRUE)
## sink()
