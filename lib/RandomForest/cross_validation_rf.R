########################
### Cross Validation ###
########################

### Author: Hongru Liu hl3148
### Project 3 Group 7

cv_rf <- function(X.train, y.train, grid, search_criteria, K){
  
  n <- dim(y.train)[1]
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))
  cv.error <- rep(NA, K)
  
  for (i in 1:K){
    train.feat <- X.train[s != i, ,]
    train.label <- y.train[s != i, ,]
    test.feat <- X.train[s == i, ,]
    test.label <- y.train[s == i, ,]
    
    fit_RF <- train_rf(train.feat, train.label, grid, search_criteria)
    pred_RF <- test_rf(fit_RF, test.feat)
    cv.error[i] <- mean((pred_RF - test.label)^2)
    
  }
  return(c(mean(cv.error),sd(cv.error)))
}



