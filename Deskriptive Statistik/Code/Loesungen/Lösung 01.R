#### Lösung Aufgabenserie 1: Daniel Baumgartner ####

library(MASS)

#### Aufgabe Häufigkeitsverteilung ####
freqComposition = table(painters$Composition)
cbind(freqComposition)

freqSchool = table(painters$School)
dataSchool = data.frame(freqSchool)
maxSchool = subset(dataSchool, Freq == max(freqSchool), select = Var1)
names(maxSchool) = "Schule"
maxSchool

#### Aufgabe rel. Häufigkeitsverteilung ####
options(digits = 3)
relfreqComposition = freqComposition / nrow(painters)
cbind(relfreqComposition * 100)

#### Aufgabe Balkendiagramm ####
barplot(relfreqComposition)

#### Aufgabe Kuchendiagramm ####
pie(relfreqComposition)

#### Aufgabe 1 ####
maxComposition = painters$Composition == max(painters$Composition)
painters[maxComposition,]$School

#### Aufgabe 2 ####
options(digits = 4)
cat(nrow(painters[painters$Colour >= 14,]) / nrow(painters) * 100, "%")

