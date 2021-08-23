#Übersicht der wichtigsten R-Funktionen ####

#Mathe
factorial(x)  #Fakultät
choose(m,k)  #Binomialkoeffizient

#Statistikmasse
range()
mean()
median()
quantile()
as.numeric(names(fehler)[which.max(fehler)]) #Modus, fehler ist ein table
sd() #Stichproben-Standardabweichung
CramersV <- function(x) {
  sqrt(chisq.test(x)$statistic[[1]] / (sum(x)*(min(dim(x)-1))))
}
cov()
cor()


#Häufigkeiten
table() #Kreuztabelle / Häufigkeitsverteilung
hist()  #Histogramm
cumsum() #kumulierte Häufigkeit
ecdf()  #empirische Dichtefunktion
addmargins() #Randhäufigkeiten
prop.table() #relative Häufigkeiten

#generisches plotten
plot()
lines()
abline()

#lineare Regression
lm(y ~ x) #--> lineares Modell (für Regression): modelliere y mit x

#library(ineq)
Lc() #Lorenzkurve
Gini() #Gini-Koeffizient


#Wahrscheinlichkeiten
dbinom()
dhyper()
dpois()

dunif()
dexp()
dnorm()
dchisq()
dt()


#Daten laden
load()
scan()
read_xls()
read.csv()
