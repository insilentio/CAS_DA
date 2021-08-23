#### Lösung Aufgabenserie 3: Daniel Baumgartner ####

library(MASS)

#### Aufgabe: Häufigkeitsverteilung quantitativer Daten ####
#### 1: Häufigkeitsverteilung der Wartezeiten
wait = faithful$waiting
range(wait)
#erstelle Vektor für sinnvolle Intervalle
interWait = seq(floor(min(wait)/10)*10,ceiling(max(wait)/10)*10,5)
#Verteilen mit cut und Häufigkeitsverteilung mit Funktion table:
freqWait = table(cut(wait, breaks = interWait , right = FALSE))
cbind(freqWait)

#### 2: Intervall mit den meisten Eruptionen
erupt = faithful$eruptions
#bestimme obere und untere Grenze und erstelle Vektor für sinnvolle Intervalle
range(erupt)
interErupt = seq(1.5,5.5,.25)
#Häufigkeitsverteilung mit Funktion table:
freqErupt = table(cut(erupt, breaks = interErupt , right = FALSE))
#finde Intervall mit den meisten Eruptionen
max(freqErupt)
freqErupt[2]

#### 3: Häufigkeitsverteilung der Eruptionszeiten
hist(erupt, breaks = interErupt, right = FALSE)$counts

#### Aufgabe: Histogramm ####
hist(wait, breaks = interWait, right = FALSE, main = "Faithful Wait Times",
     col = rainbow(length(interWait)), xlab = "wait length (min)",
     xlim = (c(min(interWait), max(interWait))))

####Aufgabe: Relative Häufigkeitsverteilung stetiger Daten ####
options(digits = 2)
cbind(Relativ=prop.table(freqWait), Prozent=prop.table(freqWait)*100)

#### Aufgabe: Kumulierte Häufigkeitsverteilung ####
kumSum = cumsum(freqWait)
cbind(kumSum)

#### Aufgabe: Kumulierte Häufigkeitsverteilungskurve ####
plot(interWait, c(0,kumSum), xlab = "wait time (min)", ylab = "cumulative waiting events")
lines(interWait, c(0,kumSum))

#### Aufgabe: Kumulierte relative Häufigkeitsverteilung ####
kumRel = cumsum(prop.table(freqWait))
cbind(kumRel)

#### Aufgabe: Kumulierte relative Häufigkeitskurve ####
plot(ecdf(wait), xlab = "wait time (min)", ylab = "relative cumulative waiting events")
#oder:
plot(interWait, c(0,kumRel), xlab = "wait time (min)", ylab = "relative cumulative waiting events")
lines(interWait, c(0,kumRel))

#### Aufgabe: Histogramm ####
#Annahme: Datei im working directory vorhanden
load("Daten_Wachstum.RData")
alter = Daten_Wachstum$Alter
#bestimme oberste Intervallgrenze (+ 1 da rechte Grenze nicht dazugehört)
maxIntVal = 15 + 3*(ceiling((max(alter) - min(alter))/3)+1)
interDaten = seq(15,maxIntVal,3)
hist(alter, breaks = interDaten, right = FALSE,
     main = "Altersverteilung", xlab = "Alter in Jahren",
     xlim = (c(min(interDaten), max(interDaten))))
