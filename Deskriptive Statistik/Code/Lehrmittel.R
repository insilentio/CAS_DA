### Lösungen zu den Aufgaben aus dem Buch und andere Kleinigkeiten ##

Cars93
chisq.test(table(Cars93$Type,Cars93$AirBags))
weight.lm <- lm(Weight ~ Horsepower, data = Cars93)
summary(weight.lm)

predict(weight.lm, newdata = data.frame(Horsepower = 100),interval = "confidence")

resi <- weight.lm$residuals
qqPlot(resi)
plot(weight.lm)

f <- data.frame(x = seq(-10,10,.01))
f$y <- (1/f$x)
plot(f, type = "l")

fehler <- data.frame(Anzahl = c(0:6))
fehler$häufigkeit <- c(30,32,22,10,2,3,1)
fehler$relfreq <- fehler$häufigkeit/sum(fehler$häufigkeit)
fehler$cumsum <- cumsum(fehler$relfreq)
fehler

bv <- data.frame(Stimmverhalten = c("Joachim Gauck","Beate Klarsfeld","Olaf Rose","Enthaltungen", "Ungültige Stimmen"),
                 Anzahl = c(991,126,3,108,4))
pie(bv$Anzahl, labels = bv$Stimmverhalten, col = rainbow(nrow(bv)))
barplot(fehler$relfreq, names.arg = fehler$Anzahl)

chol <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 1) für EXCEL ab 2007.xlsx", 
                   sheet = "Ü10", col_types = c("numeric","blank", "blank", "blank", "blank","blank", "blank"))
inter <- c(0,220,250,10000)
freq <- table(cut(chol[[1]],inter))
pie(freq)

euro.df <- data.frame(Geschlecht = c("w","w", "w","m","m","m"), Zufrieden = c("j","n","0","j","n","0"), 
                      Anzahl = c(198,173,20,241,122,40))
pie(euro.df$Anzahl, labels = euro.df$Zufrieden)

rauchen <-  read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 1) für EXCEL ab 2007.xlsx", 
                       sheet = "Ü13", col_types = c("numeric", 
                                                    "numeric", "blank", "blank", "blank", 
                                                    "blank", "blank"))
rauchen
addmargins(prop.table(table(rauchen),2))


Mod(fehler$häufigkeit)
mean(fehler$relfreq)

vec <- c()
i <- 1
for (i in 1:7) {
  vec <- c(vec,seq(fehler$Anzahl[i],fehler$Anzahl[i],length = fehler$häufigkeit[i]))
}
fehler.df <- data.frame(Fehler = vec)
fehler.df
mean(fehler.df$Fehler)
str(fehler.df)
fehler <- table(fehler.df)
addmargins(prop.table(fehler))
mean(fehler.df$Fehler)
median(fehler.df$Fehler)
quantile(fehler.df$Fehler)
max(fehler.df$Fehler)
as.numeric(names(fehler)[which.max(fehler)])

w <- 100*1.015*1.282*1.807*1.145*.993
(w/100)^(1/5)
(262/204)^(1/3)

rad <- c(66,85,55,32,73,55,42,30,102,48,53,75,60,64)
sd(rad)^2
sd(rad)*(length(rad)-1)/length(rad)
sd(rad2)*(length(rad2)-1)/length(rad2)
mean(rad)
sd(rad)/mean(rad)
sd(rad2)/mean(rad2)

library(ineq)
einkommen <- c(11,13,14,11,11)*1000
plot(Lc(einkommen))
Gini(einkommen, corr = T)

eink.rel <- c(3.9,21.6,21.6,53.5)
plot(Lc(eink.rel))
Gini(eink.rel, corr = F)

CramersV <- function(x) {
  sqrt(chisq.test(x)$statistic[[1]] / (sum(x)*(min(dim(x)-1))))
}

lernen <- matrix(c(152,8,8,32), nrow = 2, byrow = T)
lernen
sqrt(chisq.test(lernen, correct = F)$statistic[[1]]/sum(lernen)/(min(dim(lernen)-1)))

euro <- matrix(c(241,	122,	40, 198,	173,	20),nrow = 2, byrow = T)
addmargins(prop.table(euro))
addmargins(euro)
chisq.test(euro)
CramersV(euro)

chisq.test(table(rauchen))
CramersV(table(rauchen))

m <- matrix(c(3.490,590,3.590,520,3.460,550,3.230,600),nrow = 4,byrow = T)
m
cov(m[,1],m[,2])*3/4
cor(m[,1],m[,2])

studis <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 1) für EXCEL ab 2007.xlsx", 
                     sheet = "Ü31", col_types = c("numeric", "numeric", "skip", "skip", "skip", "skip"))
names(studis) <- c("Punkte","Beispiele")
plot(studis)
reg <- lm(Punkte ~ Beispiele, data = studis)
chisq.test(studis)
summary(chisq.test(studis))
cor(studis$Punkte, studis$Beispiele)
cov(studis$Punkte, studis$Beispiele)*154/155
sd(studis$Beispiele)

plot(studis$Beispiele,studis$Punkte)
abline(reg)
summary(reg)
predict(reg, newdata =data.frame(Beispiele = 40))
B <- cor(studis$Punkte, studis$Beispiele)^2
B

colnames(m) <- c("arbeitslose","zeitarbeiter")
arbeit <- lm(zeitarbeiter ~ arbeitslose, data = data.frame(m))
plot(m)
summary(m)
summary(arbeit)
abline(arbeit)
predict(arbeit, newdata = data.frame(arbeitslose = 3.5))
cor(data.frame(m)$arbeitslose,data.frame(m)$zeitarbeiter)^2


a <- rbinom(10^6,100,.5)
hist(a)
sd(a)
b <- rnorm(10^6,50,5)
hist(b)
c <- dbinom(c(1:10^5),1,.5)
plot(c, type = "l")
head(c)

pbinom(0,100,.05)
pbinom(1,5,.2)-pbinom(0,5,.2)
phyper(16,800000,1200000,40)-phyper(15,800000,1200000,40)
pbinom(16,40,.4)-pbinom(15,40,.4)

#Ü44
pnorm(1.96)
#Ü45
pnorm(6.196,6,.1)
pnorm(5.85,6,.1,lower.tail = F)
pnorm(5.83,6,.1)
pnorm(((5.83-6)/.1))
qnorm(.95,6,.1)
qnorm(c(.025,.975),6,.1)
#Ü48
pnorm(5.2,5,.5)
pnorm(5.98,5,.5,lower.tail = F)
pnorm(5.2,5,.5)-pnorm(4.8,5,.5)
#Ü50
qnorm(c(.025,.975),100,15)
pnorm(130,100,15,lower.tail = F)*100
qnorm(c(.25,.75),100,15)*100

a <- 18/37
dbinom(2,5,a)
pbinom(2,5,a)-pbinom(1,5,a)
probs <- dbinom(c(0:10),10,a)
barplot(probs)
qbinom(.9,5,a)
barplot(dhyper(0:6,6,36,6))
phyper(2,6,36,6)
qhyper(.99,6,36,6)
plot(dnorm(seq(-4,4,.01)), type = "l")
plot(dbinom(400:600,100000,.005), type = "l")
plot(dunif(seq(1,10,.01),2,4), type = "l")
plot(dexp(seq(0,10,.01),1), type = "l")
plot(dpois(0:100,50), type = "l")
plot(dhyper(25:75,1000,1000,100), type = "l")
plot(dchisq(0:1000,500), type = "l", xlim = c(300,700))
plot(dt(seq(-4,4,.01),10), type = "l")

library(ggplot2)
ggplot(data.frame(desc = c(400:600),bin = dbinom(400:600,100000,.005)))+
  aes(x=desc, y=bin)+
  geom_line()+
  theme_bw()
str(data.frame(bin = dbinom(400:600,100000,.005)))


optimum <- function(over, size, showup, cost, rev) {
  value <- c()
  for (i in 1:(length(over))) {
  value[i] <- (over[i] - size)*rev - sum(dbinom(c((size+1):over[i]), over[i], showup)*c(1:(over[i]-size))*cost)
  }
  names(value) <- c((size+1):over)
  return(value)
}
plot(optimum(c(240:270),240,.96,350,210), type = "l")


pi = 0.2
p <- 0.23
n=400
alpha <- 0.05
se <- sqrt((pi*(1-pi))/n)
me <- qnorm(.975)*se
pi + c(-me,me)
pt(.23,399)

pnorm(1000.5,999.93,.5, lower.tail = F)
diff(pnorm(c(1000,1000.5), 999.93,.5))
diff(pnorm(c(999.5,1000), 999.93, .5))
pnorm(999.5, 999.93,.5)

dataset <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                      sheet = "Ü51-53", col_types = c("numeric", 
                                                      "numeric", "numeric", "numeric", 
                                                      "blank", "blank"))
dataset
ds <- sample_n(dataset, 250, replace = T)
ds
p.ds <- sum(ds$Kinderzahl == 0)/nrow(ds)
xquer.ps <- mean(ds$Kinderzahl)
r.ps <- cor(ds$Kinderzahl, ds$`belegte Kurse`)
ds2 <- filter(ds, ds$Antwortverhalten == 1)
p.ds2 <- sum(ds2$Kinderzahl == 0)/nrow(ds2)
pi <-  sum(dataset$Kinderzahl == 0)/nrow(dataset)

pi <- .666
n<- 800
me <- qnorm(.975)*sqrt(pi*(1-pi)/n)
pi + c(-me,me)


u55 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                  sheet = "Ü55", col_types = c("numeric", "blank", "blank"))
p <- sum(u55 == 1)/nrow(u55)
me <- qnorm(.975)*sqrt(p*(1-p)/nrow(u55))
p + c(-me,me)


n <- 500
p <- .8
alpha <- .01
me <- qnorm(1-alpha/2)*sqrt(p*(1-p)/n)
p + c(-me,me)

p <- .14
n <- 300
alpha <- .05
me <- qnorm(1-alpha/2)*sqrt(p*(1-p)/n)
p + c(-me,me)

u <- qnorm(.975)
me <- .025
pi <- .8
ceiling(u^2/me^2*pi*(1-pi))

u61 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                  sheet = "Ü61", col_types = c("numeric", "skip", "skip"))
pi <- .666
n <- nrow(u61)
p <- sum(u61$Einstellung == 1)/n
alpha <- .05
me <- qnorm(1-alpha/2)*sqrt(pi*(1-pi)/n)
pi + c(-me,me)
p
prop.test(x=.636*n, n=n, p = pi, alternative = "t")

pi <- .1
# H0: pi >= .1, H1: pi < .1
n <- 1200
pos <- 102
p <- pos/n
alpha <- .05
me <- qnorm(1-alpha)*sqrt(pi*(1-pi)/n)
p < pi - me
p
pi - me
prop.test(x=.08*n, n=n, p=pi, alternative = "l")

n <- 350
pos <- 192
alpha <- .05
# H0: pi <= .5, H1: pi > .5
pi <- .5
me <- qnorm(1-alpha)*sqrt(pi*(1-pi)/n)
pi + me
pos/n 
pos/n < pi+me

pi = .4
# H0: pi >= .4, H1: pi < .4
alpha <- .05
n <- 100
p <- .36
me <- qnorm(1-alpha)*sqrt(pi*(1-pi)/n)
p > pi - me

u66 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                  sheet = "Ü66", col_types = c("numeric", "skip", "skip", "skip", "skip"))
alpha <- .05
xquer <- mean(u66$Schlafdauer)
n <- nrow(u66)
se <- sd(u66$Schlafdauer)/sqrt(n)
me <- qt(.975,n-1)*se
xquer + c(-me,me)
se^2
sd(u66$Schlafdauer)^2


n <- 116
xquer <- 25.452
s2 <- .85
alpha <- .05
me <- qt(1-alpha/2, n-1)*sqrt(s2/n)
xquer + c(-me,me)


n <- 836
xquer <- 22.5
s <- 3.2
alpha <- .05
me <- qt(1-alpha/2, n-1)*s/sqrt(n)
xquer + c(-me,me)

u69 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx",
                  sheet = "Ü69", col_types = c("numeric", "skip", "skip"))
names(u69) <- c("x")
n <- 86
alpha <- .05
µ <- 4500
s <- sd(u69$x)
xquer <- mean(u69$x)
me <- qt(1-alpha/2, n-1)*s/sqrt(n)
µ + c(-me,me)
µ-me <= xquer
me <- qt(1-alpha, n-1)*s/sqrt(n)
xquer > µ-me
t.test(u69$x,alternative = "l",mu = µ)


µ <- 75
# H0: µ <= 75, H1: µ > 75
alpha <- .05
n <- 120
xquer <- 78.4
s <- 6
me <- qt(1-alpha, n-1)*s/sqrt(n)
# obere Schranke:
xo <- µ + me
xquer < xo


# H0: µ <= 100, H1: µ > 100
n <- 100
xquer <- 108
s <- 19
µ <- 100
me <- qt(.95, 99)*s/sqrt(n)
xo <- µ + me
xquer < xo


# H0: δ >= 0 , H1: δ < 0
u73 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                  sheet = "Ü73", col_types = c("numeric", "numeric", "skip", "skip"))
names(u73) <- c("A", "B")
n <- nrow(u73)
hA <- sum(u73$A == 1)
nA <- length(na.omit(u73$A))
hB <- sum(u73$B == 1)
nB <- length(na.omit(u73$B))
p <- (hA + hB)/(nA + nB)
me <- qt(1-alpha, n-1)*sqrt(p*(1-p)*(1/nA+1/nB))
du <- 0 - me
d <- hA/nA - hB/nB
d > du

# H0: δ = 0, H1: δ != 0
me <- qt(1-alpha/2, n-1)*sqrt(p*(1-p)*(1/nA+1/nB))
c(-me,me)
-me <= d && d <= me


# H0: δ >= 0, δ < 0
pA = .415
pB = .44
n <- 200
p <- (pA+pB)/2
me <- qnorm(1-alpha)*sqrt(p*(1-p)*(1/n+1/n))
d <- pA - pB
d > -me


# H0: δ = 0, H1: δ != 0
# wobei δ = p1 - p2
nA <- 350
nB <- 420
pA <- .651
pB <- .621

p <- (pA*nA+pB*nB)/(nA+nB)
se <- sqrt(p*(1-p)*(1/nA+1/nB))
me <- qnorm(1-alpha/2)*se
d <- pA - pB
-me <= d && d <= me


# H0: δ >=0, H1: δ < 0
alpha <- .05
xA <- mean(u66$Schlafdauer)
nA <- nrow(u66)
sA <- sd(u66$Schlafdauer)
xB <- 7.1
nB <- 200
sB <- 1.5
se <- sqrt(sA^2/nA+sB^2/nB)
me <- qnorm(1-alpha)*se
d <- xA - xB
d > -me


# H0: δ = 0, H1: δ != 0
# wobei δ = µ1 - µ2
nA <- 125
xA <- 5996.5
sA <- 65.3
nB <- 122
xB <- 6125.6
sB <- 57

d <- xA - xB
se <- sqrt(sA^2/nA+sB^2/nB)
me <- qnorm(1-alpha/2)*se
-me <= d


euro <- matrix(c(241,	122,	40, 198,	173,	20),nrow = 2, byrow = T)
addmargins(prop.table(euro))
addmargins(euro)
chi <- chisq.test(euro)

# H0: ChiQuadrat = 0, H1: ChiQuadrat > 0
chiErr <- chi$statistic[[1]]
chi0 <- qchisq(1-alpha, 2)
chiErr <= chi0
chi$p.value


# H0: ChiQ = 0; H1: ChiQ > 0
lese <- matrix(c(10,20,120,100,60,40),nrow = 2, byrow = T)
chi <- chisq.test(lese)
chiErr <- chi$statistic[[1]]
chiQ <- qchisq(1-alpha, 2)
chiErr <= chi0
chi$p.value > alpha


# H0: chiQ = 0, H1: chiQ > 0
mgmt <- matrix(c(40,75,30,90), nrow = 2, byrow = T)
chi <- chisq.test(mgmt, correct = F)
chiErr <- chi$statistic[[1]]
chiQ <- qchisq(1-alpha, 1)
chiErr <= chiQ

#83 & 84: Test auf Normalverteilung
# H0: chiQ = 0, H1: chiQ > 0
n <- 400
pb <- c(.14,.35,.37,.14)
xquer <- 80000
s <- 20000
p40 <- pnorm(40000,xquer,s)
p60 <- pnorm(60000,xquer,s) - p40
p80 <- pnorm(80000,xquer,s) - p60 - p40
pe <- c(p40,p60,p80,1-p80-p60-p40)
# chi <- chisq.test(pe, pb, correct = F)
# chiErr <- chi$statistic[[1]]
chiQ <- qchisq(.95,1)

ld <- matrix(c(pb,pe), nrow = 4,byrow = F)
chiErr <- 0
for (i in 1:4) {
  chiErr <- chiErr + (ld[i,1]-ld[i,2])^2/ld[i,2]*n
}
chiErr <= chiQ
pchisq(chiErr,1, lower.tail = F)

#85: Test auf Normalverteilung
# H0: chiQ = 0, H1: chiQ > 0
n <- 100
pb <- c(.14,.38,.28,.2)
pe1 <- pnorm(2,3,1)
pe2 <- pnorm(3,3,1)-pe1
pe3 <- pnorm(4,3,1)-pe2-pe1
pe <- c(pe1,pe2,pe3,1-pe3-pe2-pe1)
batt <- matrix(c(pb,pe), nrow = length(pb), byrow = F)
chiErr <- 0
for (i in 1:length(pb)) {
  chiErr <- chiErr + (batt[i,1]-batt[i,2])^2/batt[i,2]*n
}
chiErr <= chiQ


u87 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                  sheet = "Ü87", col_types = c("numeric", "numeric", "skip", "skip"))
u87
names(u87) = c("x", "y")
# H0: ρ <= 0, H1: ρ > 0
r <- cor(u87$x, u87$y)
uerr <- r*sqrt((nrow(u87)-2)/(1-r^2))
uerr <= qnorm(.95)


# H0: ρ <= 0, H1: ρ > 0
r <- .112
n <- 300
uerr <- r*sqrt((n-2)/(1-r^2))
uerr <= qnorm(.95)


# H0: ρ >= 0, H1: ρ < 0
n <- 2200
r <- -.06
uerr <- r*sqrt((n-2)/(1-r^2))
uerr >= -qnorm(.95)


# H0: ρ = 0, H1: ρ != 0
# H0: ρ <= 0, H1: ρ > 0
# H0: ρ >= 0, H1: ρ < 0


u91 <- read_excel("~/Documents/Daniel/Ausbildung/BFH/CAS Datenanalyse/Deskriptive Statistik/Unterrichtsfolien zur Statistik mit R/Lehrmittel/Lerndatei (Kapitel 3) ab EXCEL 2007.xlsx", 
                  sheet = "Ü91-93", col_types = c("numeric", "numeric", "skip", "skip"))
names(u91) = c("x", "y")
# H0: β = 0, H1: β != 0
n <- nrow(u91)
r <- cor(u91$x, u91$y)
sx <- sd(u91$x)
sy <- sd(u91$y)
sb <- sqrt((1-r^2)/(n-2)*sy^2/sx^2)
me <- qt(1-alpha/2, n-2)*sb
b <- lm(u91$y ~u91$x)$coefficients[[2]]
-me <= b && b <= me

# H0: β <= 1, H1: β > 1
me <- 1 + qt(1-alpha, n-2)*sb
b <= me

# H0: β2 >= 10, β2 < 10
b20 <- 10
xquer <- mean(u91$x)
sb2 <- sqrt((1-r^2)/(n-2)*sy^2*(1+xquer^2/sx^2))
me <- qt(1-alpha, n-2)*sb2
b2 <- b <- lm(u91$y ~u91$x)$coefficients[[1]]
b2 >= b20 - me


# H0: β1A = β1B, H1: β1A != β1B
# H0: β2A = β2B, H1: β2A != β2B
β1B <- 2
β2B <- 200
n <- 250
xquer <- 15
yquer <- 200
sx <- 4
sy <- 50
sxy <- 31.2
r <- .156
sb1 <- sqrt((1-r^2)/(n-2)*sy^2/sx^2)
me <- qt(1-alpha/2, n-2)*sb1
b1 <- sxy/sx^2
β1B-me <= b1 && b1 <= β1B+me

sb2 <- sqrt((1-r^2)/(n-2)*sy^2*(1+xquer^2/sx^2))
me <- qt(1-alpha/2, n-2)*sb2
b2 <- yquer - b1*xquer
β2B-me <= b2 && b2 <= β2B+me


## Lösungen zu Aufgaben "Statistisches Testen"
# Aufgabe 1
load("Anzahl_Fehler.RData")
tab <- table(Anzahl_Fehler)
tab
prop.table(tab)
cumsum(prop.table(tab))
barplot(tab)
pie(tab)
mean(Anzahl_Fehler$Anzahl.an.Fehlern)
median(Anzahl_Fehler$Anzahl.an.Fehlern)
names(tab[tab == max(tab)])
boxplot(Anzahl_Fehler)
quantile(Anzahl_Fehler$Anzahl.an.Fehlern, .25)
quantile(Anzahl_Fehler$Anzahl.an.Fehlern, .75)

# Aufgabe 2
load("Cholesterinwerte.RData")
hist(Cholesterinwerte$Cholesterinwerte,
     breaks = c(min(Cholesterinwerte$Cholesterinwerte),220,250,max(Cholesterinwerte$Cholesterinwerte)),
     right = F,
     main = "Cholesterin",
     xlab = "Cholesterinwerte")

# Aufgabe 3
load("Rauchen_GeschlechtBaby.RData")
baby <- table(Rauchen_GeschlechtBaby$Geschlecht.des.Kindes, Rauchen_GeschlechtBaby$Rauchverhalten.der.Eltern)
prop.table(baby)
addmargins(prop.table(baby,2))
names(attr(baby, "dimnames")) <- c("Kind", "Eltern")
attr(baby, "dimnames") <- list(c("männlich", "weiblich"), c("0 Raucher", "1 Raucher", "2 Raucher"))

# Aufgabe 4
usb <- c(1,rep(2,9), rep(4,29), rep(8,33), rep(16,23), rep(32,5))
table(usb)
median(usb)
quantile(usb,.2)
mean(usb)
names(table(usb)[table(usb) == max(table(usb))])

# Aufgabe 5
start <- 100
ende <- start
wachstum <- c(1.015, 1.282, 1.807, 1.145, .993)
for (i in 1:length(wachstum)) {
  ende <- ende * wachstum[i]
}
g <- (ende/start)^(1/length(wachstum))
g

# Aufgabe 6
var(Anzahl_Fehler$Anzahl.an.Fehlern)
sd(Anzahl_Fehler$Anzahl.an.Fehlern)
sd(Anzahl_Fehler$Anzahl.an.Fehlern)/mean(Anzahl_Fehler$Anzahl.an.Fehlern)

# Aufgabe 7
diamonds <- c(42.8, 30.7, 30, 24.8, 15.8)
names(diamonds) <- c("Russland", "Australien", "Kongo", "Botswana", "Südafrika")
library(ineq)
plot(Lc(diamonds))
Gini(diamonds, corr = T)

# Aufgabe 8
load("Daten_WachstumX.RData")
Daten_Wachstum
cor(Daten_Wachstum$Marketing, Daten_Wachstum$Produktverbesserung)
lm(Produktverbesserung~ Marketing, data = Daten_Wachstum)
data <- table(Daten_Wachstum$Geschlecht, Daten_Wachstum$Selbsteinschätzung)
chi <- chisq.test(data)$statistic[[1]]
chi
sqrt(chi/(sum(data)*(min(dim(data))-1)))

# Aufgabe 9
load("Daten_Wachstum.RData")
cor(Daten_Wachstum$Bildung, Daten_Wachstum$Selbsteinschaetzung, method = "s")

# Aufgabe 10
data <- table(Daten_Wachstum$Motiv, Daten_Wachstum$Geschlecht)
chi <- chisq.test(data)$statistic[[1]]
V <- sqrt(chi/(sum(data)*(min(dim(data))-1)))
V

# Aufgabe 11
dbinom(1,1,1/37)
dbinom(1,1,19/37)
dbinom(1,1,12/37)
dbinom(1,1,12/18)
12/18

# Aufgabe 12
dhyper(0,4,5,3)
dhyper(1,4,5,3)
phyper(1,4,5,3, lower.tail = F)

# Aufgabe 13
dbinom(0,5,.2)
dbinom(1,5,.2)
pbinom(0,5,.2, lower.tail = F)
barplot(dbinom(0:5,5,.2))

# Aufgabe 14
µ = 6
σ = 0.1
pnorm(6.15,µ,σ)
pnorm(6.196,µ,σ)
pnorm(5.85,µ,σ, lower.tail = F)
pnorm(5.83,µ,σ, lower.tail = T)
pnorm(6.1,µ,σ) - pnorm(5.8,µ,σ)
qnorm(.95,µ,σ)
qnorm(c(.025,.975),µ,σ)


#Prüfung HS16
n <- 100
xquer <- 34.25
s <- 7.5
α <- .05
se <- s/sqrt(n)
me <- qt(1-α/2, n-1)*se
xquer + c(-me,me)

head(mtcars)
# H0: µ ≥ 50mpg, H1: µ < 50mpg
α <- .05
µ0 <- 50
xquer <- mean(mtcars$mpg)
s <- sd(mtcars$mpg)
n <- length(mtcars$mpg)
se <- s/sqrt(n)
tval <- (xquer-µ0)/se
pval <- pt(tval, n-1, lower.tail = T)
pval
t.test(mtcars$mpg, mu=µ0, alternative = "l", conf.level = 1-α)

head(Cars93)
# H0: Chiquadrat = 0, H1: Chiquadrat > 0
chitest <- chisq.test(table(Cars93$Type,Cars93$AirBags))
chitest$p.value < α

mod <- lm(Weight~Horsepower, data=Cars93)
mod
#Grundgewicht eines Wagens beträgt 1876 lbs. Pro 1PS nimmt das Gewicht um 8.321 lbs zu.

se <- summary(mod)$coefficients[2,2]
me <- qt(.975, nrow(Cars93)-2)*se
mod$coefficients[2] + c(-me,me)

# H0: β1 = 0 (kein Zusammenhang), H1: β1 ≠ 0
pval <- summary(mod)$coefficients[2,4]
pval < α
# Da der p-Wert kleiner als das Signifikanzniveau ist, wird die Nullhypothese verworfen.
# Die Alternativhypothese, dass ein Zusammenhang besteht, wird akzeptiert.

# Das Bestimmtheitsmass r^2 ist mit 0.55 nicht ganz im Bereich des starken Zusammenhangs (ab 0.6).
predict(mod,newdata = data.frame(Horsepower=190), interval = "predict")

plot(Cars93$Horsepower,mod$residuals,ylab = "Residuen", xlab = "PS", main = "Gewicht von Autos")
qqPlot(mod)
jarque.test(mod$residuals)


240/.96
plot(dbinom(220:260,250,.96), type = "o")
cost <- 0
for (i in 1:10) {
  cost <- cost + dbinom(240+i,250,.96)*350*i
}

