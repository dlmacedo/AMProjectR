# Install packages
# Install.packages("caret", dependencies = c("Depends", "Suggests"))
# Load libraries
library(caret)
library(klaR)
# Load source files
# source("FriedmanNemenyi.R", echo = TRUE)
# Define output sink
# sink("AMProjectR.out")
# Define and show data and time
today <- Sys.Date()
format(today, format="%B %d %Y")
# Load tic-tac-toe dataset and do some basic verifications
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
head(data, 10)
tail(data, 10)
str(data)
summary(data)
#data[data$V10=="positive",]
#data[data$V10=="negative",]
# Create structured partition (folds) based on desired class and do some basic verifications
folds <- createFolds(data$V10)
print(folds)
str(folds)
# Define the training sample excluding fold i
training <- data[-folds[[1]],]
nrow(training)
# Define the test sample using only fold i
test <- data[folds[[1]],]
nrow(test)

#folds$Fold01
#data[folds$Fold01,]
#data[-folds$Fold01,]
# Execute Friedman and Nemenyi tests 
source("FriedmanNemenyi.R", echo = TRUE)
# Stop output sink
# sink()
