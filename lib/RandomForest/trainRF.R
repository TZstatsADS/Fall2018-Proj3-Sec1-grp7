###########################################################
### Train a classification model with training features ###
###########################################################

### Author: Hongru Liu
### Project 3 Group 7


trainRF <- function(feat_train, label_train, par=NULL){
  
  ### Train a Random Forest Model using processed features from training images
  
  ### Input: 
  ###  -  features from LR images 
  ###  -  responses from HR images
  ### Output: a list for trained models
  
  ### load libraries
  library(randomForest)
  
  ### creat model list
  modelList_RF <- list()
  
  ### Train with random forest model
  if(is.null(par)){
    samplesize <- 0.632
  } else {
    samplesize <- par$samplesize
  }
  
  ### the dimension of response array is * x 4 x 3, which requires 12 classifiers
  ### this part can be parallelized
  for (i in 1:12){
    ## calculate column and channel
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
    featMat <- feat_train[, , c2]
    labMat <- label_train[, c1, c2]
    
    fit_RF <- tuneRF(featMat, labMat, mtryStart = 1, ntreeTry = 600, stepFactor = 1.5, improve = 1e-05, plot = FALSE, doBest = TRUE, samplesize = samplesize)
    best_mtry <- fit_RF$mtry
    
    modelList_RF[[i]] <- list(fit_RF=fit_RF, mtry=best_mtry)
  }
  
  return(modelList_RF)
}
