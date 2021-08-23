#### Lösung Aufgabenserie 6: Daniel Baumgartner ####

#### Aufgabe: Aufgabe: Intervallschätzung von µ, σ2 bekannt ####
pulse <- na.omit(survey$Pulse)

σ <- 11.69
α <- 0.01
µ <- mean(pulse)
n <- length(pulse)
se <- σ / sqrt(n)
#da Std.Abw. bekannt, wird nun mit der Normalverteilung der Fehlerbereich berechnet:
me <- qnorm(1 - α / 2) * se
cat("Fehlerbereich:", me)
cat("Konfidenzintervall:", µ +c(-me, me), "bei einem Erwartungswert von",µ,
    "und einem Konfidenzniveau von", (1 - α) * 100, "%")


#### Aufgabe: Intervallschätzung von µ, σ2 unbekannt ####
s <- sd(pulse)
α <- 0.1
se <- s / sqrt(n)
#da Std.Abw. nicht bekannt, wird nun mit der t-Verteilung der Fehlerbereich berechnet:
me <- qt(1 - α / 2, df = n - 1) * se
cat("Fehlerbereich:", me)
cat("Konfidenzintervall:", µ +c(-me, me), "bei einem Erwartungswert von",µ,
    "und einem Konfidenzniveau von", (1 - α) * 100, "%")


#### Aufgabe: Stichprobengrösse bei µ ####
α <- 0.01
E <- 1
s <- sd(pulse)
n <- (qnorm(1 - α / 2) * s / E) ^ 2
cat("Die benötigte Stichprobengrösse bei einem Fehlerbereich von",
    E,
    "und einem Konfidenzniveau von",
    (1 - α) * 100,
    "% beträgt",
    ceiling(n)
)


#### Aufgabe: Intervallschätzung von Populationsanteils p ####
α <- 0.1
smoking <- na.omit(survey$Smoke)
#erst mal eine Punktschätzung vornehmen:
n <- length(smoking)
k <- sum(smoking == "Never")
pbar <- k / n
#nun die Intervallschätzung vornehmen:
se <- sqrt(pbar * (1 - pbar) / n)
me <- qnorm(1 - α / 2) * se
cat("Die Intervallschätzung für den Nichtraucheranteil bei einem Konfidenzniveau von",
    (1 - α) * 100,
    "% beträgt:",
    pbar + c(-me, me)
)
#erweiterte Antwort:
prop.test(k, n, conf.level = 0.9)


#### Aufgabe: Stichprobengrösse für p ####
α <- 0.01
p <- 0.8
E <- 0.02
n <- qnorm(1 - α / 2) ^ 2 * (p * (1 - p)) / E ^ 2
cat("Die Stichprobengrösse bei einem erwarteten Populationsanteil von",
    p,
    ", einem Fehlerbereich von",
    E,
    "und einem Konfidenzniveau von",
    (1 - α) * 100,
    "% beträgt",
    ceiling(n)
)