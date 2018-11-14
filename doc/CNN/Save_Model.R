if(save_model){
  cat("Saving models... \n")
  #Save Model
  getinto(dirname);
save(model_red,model_green,model_blue,file="model.RData")                                                                                 
}else{
  cat("Model not saved... \n")
}

#Going back to the original directory
setwd(wd)