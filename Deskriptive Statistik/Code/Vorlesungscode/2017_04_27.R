vari = 1
vari = 2
data()
AirPassengers
?AirPassengers
?cars
mtcars
mtcars[2,3]
str(mtcars)
mtcars[,3]
verbrauch = mtcars[,1]
mean(verbrauch)
median(verbrauch)
str(Titanic)

library(MASS)
painters
head(painters)
tail(painters, 3)
painters$School
table(painters$School)
freq = table(painters$School)
cbind(freq)
relfreq = freq/nrow(painters)
relfreq
options(digits = 2)
relfreq
?barplot
farben = c("red", "green", "blue", "pink", "yellow", "orange", "violet", "black")
freq
barplot(freq)
pie(freq)
barplot(freq, col = farben)
mean(painters$Composition)
c_school = painters$School == "C"
c_school
painters[c_school,]
mean(painters[c_school,]$Composition)
