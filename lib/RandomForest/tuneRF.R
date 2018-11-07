# hyperparameter grid
hyper_grid.h2o <- list(
  ntrees      = seq(200, 600, by = 100),
  mtries      = seq(2, 8, by = 2),
  sample_rate = c(.55, .632, .70, .80)
)

# random grid search criteria
search_criteria <- list(
  strategy = "RandomDiscrete",
  stopping_metric = "mse",
  stopping_tolerance = 0.0005,
  stopping_rounds = 10,
  max_runtime_secs = 30*60
)

# build grid search 
grid <- h2o.grid(
  algorithm = "randomForest",
  grid_id = "rf_grid",
  x = feat_train, 
  y = label_train, 
  training_frame = train.h2o,
  hyper_params = hyper_grid.h2o,
  search_criteria = list(strategy = "Cartesian")
)

# collect the results and sort by our model performance metric of choice
grid_perf2 <- h2o.getGrid(
  grid_id = "rf_grid2", 
  sort_by = "mse", 
  decreasing = FALSE
)

# Grab the model_id for the top model, chosen by validation error
best_model_id <- grid_perf2@model_ids[[1]]
best_model <- h2o.getModel(best_model_id)

# Now let’s evaluate the model performance on a test set
ames_test.h2o <- as.h2o(ames_test)
best_model_perf <- h2o.performance(model = best_model, newdata = ames_test.h2o)

# RMSE of best model
h2o.mse(best_model_perf) %>% sqrt()
## [1] 23104.67



featMat <- feat_train[, , 1]
labMat <- label_train[, 1, 1]
trainMat <- cbind(featMat,labMat)
y <- "labMat"
colnames(trainMat) <-c(1:8,"labMat")
x <- setdiff(names(trainMat), y)
x
