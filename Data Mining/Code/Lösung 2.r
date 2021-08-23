#set the working directory specific to my machine
setwd("/Users/Andrea/Documents/Iniziative/BFH/2017/1_course/R-Scripts Woche 1/dataset/HMP_Dataset")


#create a data frame from all files in specified folder
create_activity_dataframe = function(activityFolder,classId) {
  file_names = dir(activityFolder)
  file_names = lapply(file_names, function(x){ paste(".",activityFolder,x,sep = "/")})
  your_data_frame = do.call(rbind,lapply(file_names,function(x){read.csv(x,header = FALSE,sep = " ")}))
  your_data_frame = cbind(data.frame(rep(classId,nrow(your_data_frame))),your_data_frame)
  your_data_frame = cbind(data.frame(1:nrow(your_data_frame)),your_data_frame)
  colnames(your_data_frame) = c("timestep","class","x","y","z")
  your_data_frame = cbind(mean(your_data_frame$x),mean(your_data_frame$y),mean(your_data_frame$z),your_data_frame)
  colnames(your_data_frame) = c("mx","my","mz","timestep","class","x","y","z")
  your_data_frame
}

df1 = create_activity_dataframe("Brush_teeth",1)
head(df1)
library(ggplot2)
df1_sample = df1[sample(nrow(df1), 100), ]
ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

df2 = create_activity_dataframe("Climb_stairs",2)
df = rbind(df1,df2)
head(df)

#write.csv(df,"dsx_movement_pattern.csv")

number_of_clusters=2
n = nrow(df)

first_attempt = kmeans(df,centers=number_of_clusters)
# discover the elements that where correctly identified, TRUE, and those that were not, FALSE
truthVector = first_attempt$cluster == df$class 
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
# calculate the accuracy
good/(good+bad)

#set.seed(13)
set.seed(123) #fix the random numbers --> otherwise the results will always be a bit different
# build the df without class and timestep
df_mx_my_mz_x_y_z = cbind(df$mx,df$my,df$mz,df$x,df$y,df$z)
km = kmeans(df_mx_my_mz_x_y_z,centers=number_of_clusters)
dft <- df[c(1:3,6:8)]
#evaluate
truthVector = km$cluster == df$class
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)

