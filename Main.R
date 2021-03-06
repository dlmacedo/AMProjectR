# Define output sink
sink("AMProjectR.txt")

# Install packages
# Install.packages("caret", dependencies = c("Depends", "Suggests"))
# Load libraries
library(caret)
library(FastKNN)
library(PMCMR)
library(e1071)
library(kernlab)
library(klaR)
library(lattice)
library(MASS)
library(nnet)
library(ggplot2)
library(plotrix)

# creating a matrix of global accuracy results
globalResults <- matrix(nrow=100, ncol=6)
colnames(globalResults) <- c("NB","KNN[5]","KNN[7]","COMB[3]","MLP","SVM")

# Load source files
source("NaiveBayes.R", echo = TRUE)
source("ConfidenceIntervals.R", echo = TRUE)
source("KNN.R", echo = TRUE)
source("Combined.R", echo = TRUE)
source("NeuralNetwork.R", echo = TRUE)
source("SVM.R", echo = TRUE)
# source("FriedmanNemenyi.R", echo = TRUE)

# Define and show data and time
today <- Sys.Date()
format(today, format="%B %d %Y")

# Load tic-tac-toe dataset and do some basic verifications
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
# Testing data
head(data, 10)
tail(data, 10)
str(data)
summary(data)

# creating dissimilarity matrix
dissMatrix <- hamming.distance(as.matrix(data[,-10]))
print(dissMatrix)

# Create a loop to produce 10 partitions
for(i in 1:10){
  # Create stratified 10 folds partition (default) based on desired class and do some basic verifications
  # The caret library documentation says that this is a stratified partition
  # and this is why the fuction asks for a input class
  folds <- createFolds(data$V10)
  print(folds)
  str(folds)
  # The code below demonstrates that in fact we have a stratified partition
  summary(data[folds[[1]],])

  # Create a loop to create a training and test set
  for(j in 1:10){
    # Define the training sample excluding fold j
    training <- data[-folds[[j]],]
    nrow(training)
    # Define the test sample using only fold j
    test <- data[folds[[j]],]
    nrow(test)

    # Training and testing the classifiers for the current partition and fold selection
    globalResults[10*(i-1)+j,1] <- nbFunction()
    globalResults[10*(i-1)+j,2] <- knnFunction(5)
    globalResults[10*(i-1)+j,3] <- knnFunction(7)
    globalResults[10*(i-1)+j,4] <- combinedFunction()
    globalResults[10*(i-1)+j,5] <- nnetFunction()
    globalResults[10*(i-1)+j,6] <- svmFunction()
    
    # Distance Matrix
    ###distanceExample<-Distance_for_KNN_test(test[,-10], training[,-10])
    # Fast KNN do not create dummy var before trainning...
    ###knn_test_function(training[,-10], test[,-10], distanceExample, training[,10], k = 15)
  }
}

print(globalResults)
#pdf("GlobalResults.pdf")
boxplot(globalResults, main="BOXPLOT FOR CLASSIFIERS")
#dev.off()
write.table(globalResults, "GlobalResults.txt", sep="\t")

confidence <- confidenceInterval()
print(confidence)
interval <- confidence[1,]
#pdf("Confidence.pdf")
plotCI(1:6,interval,confidence[2,],confidence[2,],lwd=2,col="red",scol="blue")
#dev.off()
write.table(confidence, "Confidence.txt", sep="\t")

# Execute Friedman and Nemenyi tests 
friedman.test(globalResults)
posthoc.friedman.nemenyi.test(globalResults)

# Stop output sink
sink()
