library(MASS)
head(faithful)
str(faithful)

barplot(sort(faithful$eruptions))


#Histogramm wäre nun praktisch, da die Werte kaum je genau gleich sind --> somit Intervalle von Werten bilden
#Finde erst mal Wertebereich:
range(faithful$eruptions)
#Entscheidung: Einteilung in 0.5er Intervalle beginnend bei 1.5
inter = seq(1.5, 5.5, 0.25)
freq = table(cut(faithful$eruptions, inter , right = FALSE))
relFreq = prop.table(freq)
barplot(relFreq) #nicht ideale Darstellung für Histogramme, da Zwischenräume
#kumulierte rel. Summenhäufigkeit:
cumRelFreq = cumsum(relFreq)
cbind(freq,relFreq,cumRelFreq)

#einfacher ist es mit der Funktion hist:
hist(faithful$eruptions, inter, right = FALSE, main = "Faithful Eruptions", col = rainbow(length(inter)))

#Faustregel: Anzahl Intervalle ca. gleich Wurzel der Werte:
hist(faithful$eruptions, breaks = sqrt(length(faithful$eruptions)), right = FALSE, main = "Faithful Eruptions",
     col = rainbow(length(inter)), xlab = "eruption length",
     xlim = (c(floor(min(faithful$eruptions)), ceiling(max(faithful$eruptions)))))

#Streudiagramm:
cumRelFreq0 = c(0, cumRelFreq)
plot(inter, cumRelFreq0)
#mit Linien:
lines(inter, cumRelFreq0)

#oder viel einfacher:
fn = ecdf(faithful$eruptions)  #dies erzeugt eine Funktion, siehe global environment
plot(fn)

plot(faithful$eruptions,faithful$waiting)
#es ist offensichlich eine lineare Regression vorhanden:
abline((lm(faithful$waiting~faithful$eruptions)))


#### Lorenzkurven&Gini-Koeffizient ####
einkommen = 1000*c(1,1,1,3,4)
install.packages("ineq")
library(ineq)
plot(Lc(einkommen))

Gini(einkommen)   #dies ist der Ginikoeffizient gegenüber der Maximalfläche (0.5) -> stimmt nur bei sehr grossen Stichproben
Gini(einkommen, corr = TRUE) #dies ist der Koeffizient bei endlichen Stichproben


#### Cramers V ####
studis = matrix(c(110,120,20,30,20,90,60,30,10,10), nrow = 2, byrow = TRUE)
colnames(studis) = c("BWL", "SOZ", "VWL", "SoWi", "Stat")
rownames(studis) = c("F", "M")
studis
chisq.test(studis)$statistic
V = sqrt(chisq.test(studis)$statistic/(sum(studis*(min(dim(studis))-1))))
V
