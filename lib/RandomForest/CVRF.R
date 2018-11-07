########################
### Cross Validation ###
########################

### Author: Hongru Liu
### Project 3 Group 7

cv_RF <- function(X.train, y.train, samplesize, K){

  n <- dim(y.train)[1]
  n.fold <- floor(n/K)
  s <- sample(rep(1:K, c(rep(n.fold, K-1), n-(K-1)*n.fold)))
  cv.error <- rep(NA, K)

  for (i in 1:K){
    train.feat <- X.train[s != i, ,]
    train.label <- y.train[s != i, ,]
    test.feat <- X.train[s == i, ,]
    test.label <- y.train[s == i, ,]

    par <- list(samplesize=samplesize)
    fit_RF <- trainRF(train.feat, train.label, par)
    pred_RF <- testRF(fit_RF, test.feat)
    cv.error[i] <- mean((pred_RF - test.label)^2)

  }
  return(c(mean(cv.error),sd(cv.error)))
}
