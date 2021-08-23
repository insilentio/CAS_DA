## Daniel Baumgartner - Übung: tidy Datensatz erstellen aus Satisfaction.RData----

#preparation - file expected to be in wd
library(data.table)
load("Satisfaction.RData")

#melt all columns except idpers into one
dataMelted = as.data.table(melt(data = data, id = c("idpers"), na.rm = T))
#add column Dim and Jahr, fill first for satisfaction, then for age
dataMelted[,':='(Dimension="sat",Jahr=paste("20",substr(variable,2,3),sep = "")),]
dataMelted[grepl("age", variable),':='(Dimension="age",Jahr=paste("20",substr(variable,4,5),sep = "")),]
#remove unnecessary column
dataMelted$variable = NULL

#cast dimension column into its various values
dataTidy = data.table::dcast(dataMelted, ... ~ Dimension)
dataTidy