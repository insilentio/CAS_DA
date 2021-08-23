#### Lösung Aufgabenserie 8: Daniel Baumgartner ####
#Annahme: einzulesende Dateien befinden sich im working directory
library(MASS)

# Konstanten
t1 <- "Das"
t2 <- "%-Konfidenzintervall für die Differenz"
t3 <- "liegt zwischen"
t4 <- "und"

#### Aufgabe: Vergleiche μ1 und μ2, verbundene Samples ####
# H0: µ1 - µ2 = 0, Ha: µ1 - µ2 ≠ 0
α <- .05
s <- sd(immer$Y1 - immer$Y2)
n <- nrow(immer)
xquer <- mean(immer$Y1 - immer$Y2)
tα <- qt((1 - α/2), df = n - 1)

conf <- xquer + c(-tα*s/sqrt(n),tα*s/sqrt(n))
cat(t1, (1-α)*100, t2, "der Durchschnittsernten", t3, conf[1], t4, conf[2])
#Konfidenzintervall beinhaltet die 0 nicht, deshalb wird H0 verworfen



#### Aufgabe: Vergleiche μ1 und μ2, unabhängige Samples ####
# H0: µ1 - µ2 = 0, Ha: µ1 - µ2 ≠ 0
diet <- read.csv("diet.csv", sep = ";", dec = ".")
α <- .1
diet.atkins <- diet[diet$diet == "Atkins",]$loss6
diet.conv <- diet[diet$diet == "Conventional",]$loss6

test <- t.test(diet.atkins, diet.conv, paired = F, conf.level = 1-α)
test
cat(t1, (1-α)*100, t2, "der verschiedenen Diäten nach 6 Monaten", t3, test$conf.int[1], t4, test$conf.int[2], "kg")
#Konfidenzintervall beinhaltet die 0 nicht, deshalb wird H0 verworfen



#### Aufgabe: Vergleich von zwei Populationsanteilen ####
# H0: Männeranteil0 - Männeranteil1 = 0, Ha: Männeranteil0 - Männeranteil1 ≠ 0
load("Daten_Wachstum.RData")
#Annahme: Geschlecht 0 bedeutet Männer
α <- .05
table(Daten_Wachstum$Branche, Daten_Wachstum$Geschlecht)
prop <- prop.test(table(Daten_Wachstum$Branche, Daten_Wachstum$Geschlecht), conf.level = 1-α, correct = F)
prop
cat(t1,(1-α)*100, t2, "des Männeranteils", t3, prop$conf.int[1], t4, prop$conf.int[2])
#Konfidenzintervall beinhaltet die 0, deshalb wird H0 beibehalten

