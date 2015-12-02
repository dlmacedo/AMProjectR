#install.packages("tsne")
library(tsne)
data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/tic-tac-toe/tic-tac-toe.data", header=FALSE)
num <- data.frame(nrow=958, ncol=10)
for (i in 1:958){
  for (j in 1:9){
    if (data[i,j]=="x") num[i,j] <- -1
    else
    if (data[i,j]=="o") num[i,j] <- 0
    else
    if (data[i,j]=="b") num[i,j] <- 1
  }
  if (data[i,10]=="positive") num[i,10] <- "positive"
  else
  if (data[i,10]=="negative") num[i,10] <- "negative"
}
colors = rainbow(length(unique(num$V10)))
names(colors) = unique(num$V10) 
ecb = function(x,y){ plot(x, t='n'); text(x, col=colors[num$V10]) }
tsne_num = tsne(num[,1:9], epoch_callback = ecb, perplexity=100)
