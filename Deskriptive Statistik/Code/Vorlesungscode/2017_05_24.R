?dbinom

dbinom(4, 12, .2)  # density (Häufigkeit) für ein einzelnes Element
#Aufgabe Binomialverteilung: max. 4 richtige aus 12 Aufgaben mit je 5 mult.choice
dbinom(0,12,.2) + dbinom(1,12,.2) + dbinom(2,12,.2)+ dbinom(3,12,.2) +dbinom(4,12,.2)
#oder viel eleganter:
pbinom(4,12,.2)

#barplot für alle Eintretenshäufigkeiten 
yprob = dbinom(0:12,12,.2)
names(yprob) = 0:12
barplot(yprob)

#Wahrscheinlichkeit, mindestens 7 richtig zu haben:
1 - pbinom(6,12,.2)
pbinom(6,12,.2,lower.tail = F)


#Aufgabe hypergeometrische Verteilung:
lotto = dhyper(0:6,6,36,6)
names(lotto) = 0:6
barplot(lotto)
#Wahrscheinlichkeit, etwas zu gewinnen (3 und mehr Treffer)
1 - phyper(2,6,36,6)

#Aufgabe Poisson-Verteilung
1- ppois(17,12)
#oder, gleichbedeutend:
ppois(17,12,lower.tail = F)
barplot(dpois(0:30,12),names.arg = 0:30)

#Lieblingsaufgabe
240/.96
dbinom(241,250,.96)
pbinom(240,250,.96,lower.tail = F)
Ppass = dbinom(241:250,250,.96)
Kosten = 1:10*350
Eintreten = Ppass * Kosten
sum(Eintreten)


# Versuch einer eigenen Lösung mit Funktion für das Optimum
verteilung = c(1:x)
optimum = function(n,x,y,t,e) {
  for (i in 1:x) {
    verteilung[i] = (x*t) - sum(dbinom(seq(n+1,n+x,1),n+x,y)*(seq(1,x,1)*e))
  }
}
rm(verteilung)
barplot(optimum(240,30,.96,210,350),names.arg = 1:30)
