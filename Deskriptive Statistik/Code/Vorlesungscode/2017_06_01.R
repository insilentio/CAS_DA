#Gleichverteilung
xv = seq(0,5,length=100)
plot(xv, dunif(xv,1,3), type = "l") #Dichtefunktion

#10 gleichverteilte Zufallszahlen:
runif(10,1,3)

dunif(3,1,5) #wie hoch bei Wert 2? (y-Achsenabschnitt)
punif(3,1,5) #wie viel Fläche --> wie grosse Wahrscheinlichkeit?
qunif(.95,1,5) #bei welchem Werte ist die Fläche (=Wahrscheinlichkeit) gleich 0.95

#Exponentialverteilung
plot(xv, dexp(xv,1), type = "l")
pexp(3,1/3) #nicht intuitiv, da nicht 50%. Stimmt aber, da es auch Exemplare gibt im unendlichen Bereich

#Normalverteilung
nxv = seq(0,144,by = 1/1000)
plot(nxv, dnorm(nxv,mean = 72, sd=15.2), type = "l")
pnorm(84,72,15.2, lower.tail = F)
barplot(dbinom(0:100,100,.72), names.arg = 0:100)

#Chi-Quadrat Verteilung
degFreedom = c(3,8,15,30)
colors = c(1:4)
plot(nxv, dchisq(nxv,df = 7), type = "l")
plot.new()
for (i in 1:4) {
  lines(nxv, dchisq(nxv, df = degFreedom[i]), col=colors[i], lwd = 2)
}
qchisq(.95,7)

#t-Verteilung
x <- seq(-4, 4, length=100)
hx <- dnorm(x)
degf <- c(1, 3, 8, 30)
colors <- c("red", "blue", "darkgreen", "gold", "black")
labels <- c("df=1", "df=3", "df=8", "df=30", "normal")
plot(x, hx, type="l", lty=2, xlab="t-Verteilungen", ylab="Dichte")
for (i in 1:4){lines(x, dt(x,degf[i]), lwd=2, col=colors[i])}
legend("topright", inset=.05, title="Verteilungen",
       labels, lwd=2, lty=c(1, 1, 1, 1, 2), col=colors)

qt(c(.025,.975),5)


#Schiefe
library(MASS)
barplot(faithful$eruptions)
hist(faithful$eruptions)
mean(faithful$eruptions)
library(e1071)
skewness(faithful$eruptions)
kurtosis(faithful$eruptions)
