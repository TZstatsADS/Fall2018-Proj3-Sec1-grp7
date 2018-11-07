##################################################
### Fit the regression model with testing data ###
##################################################

### Author: Hongru Liu
### Project 3 Group 7

testRF <- function(modelList_RF, dat_test){
  
  ### Fit the classfication model with testing data
  
  ### Input: 
  ###  - the fitted classification model list using training data
  ###  - processed features from testing images 
  ### Output: training model specification
  
  ### load libraries
  library("randomForest")
  
  predMat <- array(NA, c(dim(dat_test)[1], 4, 3))
  
  for (i in 1:12){
    fit_train <- modelList_RF[[i]]
    ### calculate column and channel
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
    featMat <- dat_test[, , c2]
    
    ### make predictions
    predMat[, c1, c2] <- predict(fit_train$fit_RF, featMat)
  }
  return(as.numeric(predMat))
}

