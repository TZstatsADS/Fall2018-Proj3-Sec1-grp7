#Load data and Data Pre-processing
cat("Loading training data... \n")
#Load Image with high Resolution
getinto("test")
filelist = c(list.files(pattern = "png"),
             list.files(pattern = "jpg"))
test = imageData(readImage(filelist))

getback()



pic_width = dim(test)[1]
pic_length = dim(test)[2]

#

test_low = aperm(test, c(4,1,2,3))

test_sizetest_size=1000

test_low_red = array(test_low[,,,1],c(test_size,pic_width,pic_length,1))
test_low_green = array(test_low[,,,2],c(test_size,pic_width,pic_length,1))
test_low_blue = array(test_low[,,,3],c(test_size,pic_width,pic_length,1))

#Go back to the previous Work Directory
setwd(wd)



#Predict test_input pictures according to the model

cat("Making predictions based on the model trained... \n")

red_predicted = predict(model_red,test_low_red)[,,,1]
green_predicted = predict(model_green,test_low_green)[,,,1]
blue_predicted = predict(model_blue,test_low_blue)[,,,1]

pic_predicted = Image(data = aperm(array(c(red_predicted,
                                           green_predicted,
                                           blue_predicted),
                                         dim = c(test_size,pic_width,pic_length,3)),
                                   c(2,3,4,1)),
                      colormode = "Color")

#Go back to the previous workspace
setwd(wd)


#Save image predicted temporarily so that it can be accessed
cat("Converting Pictures... \n")
n = 1
dirname = paste("predicted_images_test", n, sep = "")
while(any(dirname == list.files())){
  n = n + 1
  dirname = paste("predicted_images_test", n, sep = "")
}

dir.create(dirname)
getinto(dirname)
writeImage(pic_predicted, paste(seq(1,dim(pic_predicted)[4],1),
                                ".png",sep = ""))

#Color correcting image linear filter
image_list = list.files()
cat("Providing Color Correcting Linear Filter...\n")
progress = 1
progress_bar = txtProgressBar(min = 0,
                              max = length(image_list), style = 3)
for(pic_path in image_list){
  picture = image_read(path = pic_path)
  picture = image_modulate(picture,
                           brightness = 100 - defogging_factor,
                           saturation = 100 + defogging_factor,
                           hue = 100 - defogging_factor/2)
  #Over-write the original images
  setTxtProgressBar(progress_bar, progress)
  image_write(picture, path = pic_path)
  progress = progress + 1
}

#Image sharpness linear filter
cat("\n")
cat("Providing Image Sharpness Linear Filter...\n")
progress = 1
progress_bar = txtProgressBar(min = 0,
                              max = length(image_list), style = 3)
for(pic_path in image_list){
  picture = load.image(file = pic_path)
  picture = imsharpen(picture, amplitude = 1,
                      type = "diffusion")
  setTxtProgressBar(progress_bar, progress)
  #Over-write the images
  save.image(picture, file = pic_path)
  progress = progress + 1
}
cat("\n")

#Going back to the previous image
setwd(wd)


#Show predicted images in one plot
getinto(dirname)
image_list = c(list.files(pattern = "png"),
               list.files(pattern = "jpg"))




images = readImage(files = image_list[1:100])
cat("Showing all predicted images...\n")
#windows()
plot(images, all = TRUE)

#Training history virtualization using plotly
if(use_plotly){
  #Virtualizing training history using plotly
  note("
       Plotly account is registered by a google account.
       Account: thisisforplotly@gmail.com
       Password: thisisforplotly001
       When API key expires or needs to beupdated, please visit:
       https://plot.ly/r/getting-started/#initialization-for-online-plotting
       ")
  Sys.setenv("plotly_username"="plotly_sensei")
  Sys.setenv("plotly_api_key"="1mPE1sKQkjk2qROX1q0S")
  
  #plot Training history for red model
  training_history_red = plot_ly(x = seq(1,length(history_red$metrics$val_loss),1),
                                 y = history_red$metrics$val_loss,
                                 type = "scatter",
                                 mode = "markers") %>%
    layout(xaxis = list(title = "Epoch"),
           yaxis = list(title = "Loss"),
           title = "Training History for Red Model")
  try(
    api_create(training_history_red, filename = "training_history_red"),
    silent = TRUE
  )
  
  #plot Training history for green model
  training_history_green = plot_ly(x = seq(1,length(history_green$metrics$val_loss),1),
                                   y = history_green$metrics$val_loss,
                                   type = "scatter",
                                   mode = "markers") %>%
    layout(xaxis = list(title = "Epoch"),
           yaxis = list(title = "Loss"),
           title = "Training History for Green Model")
  
  try(
    api_create(training_history_green, filename = "training_history_green"),
    silent = TRUE
  )
  
  #plot Training history for blue model
  training_history_blue = plot_ly(x = seq(1,length(history_blue$metrics$val_loss),1),
                                  y = history_blue$metrics$val_loss,
                                  type = "scatter",
                                  mode = "markers") %>%
    layout(xaxis = list(title = "Epoch"),
           yaxis = list(title = "Loss"),
           title = "Training History for Blue Model")
  try(
    api_create(training_history_blue, filename = "training_history_blue"),
    silent = TRUE
  )
}

#Training history virtualization using ggplot
if(use_ggplot){
  #plot Training history for red model
  windows()
  history_data = data.frame(seq(1,length(history_red$metrics$val_loss),1),
                            history_red$metrics$val_loss)
  ggplot(data = history_data, aes(seq(1,length(history_red$metrics$val_loss),1),
                                  history_red$metrics$val_loss)) +
    geom_bin2d() + 
    ggtitle("Training history red") +
    xlab("Epoch") +
    ylab("Loss")
  
  #plot Training history for green model
  windows()
  history_data = data.frame(seq(1,length(history_green$metrics$val_loss),1),
                            history_green$metrics$val_loss)
  ggplot(data = history_data, aes(seq(1,length(history_green$metrics$val_loss),1),
                                  history_green$metrics$val_loss)) +
    geom_bin2d() +
    ggtitle("Training history green") +
    xlab("Epoch") +
    ylab("Loss")
  
  #plot Training history for blue model
  windows()
  history_data = data.frame(seq(1,length(history_blue$metrics$val_loss),1),
                            history_blue$metrics$val_loss)
  ggplot(data = history_data, aes(seq(1,length(history_blue$metrics$val_loss),1),
                                  history_blue$metrics$val_loss)) +
    geom_bin2d() + 
    ggtitle("Training history blue") +
    xlab("Epoch") +
    ylab("Loss")
}

note("
       Please note that even though the models are trained 
       seperately, there are consistancies along with the
       training and the loss of the third model will be
       as expected smaller than that of the first model. Also
       the loss of the third model, as it starts to get really
       low, may starts to throttle.
       ")

if(!any(use_plotly, use_ggplot)){
  cat("Training history not shown... \n")
}

#Going back to the original directory
setwd(wd)

