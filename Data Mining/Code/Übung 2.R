## CAS DA FS2017: Data Mining
## Übung 2
## Daniel Baumgartner
library(dplyr)
library(tidyr)
library(ggplot2)
library(data.table)
library(robustbase)

# 1. Verwenden Sie das bereitgestellte cluster.r script aus der Vorlesung und replizieren die Demonstration indem Sie die Daten vom UCI Machine Learning Repository verwenden ####
setwd("/Users/Daniel/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Data Mining/Data Mining/data1")

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

df1 = create_activity_dataframe("/Users/Daniel/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Data Mining/Data Mining/data1/Brush_teeth",1)
df1_sample = df1[sample(nrow(df1), 100), ]
head(df1_sample)
ggplot(df1_sample, aes(timestep)) + 
  geom_line(aes(y = x, colour = "x")) + 
  geom_line(aes(y = y, colour = "y")) + 
  geom_line(aes(y = z, colour = "z"))

# add more data
df2 = create_activity_dataframe("/Users/Daniel/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Data Mining/Data Mining/data1/Climb_stairs",2)

dfc = rbind(df1,20*df2,30*df3,40*df4)
dim(dfc)
dim(df1)
dim(df2)
df_x_y_z = cbind(dfc$x,dfc$y,dfc$z)

dfc2 = rbind(df1,20*df2)
df_x_y_z2 = cbind(dfc2$x,dfc2$y,dfc2$z)
#number_of_clusters=2
#sum(kmeans(df_x_y_z,centers=number_of_clusters)$withinss)
#sum(kmeans(df_x_y_z2,centers=number_of_clusters)$withinss)

determine_number_of_clusters_2 = function(df,df2) {
  # value with only one cluster
  wss = (nrow(df)-1)*sum(apply(df,2,var))
  # value for the other clusters
  for (i in 2:15) wss[i] = sum(kmeans(df, centers=i)$withinss)
  wss2 = (nrow(df2)-1)*sum(apply(df2,2,var))
  # value for the other clusters
  for (j in 2:15) wss2[j] = sum(kmeans(df2, centers=j)$withinss)
  return(cbind(1:15,wss,wss2))
}
out=determine_number_of_clusters_2(df_x_y_z,df_x_y_z2)
head(out)
out_norm = cbind(out[,1],out[,2]/max(out[,2]),out[,3]/max(out[,3]))
head(out_norm)
dfout_norm = data.frame(out_norm)
colnames(dfout_norm) = c("xplot","four","two")

# plot to see visually how the curves look like --> beim "Knick" ist die optimale Clusterzahl
ggplot(dfout_norm,aes(xplot)) +
  geom_line(aes(y = four, colour = "four")) + 
  geom_line(aes(y = two, colour = "two")) +
  labs(y="normalized within-cluster sum of squares") +
  labs(x="number of clusters")

# ideal scheint 2 zu sein
number_of_clusters=2

kmeans(dfc,centers=number_of_clusters)$centers

df_clas_x_y_z = cbind(dfc$class,dfc$x,dfc$y,dfc$z)
kmeans(df_clas_x_y_z,centers=number_of_clusters)$centers

df_x_y_z = cbind(dfc$x,dfc$y,dfc$z)
determine_number_of_clusters(df_x_y_z)
km = kmeans(df_x_y_z,centers=number_of_clusters)


truthVector = km$cluster != dfc$class
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)

library(scatterplot3d)
df_sample = dfc[sample(nrow(dfc), 500), ]
with(df_sample, {
  scatterplot3d(x,y,z)
})

centers_df = km$centers
colnames(centers_df) = c("x","y","z")
with(data.frame(centers_df), {
  scatterplot3d(x,y,z)
})

centroid1 = data.frame(0,5,km$centers[1,1],km$centers[1,2],km$centers[1,3])
colnames(centroid1) = c("timestep","class","x","y","z")
centroid2 = data.frame(0,6,km$centers[2,1],km$centers[2,2],km$centers[2,3])
colnames(centroid2) = c("timestep","class","x","y","z")
data2plot = rbind(centroid1,centroid2,df_sample)
ds3 = scatterplot3d(data2plot$x,data2plot$y,data2plot$z,color = as.numeric(data2plot$class))


# Versuchen Sie durch generieren zusätzlicher "Features" die Qualität des Clusterings zu erhöhen ####
# inkludieren der Means und Entfernen der clas und timestep
set.seed(123) #fix the random numbers --> otherwise the results will always be a bit different
# build the df without class and timestep
dfr = df[c(1:3,6:8)]
km = kmeans(dfr,centers=number_of_clusters)

#evaluate
#truthVector = km$cluster == df$class
# good = length(truthVector[truthVector==TRUE])
# bad = length(truthVector[truthVector==FALSE])
# good/(good+bad)
sum(km$cluster == df$class)/nrow(dfr)


# weitere features
dfn <- dfr %>%
  mutate(vx = var(x), vy = var(y), vz = var(z))
set.seed(123) #fix the random numbers --> otherwise the results will always be a bit different
km = kmeans(dfn,centers=number_of_clusters)

#evaluate
sum(km$cluster == df$class)/nrow(dfn)
