#### 10.2 ####
((3 + 4 - 5) - 9) ^ 2
(-99 / 33) + 42
log(1)
sqrt(2) ^ 2

5 == 7
5 * 5 >= 6 * 4
sqrt(3) != cos(17)

?mean
#trim: the fraction (0 to 0.5) of observations to be trimmed from each end of x before the mean is computed.
#Values of trim outside that range are taken as the nearest endpoint.


sample(-100:100, 10, replace = TRUE)
for (i in 1:100)
  random[1, i] <- i * 2


#### 12.3.2 ####
x = rep(1:5, 10)
x
y = x[c(12, 20, 50)]
y
freunde = c("alpha", "beta", "gamma")
freunde

# 12.4.2 ####
x = 1:100
y = x[1:10]
z = x[(length(x)-9):length(x)]
cbind(y,z)
class(cbind(y,z))
x[x<11 | x > 90]

# 12.5.2 ####
obst = factor(c(rep(0,4), rep(1,3)), labels = c("Apfel","Ananas"))
obst
gemuese = factor(c(rep("Broccoli",1), rep("Tomate",3)))
gemuese
einkausfkorb = list(fruits=obst, vegetables=gemuese)
einkausfkorb


# 13.2 ####
for (x in 1:10) {
  nor = rnorm(100)
  print(paste("Avg ",x,":",mean(nor)))
  print(paste("SD ",x,":",sd(nor)))
}

x = 1
while (x^3 < 1000) {
  print(paste(x,": ",x^3))
  x = x + 1
}



#14.2 ####
xplus2hoch2 = function(x) {
  (x+2)^2
}
xplus2hoch2(1:10)

wmean = function(x,w) {
  sum(w*x)/sum(w)
}
wmean(1:5,c(2,4,5,6,7))
weighted.mean(1:5,c(2,4,5,6,7))


#14.2 ####
library(foreign)
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")
head(titanic)
summary(titanic)
titanic = droplevels(titanic) #Bereinigung der Daten (Entfernung der Labels ohne Werte)
kreuz = table(titanic$survived,titanic$class)
prop.table(kreuz)
survived = titanic$survived=="yes"
ageSurv = titanic$age2[survived]
ageDead = titanic$age2[!survived]

matrix(c(median(ageSurv), median(ageDead), mean(ageSurv), mean(ageDead)),
       nrow = 2, byrow = TRUE,
       dimnames = list(c("Median","Mean"),c("Survived", "Dead")))

t.test(ageSurv,ageDead)
## gibt Wahrscheinlichkeit zurÃ¼ck (p-value), ein bestimmtes Datenset zu haben unter der Annahme,
## dass sich die zwei Gruppen NICHT unterscheiden


##16.2.2 Übung: Package dplyr ####
allbus = read.dta("http://www.farys.org/daten/allbus2008.dta", convert.factors = FALSE)

allbusRed = allbus %>% 
  select(Geschlecht=v151,Alter=v154,Einkommen=v386) %>%
  filter(Alter!="999" & Einkommen <"99997") %>%
  group_by(Geschlecht, Alter) %>%
  summarise(MittleresEinkommen=mean(Einkommen)) %>%
  arrange(desc(MittleresEinkommen))
head(allbusRed)
library(ggplot2)
ggplot(allbusRed, aes(x = Alter, y = MittleresEinkommen, color = Geschlecht)) + geom_line()

#### 16.3.2 Übung: Package data.table ####
rm(ess)
load(url("http://www.farys.org/daten/ESS.RDATA"))
ess = as.data.table(ess)
#Anzahl Gruppen
ess[,.GRP,Land]
#mit base R:
unique(ess$Land)

#Land mit meisten Befragten
ess[,Anzahl:=.N,Land][order(Anzahl, decreasing = T)][Anzahl==max(Anzahl),,]
#oder:
ess[,.N,Land][order(-N)][1]


#glücklichstes Land
ess[,avgHappy:=mean(happy, na.rm = T),by=Land][avgHappy==max(avgHappy)]
ess[,avgHappy:=mean(happy, na.rm = T),by=Land][avgHappy==min(avgHappy)]

#am meisten 10er:
ess[happy==10,counter:=.N,Land][counter==max(counter)]

## 16.3.2 Lösung #####
library(data.table)
library(dplyr)
library(ggplot2)
load(url("http://www.farys.org/daten/ESS.RDATA"))
#gincdif: The government should take measures to reduce differences in income levels. 1=agree strongly,5=disagree strongly 
#happy: Taking all things together, how happy would you say you are? #10 extremely happy 1 =Extremely unhappy
#uempla: Unemployed, actively seeking

#um Gruppenzähler kennenzulernen
#__________________________________

#2. Verwenden Sie den Group-Counter um herauszufinden, aus wievielen unterschiedlichen Länden die Befragten im Datensatz stammen.#####
#könnte man auch über length(unique(ess$Land)) 

#in data.table:
ess[,.GRP,by=Land]

#in dplyr:
test<-ess %>% # cntrl+shift+m für Pipe operator
  group_by(Land) %>%
  count()
length(test$n) # oder
nrow(test)


#um Fallzähler pro Gruppe kennenzulernen
#__________________________________

#3. Welches Land hat am meisten Befragte?#######
ess[,.N,by=Land][order(N)]

# bei Problemen mit Umlauten:
# ess$Land <- as.character(ess$Land)
# Encoding(ess$Land) <- "latin1"

#dplyr
ess%>%
  group_by(Land)%>%
  count()%>%
  arrange(-n)

#Um Aggregatsfunktion kennenzulernen
#__________________________________

#4. Welches ist das durchschnittlich glücklichste Land? Welches das unglücklichste?#######
ess[,.(m.happy=mean(happy,na.rm=T)),by=Land][
  order(m.happy)]

#Alternativ: ohne order
hap <- ess[,mean(happy,na.rm=T),Land]
setorder(hap,V1)
hap

#dplyr

ess%>%
  group_by(Land)%>%
  summarise(m.happy=mean(happy,na.rm=T))%>%
  arrange(-m.happy)

#um Variablengenerator kennenzulernen (:=)
#__________________________________

#5. In welchem Land gibt es am meisten komplett glückliche Menschen?#######
ess[,`:=`(komplett=ifelse(happy==10,1,0),
          komplettungl=ifelse(happy==1,1,0)),]#um Variable hinzuzufügen
ess[,.(`Anteil komplett glücklich`=mean(komplett,na.rm = T)),by=Land][order(`Anteil komplett glücklich`)]


#dplyr
ess%>%
  mutate(komplett=happy==10)%>%
  group_by(Land)%>%
  summarise(mk=mean(komplett,na.rm=T))%>%
  arrange(-mk)

#um die Verwendung von lagged Werten kennenzulernen
#__________________________________

#Welches Land hat die grösste Einbusse im Durchschnittsglück gehabt#######
#von 2008 bis 2010?
tabelle <- ess[,.(m.happy=mean(happy,na.rm=T)),.(year,Land)][
  order(Land,year)]

tabelle[,Differenz:=m.happy[year==2010]-m.happy[year==2008],by=Land][year==2010][
  order(Differenz)][
    ,c("Land","Differenz"),with=F]

#Alternativ
rank <- ess[,
            .(
              Dif=mean(happy[year==2014],na.rm=T)-
                mean(happy[year==2002],na.rm=T)
            ),
            by=Land]
setorder(rank, Dif)   #damit wird die sort order permanent umgeschrieben
rank
##alternativ: m.happy-m.happy[-.N] (eine Zeile vorher) 
#bei sample mit nur 2008 und 2010 (geordnet)

#dplyr
rank<-ess%>%
  group_by(Land)%>%
  summarise(Dif=mean(happy[year==2010],na.rm=T)-
              mean(happy[year==2008],na.rm=T))%>%
  arrange(Dif)
View(rank)

library(ggplot2)
ggplot(rank%>%filter(!is.na(Dif)),aes(reorder(Land, Dif),Dif))+
  geom_bar(stat = "identity")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))+
  labs(x="",y="Glücklichkeitsveränderung 2010-2008")


# Berechnen sie gleichzeitig den Modus bezüglich Glücklichkeit und Support für Umverteilung#####
# Um Funktion kennenzulernen, mit der man mehrere Variablen gleichzeitig modifiziert:
Mode <- function(x) {
  names(which.max(table(x)))
}
#Komplizierte Mode Funktion: https://www.tutorialspoint.com/r/r_mean_median_mode.htm

#wende Funktion "Mode" auf alle Kolonnen (.SD) an, die hintendran (.SDcols) definiert werden
ess[,lapply(.SD, Mode),Land, .SDcols=c("happy","gincdif")] 



#### 17.7 Übung: Datenimport und -export / Mergen / Tidy Data ####
library(readxl)
library(stringr)
library(dplyr)
# download first file
download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/159578/master",
              destfile = "pop.xls", method = "auto", mode = "wb")
# load excel file (only limited range)
popxl = read_excel("RWD/pop.xls", sheet = "2014", range="A8:B33", col_names = F)
# convert to a data table, get rid of blanks, take col. 2&3
pop = as.data.table(popxl)[,Kanton:=str_trim(X__1),][,2:3,]

# download second file
download.file("https://www.bfs.admin.ch/bfsstatic/dam/assets/81048/master",
              destfile = "tree.xls", method = "auto", mode = "wb")
# load excel file (limited range)
treexl = read_excel("RWD/tree.xls", sheet = "2014", range = "A12:C48", col_names = F)
# convert to a data table, get rid of blanks (also after "."), take col.3&4
tree = as.data.table(treexl)[,Kanton:=str_replace(str_trim(X__1, side = "left"),"\\. ", "."),][,3:4,]

# join 2 tables, add calc. column and sort desc
merged = left_join(pop,tree,by = "Kanton")  %>%
  select(Kanton, Bev?lkerung=X__2, haWald = X__3) %>%
  mutate(BproK = (400*haWald)/Bev?lkerung) %>%
  arrange(-BproK)
# write into csv
write.table(merged, "merged.csv", sep = ";", row.names = F, fileEncoding = "UTF-16LE")


#?bung 19.3 ####
library(foreign)
library(stargazer)
library(dplyr)
# 1.
BMI = read.dta("http://www.farys.org/daten/bmi.dta")
# 2. - 4.
stargazer(BMI[c(1,2,4)],
          summary.stat = c("mean", "median", "n"),
          covariate.labels = c("BMI", "Alter", "Einkommen"),
          type = "html",
          out = "BMI.html")
#5.
topbot = rbind(arrange(BMI, bmi) %>% head(n=5),
               arrange(BMI, -bmi) %>% head(n=5) %>% arrange(bmi)) 

stargazer(topbot, summary = F, type = "text",
          covariate.labels = c("BMI", "Alter", "Geschlecht", "Einkommen", "Bildungsjahre", "ID"))
