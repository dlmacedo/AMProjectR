#x <- c(44617, 7066, 17594, 2726, 1178, 18898, 5033, 37151, 4514, 4000)
#x
confidenceInterval <- function(){
confInt <- matrix(nrow=2, ncol=6)
colnames(confInt) <- c("NB","KNN[5]","KNN[7]","COMB","MLP","SVM")
rownames(confInt) <- c("MEAN","STD")

for(m in 1:6){
  globalResults[,m]
  mg <- mean(globalResults[,m])
  me <- qnorm(.975)*(sd(globalResults[,m])/sqrt(12))
  confInt[1,m] <- mg
  confInt[2,m] <- me
  confInt
  }
return(confInt)
}
confidenceInterval()