##################################################
### Fit the regression model with testing data ###
##################################################

### Author: Hongru Liu hl3148
### Project 3 Group 7

test_rf <- function(feat_test, modelList) {
  
  ## load library
  library("EBImage")
  library("randomForest")
  library("caret")
  library("h2o")
  library("doParallel")
  
  predMat <- array(NA, c(dim(feat_test)[1], 4, 3))
  
  for (i in 1:12){
    fit_train <- modelList[[i]]
    ### calculate column and channel
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
    featMat <- feat_test[, , c2]
    colnames(featMat) <- c(1:8)
    featMat.h2o <- as.h2o(featMat)
    
    ### make predictions
    predMat[, c1, c2] <- predict(fit_train, featMat.h2o)
  }
  return(predMat)
}
