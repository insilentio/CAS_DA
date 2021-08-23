## Fakultät
factorial(7)

## Binomialkoeffizient
choose(12,7)

getwd()
load("C:/Privat/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/R-Dateien/Daten_WachstumX.RData")
View(Daten_Wachstum)

##Geschlecht mit Branche in Beziehung bringen:
t1 = table(Daten_Wachstum$Geschlecht, Daten_Wachstum$Branche)
## --> liefert noch keine Randhäufigkeiten, deshalb:
addmargins(t1)
## transformatin in relative Häufigkeiten
addmargins(prop.table(t1))
##mit bedingter Häufigkeit auf das zweite Merkmal:
addmargins(prop.table(t1,2))

##um die Umgebung fix auf einen bestimmten dataframe zu setzen (statt immer data_frame$xyz):
attach(Daten_Wachstum)
Alter
detach(Daten_Wachstum)

boxplot(Daten_Wachstum$Alter, subset = Daten_Wachstum$Geschlecht == "Mann")

library(MASS)
mean(faithful$eruptions)
median(faithful$eruptions)
quantile(faithful$eruptions)
boxplot(faithful$eruptions, horizontal = FALSE)
barplot(quantile(faithful$eruptions, seq(0,1,.01)))
barplot(sort(faithful$eruptions))


