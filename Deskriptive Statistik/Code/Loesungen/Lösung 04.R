#### Lösung Aufgabenserie 4: Daniel Baumgartner ####

library(MASS)
options(digits = 7)
#### Aufgabe: arithmetischer Mittelwert ####
wait = faithful$waiting
mean(wait)

#### Aufgabe: Median ####
median(wait)

#### Aufgabe: Quartile ####
quantile(wait)

#### Aufgabe: Quantile ####
quantile(wait, c(.17, .43, .67, .85))

#### Aufgabe: Spannweite ####
range(wait)[2]-range(wait)[1]

#### Aufgabe: Interquartilsabstand ####
IQR(wait)

#### Aufgabe: Boxplot ####
boxplot(wait, horizontal = TRUE)

#### Aufgabe: Varianz ####
#Stichprobenvarianz
var(wait)

#Populationsvarianz
pv = var(wait)*(length(wait)-1)/length(wait)
pv

#### Aufgabe: Standardabweichung ####
# Stichprobenstandardabweichung:
sd(wait)

# Populationsstandardabweichung:
pv^.5

#### Aufgabe: Korrelationskoeffizient ####
cor(swiss$Fertility, swiss$Education)

