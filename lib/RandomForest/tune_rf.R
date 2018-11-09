#########################################################
### Train a randomForest model with training features ###
#########################################################

### Author: Hongru Liu hl3148
### Project 3 Group 7


train_rf <- function(feat_train, label_train, grid, search_criteria) {
  
  ## load library
  library("EBImage")
  library("randomForest")
  library("caret")
  library("h2o")
  library("doParallel")
  
  ## define modelList
  modelList <- list()
  
  if(is.null(grid)){
    hyper_grid.h2o <- list(
      ntrees = 200,
      mtries = 1,
      sample_rate = .632)
  } else {
    hyper_grid.h2o <- grid
  }
  
  if(is.null(search_criteria)){
    search_criteria <- list(strategy = "Cartesian")
  } else {
    search_criteria <- search_criteria
  }
  
  ## start up h2o
  h2o.no_progress()
  h2o.init()
  
  for (i in 1:12) {
    
    ## calculate column and channel
    cat("i =",i,"\n")
    c1 <- (i-1) %% 4 + 1
    c2 <- (i-c1) %/% 4 + 1
    featMat <- feat_train[, , c2]
    labMat <- label_train[, c1, c2]
    datMat <- cbind(featMat,labMat)
    colnames(datMat) <- c(1:9)
    datMat.h2o <- as.h2o(datMat)
    x <- c(1:8)
    y <- 9
    
    ## train randomForest model
    grid <- h2o.grid(
      algorithm = "randomForest",
      x = x,
      y = y, 
      training_frame = datMat.h2o,
      hyper_params = hyper_grid.h2o,
      search_criteria = search_criteria)
    
    grid_perf <- h2o.getGrid(
      grid_id = "rf_grid", 
      sort_by = "mse", 
      decreasing = FALSE)
    
    best_model_id <- grid_perf@model_ids[[1]]
    best_model <- h2o.getModel(best_model_id)
    
    modelList[i] <- list(model=best_model, grid=grid_perf)
    
  }
  return(modelList)
}

















