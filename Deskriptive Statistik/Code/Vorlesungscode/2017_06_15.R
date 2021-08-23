library(MASS)
#Punktschätzung für Mittelwert der Körpergrösse, mit 95% Konfidenzniveau
mean(survey$Height, na.rm = T)
survey.height = na.omit(survey$Height)
n = length(survey.height)
sd = 9.48
se = sd / sqrt(n)
me = qnorm(.975) * se
mean(survey.height) + c(-me, me)

library(TeachingDemos)
z.test(survey.height, sd = 9.48)
#std.dev. of the sample mean ist hier der Standardfehler (se)

#mit anderem Konfidenzintervall
z.test(survey.height, sd = 9.48, conf.level = .99)

#nun mit realitätsnäherem Fall: Standardabweichung nicht bekannt
sd = sd(survey.height)
se = sd / sqrt(n)
me = qt(.975, df = n - 1) * se
mean(survey.height) + c(-me, me)
t.test(survey.height)

#Stichprobengrösse herausfinden:
(qnorm(.975)*sd/1.2)^2
(qnorm(.975)*sd/1.0)^2
(qnorm(.975)*sd/0.8)^2

#Übung 54 aus dem Buch:
#siehe OneNote. Hilfsweise könnte man auch mit prop.test arbeiten, aber eigentlich müsste man die Zahl der
#"weissen" genau wissen
prop.test(67,100)
p = .666
se = sqrt(p*(1-p))/sqrt(800)
me = qnorm(.975)*se
p + c(-me,me)

#Übung 67
n=116
xq = 25.452
se = sqrt(0.85)/sqrt(n)
me = qt(.975, df=n-1)*se
xq + c(-me,me)


#Testen von Hypothesen
#Cola-Hypothese (siehe OneNote)
barplot(dbinom(0:12, size = 12, prob = .5),names.arg =  0:12)
qbinom(.95,12,.5) 
#--> bei zufälligem Unterscheiden würden in 95% der Fälle max. 9 richtig identifizieren (kritische Grenze)
pbinom(9,12,.5,lower.tail = F) #Wahrscheinlichkeit für zufälliges Erreichen des Ergebnisses 9

#Apfelernte-Problem
qnorm(.95,.12, sd=sqrt(0.12*(1-0.12)/214))
30/214
#oder via z-wert: muss in Standardnormalverteilung umgerechnet werden
z = (.15-.12)/sqrt(.12*(1-.12)/214)
z.alpha = (30/214-.12)/sqrt(.12*(1-.12)/214)
#p-wert: mit prop.test. parameter "alternative" bezieht sich auf das Gleichheitszeichen vor Alternativhypothese
prop.test(30,214,p = .12, alternative = "greater", correct = F)
