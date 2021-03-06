#########################################################
### Train a classification model with training features ###
#########################################################

### Author: Chengliang Tang
### Project 3

### load libraries
library("foreach")
library("dplyr")
library("doParallel")
library("snow")

cl <- makeCluster(detectCores(logical = F))
registerDoParallel(cl)

train <- function(dat_train, label_train, par=NULL){
  
  ### Train a Gradient Boosting Model (GBM) using processed features from training images
  
  ### Input: 
  ###  -  features from LR images 
  ###  -  responses from HR images
  ### Output: a list for trained models
  
  ### creat model list
  modelList <- list()
  
  ### Train with gradient boosting model
  if(is.null(par)){
    depth <- 3
  } else {
    depth <- par$depth
  }
  
  ### the dimension of response array is * x 4 x 3, which requires 12 classifiers
  ### this part has been parallelized
  modelList <- foreach(i=1:12,
                       .packages="gbm") %dopar% {
    ## calculate column and channel
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
    featMat <- dat_train[, , c2]
    labMat <- label_train[, c1, c2]
    fit_gbm <- gbm.fit(x=featMat, y=labMat,
                       n.trees=200,
                       distribution="gaussian",
                       interaction.depth=depth, 
                       bag.fraction = 0.5,
                       verbose=FALSE)
    best_iter <- gbm.perf(fit_gbm, method="OOB", plot.it = FALSE)
    list(fit=fit_gbm, iter=best_iter)
  }
  
  return(modelList)
}

#test_model <- train(test_feat,test_lab)
