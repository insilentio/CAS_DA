library(MASS)
immer

#gepaarter t-Test
#ist die Ernte im einen Jahr besser als im anderen?
#Differenz finden und 95%-Konfidenzintervall bestimmen
t.test(immer$Y1,immer$Y2, paired = T)
#p ist kleiner alpha --> H0 wird verworfen
#Konfidenzintervall beinhaltet die 0 nicht, deshalb kann H0 auch verworfen werden

#ungepaarter t-Test
#H0: Differenz der Mittelwerte ist 0: µA - µM = 0
t.test(mtcars[mtcars$am == 0,]$mpg, mtcars[mtcars$am == 1,]$mpg)
#H0 wird verworfen

#andere Fragestellung: automatisch braucht mehr als manuell (H1), daher:
#H0: µA - µM >= 0
#HA: µA - µM < 0
t.test(mtcars[mtcars$am == 0,]$mpg, mtcars[mtcars$am == 1,]$mpg, alternative = "less")
#H0 wird verworfen

#das kann auch anders notiert werden in R:
t.test(mpg ~ am, data = mtcars, alternative = "less")
#mpg ~ am bedeutet: modelliere mpg (die y-Variable) durch am (die x-Variable)

#höheres Konfidenzniveau:
t.test(mpg ~ am, data = mtcars, alternative = "less", conf.level = .99)
#-> H0 wird immer noch verworfen

#dasselbe aber mit Prozenten. Datensatz quine
head(quine)
table(quine$Eth,quine$Sex)
#Frage: ist der Frauenanteil zw. den Ethnien unterschiedlich?
#mit prop.test:
#correct = F, da es diskrete und nicht stetige Werte gibt (Anz. Personen)
#H0: Differenz ist 0
prop.test(table(quine$Eth,quine$Sex), correct = F)
#p nicht kleiner alpha, daher kann H0 nicht verworfen werden


#Anpassungstests
head(survey)
#Chi-Quadrat: Vergleich beobachtete vs. erwartete Häufigkeiten
#H0: Differenz ist 0 (Rauchverhalten zw. survey und vorherigen Daten hat sich nicht verändert)
levels(survey$Smoke)
smoke.freq <- table(survey$Smoke)
smoke.freq
smoke.expect <- c(.045,.795, .085, .075)
#nun Chi-Quadrat Test mit p-Parameter: der enthält die erwarteten Häufigkeiten
chisq.test(smoke.freq, p=smoke.expect)
#--> H0 kann nicht verworfen werden


#Unabhängigkeitstests
#Zufallsvariablen x und y
#H0: beobachtete und erwartete Häufigkeiten sind gleich (--> Variablen sind unabhängig)
smoke.exer <- table(survey$Smoke, survey$Exer)
smoke.exer
#sind sportliche Aktivitäten und Rauchverhalten unabhängig?
#hier muss p-Parameter nicht angegeben werden, da default Test auf Unabhängigkeit ist
chisq.test(smoke.exer)
#p ist nicht kleiner alpha --> H0 wird nicht verworfen
#Warnmeldung von R: weil gewisse Zahlen nicht genug gross sein (in jeder Zelle sollte mind. 5 stehen)
#manchmal hilft es dann, einzelne Spalten zusammenzulegen
smoke.exer.rev <-cbind(smoke.exer[,1],smoke.exer[,2]+smoke.exer[,3])
chisq.test(smoke.exer.rev)


#Test auf Normalität (sind Daten normalverteilt)
#ginge z.B. mit Chi-Quadrat Verteilung, aber eleganter mit diversen speziellen Tests, z.B.
#Jarque-Bera-Test: operiert mit Schiefe und Kurtosis
library(moments)

#1. Beispiel: normalverteilte Zahlen
daten.norm <- rnorm(10^6)
hist(daten.norm)
jarque.test(daten.norm)
#hoher p-Wert bedeutet wieder: H0 kann nicht verworfen werden

daten.unif <- runif(10^6)
hist(daten.unif)
jarque.test(daten.unif)
#sehr kleiner p-Wert --> H0 wird verworfen

#optischer Test auf Normalität: qq-plot (Normal-Wahrscheinlichkeits-Diagramm)
groesse.men <- survey[survey$Sex == "Male",]$Height
groesse.men <- as.numeric(na.omit(groesse.men))
groesse.men
hist(groesse.men)
qqnorm(groesse.men)
qqline(groesse.men)
#oder noch hübscher
library(car)
qqPlot(groesse.men)
jarque.test(groesse.men)


#lineare Regression
#wie funktioniert die Methode?
library(animation)
least.squares(n=10,ani.type = "slope")

eruptiontime <- lm(eruptions ~ waiting, data=faithful)
#--> geschätztes lineares Modell: eruption = 0.075*waiting - 1.874
#nun für neuen Wert waiting die Eruption schätzen:
test <- data.frame(waiting = 80)
predict(eruptiontime, test)

#Bestimmtheitsmass: R-squared
summary(eruptiontime)
#nebst r-squared kommt auch gleich ein Hypothesentest: (je einer für Intercept und waiting)
# H0: intercept = 0
# H0: waiting = 0



