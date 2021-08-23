#### Lösung Aufgabenserie 5: Daniel Baumgartner ####

#### Aufgabe: Binomialverteilung ####
#1.
pbinom(2,5,18/37, lower.tail = F)

#2.
qbinom(.9,5,18/37)

#### Aufgabe: Hypergeometrische Verteilung ####
#1.
dhyper(5,13,39,5)

#2. 4 gleiche Karten
#falls gemeint war: 4 Karten mit der gleichen Farbe:
dhyper(4,13,39,5)
#falls gemeint war: 4 Karten mit dem gleichen Kartenwert:
#Anz. günstiger Kombinationen dividiert durch Anz. mögliche:
13*choose(48,1)/choose(52,5)


#### Aufgabe: Poissonverteilung ####
#1.
dpois(8, 12.1)

#2.
ppois(10, 12.1)

#3.
ppois(15, 12) - ppois(8, 12.1)

#4.
ppois(11, 12.1, lower.tail = F)

#### Aufgabe: Stetige Gleichverteilung ####
#1.
plot(seq(1,30,.1), dunif(seq(1,30,.1),16,26), ylab = "Uni(x)", xlab = "x", type = "l")
#2.
punif(20,16,26)

#### Aufgabe: Exponentialverteilung ####
#1.
plot(seq(0,10,.1), dexp(seq(0,10,.1),1/3), type = "l", ylab = "Exp(x)", xlab = "x")
#2.
pexp(1,1/3)
#3.
pexp(1,1/3, lower.tail = F)
#4.
pexp(3,1/3) - pexp(1,1/3)
#5.
qexp(.25,1/3)
cat("Ein Viertel der Gespräche dauert maximal",
    qexp(.25,1/3),
    "Minuten (entspricht",
    qexp(.25,1/3)*60,"Sekunden)")

#### Aufgabe: Normalverteilung ####
#1.
pnorm(202,200,4)-pnorm(198,200,4)
#2.
pnorm(205,200,4,lower.tail = F)
#3.
qnorm(.05,200,4)

#### Aufgabe: Chi-Quadrat-Verteilung ####
#1.
pchisq(15,11,lower.tail = F)

#### Aufgabe: Studentsche t-Verteilung ####
#1.
pt(-.5,7)
#2.
pt(1,7)

#### Aufgabe: Schiefe ####
library(e1071)
library(MASS)
#1.
skewness(faithful$waiting)
cat("Die Häufigkeitsverteilung der Wartezeiten von Old Faithful ist linksschief (",
    skewness(faithful$waiting),")")

#2.
kurtosis(faithful$waiting)
print("Die Häufigkeitsverteilung der Wartezeiten von Old Faithful hat weniger Ausreisser als die Normalverteilung (da Kurtosis < 0)")
