## sink("AMProjectR.out")
## library("caret", lib.loc="C:/Program Files/R/R-3.2.2/library")
library(caret)
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
head(data, 10)
tail(data, 10)
str(data)
summary(data)
data[data$V10=="positive",]
data[data$V10=="negative",]
folds <- createFolds(data$V10)
str(folds)
folds$Fold01
data[folds$Fold01,]
data[-folds$Fold01,]
source("Friedman.R", echo = TRUE)
## sink()
