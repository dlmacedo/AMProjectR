Distance_for_KNN_test <- function(test,training){
  value <- matrix(nrow=nrow(test), ncol=nrow(training))
  for(i in 1:nrow(value)){
    #print("TEST ROW")
    #print(row.names(test[i,]))
    a <- as.integer(row.names(test[i,]))
    #print(a)
    for(j in 1:ncol(value)){
      #print("TEST COL")
      #print(row.names(training[j,]))
      b <- as.integer(row.names(training[j,]))
      #print(b)
      value[i,j] <- dissMatrix[a,b]  
    }
  }  
  return(value)
}
