

m = matrix(c(21, 46, 55, 35, 28, 1850, 2500, 2560, 2230, 1800), nrow = 2, byrow = TRUE)
chisq.test(m)$statistic
cov(m[1,], m[2,])##Achtung: Stichproben-Kovarianz
cov(m[1,], m[2,])*4/5  #das wäre die Populations-Kovarianz
cov(m[1,],m[2,])/(sd(m[1,])*sd(m[2,]))
cor(m[1,],m[2,]) #nach Pearson
plot(m[1,], m[2,])

# Steigung der Regressionsgeraden
cov(m[1,],m[2,])/sd(m[1,])^2

# stattdessen lineares Modell:
mod = lm(m[2,] ~ m[1,])
attributes(mod)
mod$coefficients[2]
abline(mod)
# Bestimmtheitsmass:
summary(mod)$r.squared


m = matrix(c(10^1,10^1,10^5,10^5,10^4,10^2,10^2,10^2,10^5,10^4,10^4,10^3), nrow = 2, byrow = TRUE)
cor(m[1,], m[2,], method = "spearman")
cor(m[1,], m[2,])

#finde zugehörigen Wert für einen bestimmten Max-Wert:

faithful[faithful$waiting==max(faithful$waiting),]
#oder mit which() (aber obere Variante mit logischem Vektor ist eleganter):
faithful[which(faithful$waiting==max(faithful$waiting)),]
