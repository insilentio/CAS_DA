#linksseitiger TEst des Populationsanteils
#kritische Grenze z.alpha:
α <- 0.05
p0 <- 0.6
n <- 148
pquer <- 85/148
se <- sqrt(p0*(1-p0)/n)
z <- (pquer - p0)/se
z.alpha <- qnorm(alpha)
z < z.alpha

#da z nicht <z.alpha, kann H0 nicht verworfen werden.
#Alternative: statt kritischer Grenze wird direkt über p-Wert evaluiert.
#Hier ist die Entscheidung zur Verwerfung der H0 dann: wenn p < alpha
p <- pnorm(pquer,p0,se)
p < α; #ohne Strichpunkt wird nächster Code auch evaluiert
#oder
prop.test(x=85, n=148, p = 0.6, alternative = "less", correct = F)


#rechtsseitiger Test
n <- 214
p0 <- 0.12
se = sqrt((p0 * (1-p0))/n)
pquer = 30/214
p <- pnorm(pquer,p0,se,lower.tail = F)
p < α;
#p grösser alpha, daher KEINE Verwerfung der H0
#oder direkt:
prop.test(30,214,0.12,alternative = "greater", correct = F)


#zweiseitiger TEst
p0 <- 0.5
n <- 20
se <- sqrt(p0*(1-p0)/n)
pquer <- 12/20
qnorm(0.025,p0,se) #untere kritische Grenze
qnorm(0.975,p0,se) #obere kritische Grenze
#µ ist innerhalb der Grenzen, daher wird H0 NICHT verworfen
#via p-Wert:
p <- 2*pnorm(pquer,p0,se,lower.tail = F)
p < α;
#oder
prop.test(12,20,0.5,alternative = "two.sided", correct = F)


#linksseitiger Test bei absoluten Zahlen
xquer <- 9900
µ0 <- 10000
n <- 30
σ <- 120
se = σ/sqrt(n)

z.alpha <- qnorm(α,µ0,se)

p <- pnorm(xquer,µ0,se)
p < α;
#p Wert ist kleiner alpha --> H0 wird verworfen
z.test(xquer,µ0,σ,alternative = "less",n=n)


#rechtsseitiger Test
xquer <- 2.1
µ0 <- 2
n <- 35
σ <- 0.25
se <- σ/sqrt(n)
z.alpha <- qnorm(0.95,µ0,se)
p <- pnorm(xquer,µ0,se, lower.tail = F)
p < α;

z.test(xquer,µ0,σ,alternative = "greater",n=n)


#zweiseitiger Test
xquer <- 14.6
µ0 <- 15.4
n <- 35
σ <- 2.5
se <- σ/sqrt(n)
p <- 2*pnorm(xquer,µ0,se)
p < α;

#linksseitiger Test bei unbekannter Standardabweichung
# H0: µ >= 10000
xquer <- 9900
µ0 <- 10000
n <- 30
s <- 125
se <- s/sqrt(n)
#da qt anders als qnorm nur mit Standardverteilung arbeitet, muss man die z- und p-Werte standardisieren:
##todo z.alpha <- qt()
t <- (xquer - µ0)/se
p <- pt(t, df = n-1)
p < α;
#oder mit Daten, dann t-Test:
daten <- scan("RWD/lightbulbs.txt")
t.test(x=daten, alternative = "less", mu=10000)
#p-Wert ist kleiner als alpha --> H0 wird verworfen
#zum Vergleich mit z-Test (der hier konzeptuell falsch wäre)
z.test(x = daten,10000, sd = sd(daten), n=length(daten), alternative = "less")

