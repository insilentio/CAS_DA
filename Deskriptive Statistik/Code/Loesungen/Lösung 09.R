#### Lösung Aufgabenserie 9: Daniel Baumgartner ####
#Annahme: einzulesende Dateien befinden sich im working directory
library(MASS)
library(car)
library(moments)
library(readxl)

# Konstante Texte definieren
pkleiner <- "p-Wert ist kleiner als α, somit wird H0 verworfen"
pgroesser <- "p-Wert ist grösser als α, somit wird H0 beibehalten"


#### Aufgabe: Anpassungstests ####
# Annahme: Signifikanzniveau α = 5%
# H0: beobachtete und erwartete Häufigkeiten sind gleich
# Ha: beobachtete und erwartete Häufigkeiten sind unterschiedlich
α = .05
smoke.freq <- table(survey$Smoke)
smoke.beobachtet <- as.numeric(as.character(smoke.freq))
smoke.prob <- c(.045, .795, .085, .075)
# erwartete Verteilung in absolute Werte umrechnen
smoke.erwartet <- smoke.prob*sum(smoke.freq)

# chisq berechnen
n <- length(smoke.beobachtet)
chisq <- 0
for (i in 1:n) {
  chisq <- chisq + (smoke.beobachtet[i]-smoke.erwartet[i])^2 / smoke.erwartet[i]
}

pval <- pchisq(chisq, df = 3, lower.tail = F)
pval
ifelse(pval < α, pkleiner, pgroesser)



#### Aufgabe: Unabhängigkeitstests ####
# H0: die beobachteten und die erwarteten Häufigkeiten sind gleich. Die beiden Zufallsvariablen sind unabhängig
# Ha: die beobachteten und die erwarteten Häufigkeiten sind verschieden. Die beiden Zufallsvariaben sind abhängig
α = .05
rauchen <- read_excel("RauchenGeschlecht.xlsx")
  table.rauchen <- table(rauchen$`Rauchverhalten der Eltern`, rauchen$`Geschlecht des Kindes`)
chi <- chisq.test(table.rauchen)
chi
ifelse(chi$p.value < α, pkleiner, pgroesser)



#### Aufgabe: Jarque-Bera-Test ####
# Annahme: Signifikanzniveau α = 5%
# H0: Daten sind normalverteilt, Ha: Daten sind nicht normalverteilt
height.M <- survey[survey$Sex == "Male",]$Height
height.M <- as.numeric(na.omit(height.M))
jarque <- jarque.test(height.M)
jarque
ifelse(jarque$p.value < α, pkleiner, pgroesser)



#### Aufgabe: QQ-Plot ####
# Annahme: Signifikanzniveau α = 5%
height.F <- survey[survey$Sex=="Female",]$Height
height.F <- as.numeric(na.omit(height.F))
qqPlot(height.F)
