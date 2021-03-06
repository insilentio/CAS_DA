# Beispiel M�nze werfen: wo liegen 90% der W�rfe
#exakt: mit Binomialverteilung
qbinom(c(0.05, 0.95), 100, .5)
#mit Normalverteilung: m� = 50
#erst mal Varianz absch�tzen (siehe Kap. 2)
varianz = 100 * .5 * (1 - .5)
stabw = varianz ^ .5
qnorm(c(0.05, 0.95), 50, stabw)
#mit Normalverteilung, aber relative H�ufigkeit: m� = 0.5
m�  = 0.5
#f�r die Standardabweichung muss bei relativen Werten durch Wurzel(n) geteilt werden
#(Standardfehler)!!!
stdFehler = sqrt(.5 * .5) / sqrt(100)
qnorm(c(0.05, 0.95), 0.5, sqrt(.5 * .5 / 100))


#Beispiel: Reisz�hlen
library(readxl)
reis = read_excel("ReisFS17.xlsx")
reis$total = reis$schwarz + reis$weiss
reis$schaetzer = reis$schwarz / reis$total
plot(reis$schaetzer)
reis$se = sqrt(reis$schaetzer * (1 - reis$schaetzer) / reis$total)
#gesucht: z-wert f�r 95%
#z-wert f�r Standard-Normalverteilung:
zwert = qnorm(.975)
reis$me = zwert * reis$se
reis$LB = reis$schaetzer - reis$me
reis$UB = reis$schaetzer + reis$me
plot(reis$schaetzer, ylim = c(min(reis$LB), max(reis$UB)))
points(reis$UB, col = "red")
points(reis$LB, col = "blue")

trueValue = sum(reis$schwarz) / sum(reis$total)
abline(trueValue, 0)
#--> nur 1 ist ausserhalb des overall Mittelwerts --> entspricht 95% von 18


# Folie 29 in CAS_Datenanalyse_R_KonfInt.pdf
survey
genderResponse = na.omit((survey$Sex))
k = sum(genderResponse == "Female")
n = length(genderResponse)
schFemale = k / n
#nun interessiert uns aber das Konfidenzintervall:
se = sqrt((schFemale * (1 - schFemale)) / n)
me = qnorm(.975) * se
schFemale + c(-me, me)
#stattdessen einfacher:
prop.test(k, n)
prop.test(k, n, conf.level = .99)

#Frage: wie gross muss n sein bei vorgegebener Genauigkeit?
zwert = qnorm(1 - 0.05 / 2)
ngesucht = (zwert * .5 / .05) ^ 2
ngesucht
