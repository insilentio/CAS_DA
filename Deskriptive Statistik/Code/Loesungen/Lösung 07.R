#### Lösung Aufgabenserie 7: Daniel Baumgartner ####
#Annahme: einzulesende Dateien befinden sich im working directory
library(TeachingDemos)
library(MASS)

# Konstante Texte definieren
pkleiner <- "p-Wert ist kleiner als α, somit wird H0 verworfen"
pgroesser <- "p-Wert ist grösser als α, somit wird H0 beibehalten"


#### Aufgabe: Linksseitiger Test bei μ, σ bekannt ####
#H0: µ ≥ 10000h, Ha: µ < 10000h
bulbs = scan("lightbulbs.txt")
α <- .01
σ <- 120
µ0 <- 10000
n <- length(bulbs)
xquer <- mean(bulbs)
se <- σ/sqrt(n)
pval <- pnorm(xquer, mean = µ0, sd = se)
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: z-Test
z.test(bulbs, mu = µ0, sd = σ, alternative = "l", conf.level = 1-α)

#### Aufgabe: Rechtsseitiger Test bei μ, σ bekannt ####
#H0: µ ≤ 2g, Ha: µ > 2g
cookies <- scan("cookies.txt")
α <- .1
σ <- 0.25
µ0 <- 2
n <- length(cookies)
xquer <- mean(cookies)
se <- σ/sqrt(n)
pval <- pnorm(xquer, mean = µ0, sd = se, lower.tail = F)
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: z-Test
z.test(cookies, mu = µ0, sd = σ, alternative = "g", conf.level = 1-α)


#### Aufgabe: Zweiseitiger Test bei μ, σ bekannt ####
#H0: µ = 15.4kg, Ha: µ ≠ 15.4kg
penguins <- scan("penguins.txt")
α <- .05
σ <- 2.5
µ0 <- 15.4
n <- length(penguins)
xquer <- mean(penguins)
se <- σ/sqrt(n)
pval <- 2 * pnorm(xquer, mean = µ0, sd = se, lower.tail = (xquer < µ0) )
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: z-Test
z.test(penguins, mu = µ0, sd = σ, alternative = "t", conf.level = 1-α)


#### Aufgabe: Linksseitiger Test bei μ, σ unbekannt ####
#H0: µ ≥ 10000h, Ha: µ < 10000h
bulbs = scan("lightbulbs.txt")
α <- .01
s <- sd(bulbs)
µ0 <- 10000
n <- length(bulbs)
xquer <- mean(bulbs)
se <- s/sqrt(n)
t <- (xquer - µ0)/se
pval <- pt(t, df = n-1)
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: t-Test
t.test(bulbs, mu = µ0, alternative = "l", conf.level = 1-α)

#### Aufgabe: Rechtsseitiger Test bei μ, σ unbekannt ####
#H0: µ ≤ 2g, Ha: µ > 2g
cookies <- scan("cookies.txt")
α <- .1
s <- sd(cookies)
µ0 <- 2
n <- length(cookies)
xquer <- mean(cookies)
se <- s/sqrt(n)
t <- (xquer - µ0)/se
pval <- pt(t, df = n-1, lower.tail = F)
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: t-Test
t.test(cookies, mu = µ0, alternative = "g", conf.level = 1-α)

#### Aufgabe: Zweiseitiger Test bei μ, σ unbekannt ####
#H0: µ = 15.4kg, Ha: µ ≠ 15.4kg
penguins <- scan("penguins.txt")
α <- .05
s <- sd(penguins)
µ0 <- 15.4
n <- length(penguins)
xquer <- mean(penguins)
se <- s/sqrt(n)
t <- (xquer - µ0)/se
pval <- 2 * pt(t, df = n-1, lower.tail = (xquer < µ0) )
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: t-Test
t.test(penguins, mu = µ0,alternative = "t", conf.level = 1-α)


#### Aufgabe: Linksseitiger Test des Populationsanteils p ####
#H0: p ≥ 50%, Ha: p < 50%
grocery <- read.csv("grocerystore.csv", header = T, sep = ";")
α <- 0.05
p0 <- 0.5
n <- nrow(grocery)
n.pos <-  sum(grocery$gender == "F")
pquer <- n.pos/n
se <- sqrt(p0*(1-p0)/n)
pval <- pnorm(pquer, mean = p0, sd = se)
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: prop-Test
prop.test(x = n.pos, n = n, p = p0, alternative = "l", conf.level = 1-α, correct = F)


#### Aufgabe: Rechtsseitiger Test des Populationsanteils p ####
#H0: p ≤ 12%, Ha: p > 12%
cards <- read.csv("creditcards.csv", header = T, sep = ";")
α <- 0.05
p0 <- 0.12
n <- nrow(cards)
n.pos <-  sum(cards$bounced == "Yes")
pquer <- n.pos/n
se <- sqrt(p0*(1-p0)/n)
pval <- pnorm(pquer, mean = p0, sd = se, lower.tail = F)
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: prop-Test
prop.test(x = n.pos, n = n, p = p0, alternative = "g", conf.level = 1-α, correct = F)

#### Aufgabe: Zweiseitiger Test des Populationsanteils p ####
#H0: p = 90%, Ha: p ≠ 90%
α <- 0.01
p0 <- 0.9
n <- nrow(survey)
n.pos <-  sum(survey$W.Hnd == "Right", na.rm = T)
pquer <- n.pos/n
se <- sqrt(p0*(1-p0)/n)
pval <- 2 * pnorm(pquer, mean = p0, sd = se, lower.tail = (pquer < p0) )
ifelse(pval < α, pkleiner, pgroesser)

#Alternative: prop-Test
prop.test(x = n.pos, n = n, p = p0, alternative = "t", conf.level = 1-α, correct = F)
