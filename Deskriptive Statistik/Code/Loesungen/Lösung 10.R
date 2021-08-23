#### Lösung Aufgabenserie 10: Daniel Baumgartner ####
#Annahme: einzulesende Dateien befinden sich im working directory
library(car)
library(moments)

# Konstante Texte definieren
pkleiner <- "p-Wert ist kleiner als α, somit wird H0 verworfen"
pgroesser <- "p-Wert ist grösser als α, somit wird H0 beibehalten"


#### Aufgabe: Schätzen eines y-Wertes ####
weight.lm <- lm(wt ~ hp, data = mtcars)
weight.lm$coefficients

# Schätzung für 200 PS (in 1000 Pfund)
predict(weight.lm, newdata = data.frame(hp = 200))

# visuelle Verifikation
plot(mtcars$hp, mtcars$wt)
abline(weight.lm)



#### Aufgabe: Bestimmtheitsmass ####
summary(weight.lm)$r.squared



#### Aufgabe: Signifikanztest für β1 ####
# H0: β1 = 0, Ha: β1 ≠ 0
# Annahme: Signifikanzniveau α = 5%
summary(weight.lm)
# p-Wert ist kleiner α, somit wird H0 verworfen.
# Es besteht ein signfikanter Zusammenhang zwischen Gewicht und Motorleistung.



#### Aufgabe: Konfidenzintervalle für y ####
conf <- predict(weight.lm, newdata = data.frame(hp = 200), interval = "confidence", level = .95)
conf
paste("Das 95%-Konfidenzintervall liegt zwisschen:",conf[2], "und", conf[3])



#### Aufgabe: Normalverteilte Residuen ####
weight.res <- weight.lm$residuals
qqPlot(weight.res)
# das sieht optisch mit dem Normal-Wahrscheinlichkeits-Diagramm sehr stark nach normalverteilten Residuen aus

# H0: Residuen sind normalverteilt, Ha: Residuen sind nicht normalverteilt
# Annahme: Signifikanzniveau α = 5%
α <- .05
jarque <- jarque.test(weight.res)
jarque
ifelse(jarque$p.value < α, pkleiner, pgroesser)
# Die Nullhypothese, dass die Residuen normalverteilt sind, wird beibehalten
