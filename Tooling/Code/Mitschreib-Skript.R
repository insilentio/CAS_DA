#Arbeitsverzeichnis, Objekte und Workspace ####
# Kommentare beginnen mit #
# Alles in der Zeile nach # wird von R ignoriert

# 1. R starten
# 2. Ein Arbeitsverzeichnis anlegen in welchem Sie Schreibrechte haben und R auf
# dieses Verzeichnis setzen: setwd()
# 3. Code ausführen mit STRG + R (Oder Icon "Run" oben rechts)

5+5

getwd() # Arbeitsverzeichnis anzeigen
# setwd() # Arbeitsverzeichnis definieren
setwd("meinpfad")

dir() # Arbeitsverzeichnis anzeigen

a <- 50 # Erzeugt Objekt a (Vektor der Länge 1) mit dem einzelnen Wert 50
a

# Objekt erzeugen, dass die Vornamen der Beatles enthält
die.beatles <- c("John","Paul","George","Ringo")
die.beatles
mixed = c(1, 2, "3")

# Mit c() - concatenate lässt sich auch ein Zahlenvektor bauen:
b <- c(1,2,3,4)

# oder kürzer
b <- seq(1,4)

# oder noch kürzer
b <- 1:4

# Objektnamen dürfen keine Leerzeichen haben. Ferner empfiehlt es sich - und _ zu meiden
# (Google R Style Guide)
# Namen sollten aussagekräftig sein. Namensgebung sollte im ganzen Code-File konsistent sein
# (Punkte, Gross-/Kleinschreibung)

ls() # Workspace anzeigen

# Objekte a, b und die.beatles speichern in "beispiel1.RData"
save(a,b,die.beatles,file="beispiel1.RData")

# RData Format ist sehr advanced (minimaler Speicherplatz und schnelle Schreib- und
# Ladegeschwindigkeit) und empfiehlt sich immer, sofern der Export in andere Formate
# (z.B. csv) nicht dringend nötig ist.

# Objekte löschen
rm(a,b,die.beatles) #oder:
rm(list=ls()) # löscht den gesamten Workspace
ls() # was ist jetzt noch im Workspace?
die.beatles # nicht mehr da

load(".RData") # gespeichertes Objekt laden

die.beatles # wieder da


## Packages ####
# nehmen wir an wir möchten eine SPSS Datei einlesen:

??spss

# liefert Hinweise auf die Funktionen read.spss und read_por auf den Paketen foreign und haven

install.packages("foreign") # Install package

?read.spss
# geht erst wenn das Package auch geladen ist

library(foreign)
?read.spss

search()


## Operatoren ####
# Rechnen
ergebnis <- (23+24)*11/(18+15)*5
ergebnis

# Funktionen
log(2.7) #natürlicher Logarithmus
cos(2)
barplot(log10(1:100))

# Vergleich
x <- -3:3
x

5%in%1:5

# sind die Elemente von x gleich 0?
x == 0

# grösser 0?
x > 0

# kleiner 0?
x < 0

# grösser gleich 0?
x >= 0

# kleiner gleich 0?
x <= 0

# ungleich 0?
x != 0

# grösser als -1 aber kleiner als 1
x > -1 & x < 1

# grösser als  1 und kleiner als -1
x > 1 & x < -1

# grösser als 1 oder kleiner als -1
x > 1 | x < -1





# Übersicht Datentypen ####
# Homogen

# Integer Vektor
x <- c(1:9)
class(x)
typeof(x)
x


# Numerischer Vektor
x <- c(1.3, 2.4, 3.5)
class(x)
typeof(x)
x


# Logischer Vektor
x <- -3:3
y <- x >= 0
class(y)
typeof(y)
y

# String/Character Vektor
x <- c("a", "b", "c", "d", "f")
class(x)
typeof(x)
x


# Matrix
matrix.2mal3 <- matrix(c(1,2,11,12,20,30), nrow = 2, ncol=3)
class(matrix.2mal3)
typeof(matrix.2mal3)
matrix.2mal3


# Array (z.B. 3 Matrizen)
arraybsp <- array(1:50, c(5,5,2)) # Zahlen von 1 bis 50 einem Array mit 2 5x5 Matrizen
class(arraybsp)
arraybsp



# Heterogen

# Liste
liste <- list(a= c(4:8), b = c(1:3), c = c(2:10))
class(liste)
liste


# Data frame: Kann man anschauen durch Aufruf von swiss oder fix(swiss)
class(swiss)
swiss
class(swiss$Fertility)

# Faktoren
sex <- c(0,0,1,1)
sexfactor = factor(sex,labels=c("Mann","Frau"))
object.size(sex)
object.size(sexfactor)

# Funktionen: z.B. cos(); mean()
class(mean)
mean
class(lm)
lm

# Beispiel Numerische Vektoren ####
1:100
1:100*3
1/100*3

# Vektor erzeugen und speichern
x <- 3*1:100
x

# oder über concatenate
x <- c(1,2,3,4,5)
x

# Vektor mit 15 Elementen. 5 Wiederholungen von 1,2,3
x <- rep(1:3,5)
x

# Vektor mit Zahlen von 10 bis 100 in Zehnerschritten
x <- seq(10,100,10)
x

# Wie kann man direkt auf einzelne Elemente eines Vektors zugreifen?
x <- 11:200
x
x[1]              # erstes Element von x
x[1:10]           # die ersten 10 Elemente von x
x[-(11:100)]      # Alle Elements von x ausser die Positionen 11 bis 100
x[c(50,100)]


# Wichtiger Hinweis zu fehlenden Werten:
x <- c(1,2,NA,4)

#falsch:
x == NA
x == "NA"

#richtig:
is.na(x)
class(is.na(x))


# Logische und Character Vektoren ####
# Logische Vektoren
x <- -3:3
x
x >= 0


# Character Vektoren
letters
LETTERS
x <- letters[1:10]  # "letter" beinhaltet alle 26 Buchstaben des Alphabets
x                   # siehe auch LETTERS, month.abb und month.name

# Namen zuweisen
x <- c(1,2,3)
names(x)
names(x) <- c("a","b","c")
x

# oder so:
x <- c(a=1,b=2)
x
names(x)


# Vektorenoperationen ####
# Verknüpfen
x <- c(a=10, b=20, c=30, d=40)
x
rbind(x,x)
cbind(x,x)

# Subsets
x <- c(a=10, b=20, c=30, d=40)
x[1:2]
x[c("a","c")]

x[x<20|x>=30]

#### Faktoren und Listen ####
# Faktor erzeugen

sex <- factor(c(rep(0,50),rep(1,50)),labels=c("Mann","Frau"))

# Hinweis zu as.numeric(): manchmal hat man folgendes Problem:
jahrgang <- factor(c("2000","2000","2001","2002")) # falscher Datentyp "character"
# umwandeln in numerische Werte liefert aber nicht, was wir wollen
as.numeric(jahrgang)

# besser:
as.numeric(as.character(jahrgang))

# Eine Liste erzeugen:
kursteilnehmer <- list(Kursleiter= "Rudi",
                       Maenner = c("Simon", "Peter", "usw."),
                       Frauen = c("Daniela","Johanna"))
kursteilnehmer

# Zuriff auf Elemente der Liste
kursteilnehmer$Kursleiter
kursteilnehmer$Maenner      #gibt Vektor zurück
kursteilnehmer[2]           #gibt Liste zurück
kursteilnehmer[[2]]         #gibt Vektor zurück
kursteilnehmer["Maenner"]   #gibt Liste zurück
kursteilnehmer[["Maenner"]] #gibt Vektor zurück

# was ist der Unterschied?
class(kursteilnehmer[["Maenner"]])
class(kursteilnehmer["Maenner"])
# d.h. wenn man mit den Elementen aus einem Listenelement arbeiten will, braucht es
# doppelte Klammern oder Zugriff über "$"

length(kursteilnehmer)
kursteilnehmer$Frauen[2]
kursteilnehmer[[3]][2]

#### Data Frames ####
# fertige Daten sind oft data frames:
library(foreign)
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")
is.data.frame(titanic)
head(titanic)
names(titanic)
attributes(titanic)
str(titanic)
summary(titanic)

# man kann sich auch leicht selber einen bauen
obst <- c("Apfel","Apfel","Birne")
gemuese <- c("Tomate","Karotte","Karotte")
id <- 1:3
df <- data.frame(id, obst, gemuese)
df

# Ansteuern von Zeilen und Spaltenpositionen
df$obst
df[,"obst"]
df[3,"gemuese"]
df[3,3]

#### Kontrollstrukturen und Schleifen ####
# For Schleife
for (x in 1:10) {
  print(sqrt(x))
}

# aber besser:

sqrt(1:10) # da Funktionen in R i.d.R. sowieso vektorisiert arbeiten

# Schleifen machen aber Sinn, wenn es Abhängigkeiten zwischen den Durchläufen gibt:
x <- 0
for(i in 1:10) {
  x <- x+i
  print(x)
}
# x wird immer weiter inkrementiert


# Sequenzen in For-Schleifen können auch Character sein:
namen <- c("Alfred","Jakob","Peter")
for (name in namen) {
  print(paste("Hallo",name))
}

# einfacher aber:
paste("Hallo", namen) #weil vektorisiert

#sinnvolleres Beispiel:

for (dataset in c("data1.csv", "data2.csv", "data3.csv")) {
  read.csv(pfad/dataset)
  # Anweisungen,
  # z.B. Datenbereinigung, Appending (rbind), Modellschätzungen, etc.
}


# Durch Spalten loopen
for (column in 2:6) { # this loop runs through 2 to 6
  print(names(swiss)[column])
  print(mean(swiss[,column]))
}

# aber wieder geht es einfacher und schneller:

colMeans(swiss[,2:6]) # oder
apply(swiss[,2:6],2,mean) # die 2 verweist auf "spaltenweise" (1 wäre zeilenweise).
#D.h. für jede Spalte der Daten wird mean() angewendet


# While Schleife
x <- 0 # Startbedingung sollte gelten
while(x<13) {
  x <- x+1 # inkrementieren, da sonst die Bedingung für immer gilt -> Endlosschleife
  print(x)
}

# wird wiederholt solange x<13==TRUE
# sicherstellen, dass irgendwann das Kriterium FALSE wird!


# if-Beispiel:

# Daten einlesen aus einer Liste von Files
setwd("C:/path/to/some/excel/files")
myfiles <- list.files()
# manche sind aber nun xls, und andere xlsx:

library(tools)
for(file in myfiles) {
  if(file_ext=="xls") {
    daten <- read.xsl(file)
  }
  if(file_ext=="xlsx") {
    daten <- read.xslx(file)
  }
}

# if prüft immer nur genau eine Bedinung.


# ifelse Beispiel:

a<- sample(1:100,10)
b<-ifelse(a<50,"Nicht bestanden", "Bestanden")
b

# ifelse prüft einen Vektor von Bedingungen. Naheliegenderweise ist so ein Konstrukt also
# auch gut zur Datenaufbereitung geeignet.
# obiges Beispiel ist identisch mit aber einfacher als:

b[a<50] <- "Nicht bestanden"
b[a>=50] <- "Bestanden"
b

#### Funktionen ####
print("Hallo")
print

lm

# Beispiel: Definieren einer Funktion
wurzel <- function(x) {
  x^0.5
}

fix(wurzel)
wurzel(4,2)

# Namen eingeben um Inhalt zu sehen
wurzel



#### Kontingenztabellen und Tests ####
# zwei fiktive Vektoren erstellen
x <- c(10,20,30,40,30,10,20,30,40,30,10,20,10)
y <- c(2,5,3,5,3,5,1,6,3,4,5,1,1)

# Tabelle
table(x)
table(y,x)

# Chi2-Test
chisq.test(table(y,x))
fisher.test(table(y,x)) #eigentlich besser für kleine Datenmengen (siehe Warnung bei chisq)

# Tabelle in Prozent
100*prop.table(table(x))
100*prop.table(table(y,x))
round(100*prop.table(table(y,x)), 2) # gerundete Werte

# Mean
mean(x)

# Median
median(x)
sort(x)

# mehrere Statistiken in einem Vektor
c(mean=mean(x), median=median(x), stddev=sd(x), min=min(x), max=max(x))

# gibt es verkürzt über die generische Funktion summary
summary(x)

# Korrelation zwischen Vektoren
cor(x,y)
cor(x,y, method="spearman") #Rangkorrelation
cov(x,y)

# Mittelwertvergleich
t.test(x,y)



#### Datenmanagement ####
## Tidy vs. messy data ##
# Wetterdaten
weather <- read.table(
  "https://raw.githubusercontent.com/justmarkham/tidy-data/master/data/weather.txt",
    header=TRUE)
head(weather) # hier sind Variablen in Zeilen und Spalten

# Daten reshapen (melt) und Missings löschen
# --> die 31 Spalten in Beobachtungseinheiten "Tage" umwandeln
install.packages("reshape2")
library(reshape2) # für melt()/dcast()
weather1 <- melt(weather, id=c("id", "year", "month", "element"), na.rm=TRUE)
head(weather1,10)

# saubere Spalte für "day"
library(stringr)    # für str_replace(), str_sub()
weather1$day <- as.integer(str_replace(weather1$variable, "d", ""))

# die krude Spalte "variable" brauchen wir nicht
weather1$variable <- NULL

# die Spalte element beherbergt zwei unterschiedliche Variablen tmin und tmax.
# Diese sollen in zwei Spalten:
weather1$element <- tolower(weather1$element) # Kleinbuchstaben
weather.tidy <- dcast(weather1, ... ~ element) # reshapen auf zwei Spalten
head(weather.tidy)
weather.tidy$date = as.Date(paste(
  weather.tidy$year,weather.tidy$month,weather.tidy$day, sep = "-"))

## dplyr ##
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

# install.packages("dplyr")
library(dplyr)

filter(titanic, class=="1st class", age2<18)

# konventionell wäre das komplizierter:
titanic[titanic$class=="1st class" & titanic$age2<18,]

# zusätzlich Spalten selektieren:
titanic %>%
  filter(class=="1st class", age2<18) %>%
  select(sex, age2, survived)

# neue Variable "child" bauen
titanic %>%
  mutate(child=age2<18) %>%
  head()

# Auszählen wer gestorben ist nach Geschlecht und Kind (ja/nein)
titanic %>%
  mutate(child=ifelse(age2<18,"yes","no")) %>%
  group_by(sex, child,survived) %>%
  summarise(n=n()) %>%
  arrange(sex,child, survived)



## Package data.table ##
# sicherheitshalber dplyr entladen, da teilweise Funktionsnamen überlappen können
library(dplyr)
detach("package:dplyr")
library(foreign)
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

# install.packages("data.table")
detach("package:reshape2")
library(data.table)

titanic <- as.data.table(titanic) # als data.table definieren
titanic  # man beachte die andere Darstellung. data.table erlaubt sicherheitshalber
# niemals alle Zeilen auf den Workspace zu knallen

# Alternativ zu filter()
titanic[class=="1st class" & age2 < 18]

# Alternative zum Filtern+Selektieren
titanic[class=="1st class" & age2 < 18,.(age2,sex,survived)]
#with=FALSE erlaubt, Vektoren als Input zu verwenden und gibt Daten zurück statt
# "within" die Daten abzuändern.

# Analog zu dplyr: neue Variable "child" bauen
titanic[,child:=ifelse(age2<18,"yes","no")]
titanic[,child:=NULL]#um Spalten zu droppen

# Auszählen wer gestorben ist nach Geschlecht und Kind (ja/nein)
a = Sys.time()
titanic[,n:=.N, by=list(sex, child, survived)]
titanic.summary <- unique(titanic,by=c("sex", "child", "survived")) #hier werden die Gruppen gebildet
setorder(titanic.summary, sex, child, survived)
titanic.summary
b = Sys.time()
b-a

# kompakter: statt Variable anzulegen und die Daten zu "collapsen" kann man auch direkt
# auszählen und ausgeben lassen. Dabei wird "chaining" verwendet (entspricht piping by dplyr).
# "." bei der Variablenliste steht synonym für "list".:
titanic[,n:=.N, by=list(sex, child, survived)][
  ,.SD[1], .(sex, child, survived)
  ][order(sex, child, survived)]

#Aggregation

#Macht dasselbe aber noch kürzer, dropped aber alle Variablen ausser die Aggregationsvariablen
titanic[,.N, .(sex, child, survived)]

# Aggregation über den gesamten Datensatz
titanic[,.("Mittelwert Alter"=mean(age2),"Maximum Alter"=max(age2))]

#Mittleres Alter nach Überlebensstatus. Wenn nur eine Gruppierungsvariable verwendet wird,
# braucht es keinen ".(survived)".
titanic[,.("Mittelwert Alter"=mean(age2),"Maximum Alter"=max(age2),"MinAlter"=min(age2)),survived]

#Was war das häufigste Geschlecht und der häufigste Überlebensstatus nach Klasse?
Mode <- function(x) {
  names(which.max(table(x)))
}

#.SDcols wird als viertes Argument spezifiziert
titanic[,lapply(.SD, Mode),class,.SDcols=c("survived","sex")]



##### Mergen von Daten ###
library(dplyr)
name <- c("Rudi","Simon","Daniela","Viktor")
geschlecht <- c("Mann", "Mann", "Frau","Mann")
daten1 <- data.frame(name, geschlecht)

name <- c("Johanna","Rudi","Simon","Daniela")
alter <- c(33,32,38,45)
daten2 <- data.frame(name, alter)

daten1
daten2

# klassisch
merge(daten1, daten2, by="name") # entspricht inner_join)

# oder über match()
# daten1$alter <- daten2$alter[match(daten1$name,daten2$name)] # entspricht left_join

# mit dplyr
inner_join(daten1,daten2,by="name")
left_join(daten1,daten2,by="name")
right_join(daten1,daten2,by="name")
full_join(daten1,daten2,by="name")

# mit data.table
daten1 <- as.data.table(daten1)
daten2 <- as.data.table(daten2)
setkey(daten1, name)
setkey(daten2, name)
daten1[daten2]
daten2[daten1]
merge(daten1,daten2,all=T) #merge aus data.table package

# rbind / zeilenweise verknüpfen von Daten   --> sehr langsam
name <- c("Rudi","Simon","Daniela","Viktor")
geschlecht <- c("Mann", "Mann", "Frau","Mann")
daten1 <- data.frame(name, geschlecht)

name <- c("Johanna","Ralf")
geschlecht <- c("Frau","Mann")
daten2 <- data.frame(name, geschlecht)

rbind(daten1,daten2)

# rbind() ist sehr langsam. Besser ist rbindlist() aus data.table
rbindlist(list(daten1,daten2))


#### Datenimport und -export ####
#17.3.1 Beispiel: Datenimport aus HTML/XML ----

# XML Beispiel
library(XML)   #nur für NICHT SSH Seiten
u <- "http://www.w3schools.com/xml/simple.xml"
roh <- xmlParse(u)
liste <- xmlToList(roh)
df <- xmlToDataFrame(roh)

# HTML Beispiel
doc <- "http://www.switzerland.org/schweiz/kantone/index.de"
roh <- htmlParse(doc)
tabelle <- getNodeSet(htmlParse(doc),"//table")[[6]]
readHTMLTable(tabelle)

# Alternativ mit rvest:
library(rvest)
roh<-read_html("http://www.switzerland.org/schweiz/kantone/index.de")
tabelle <- html_table(roh,fill=TRUE,header=TRUE)[[6]]


#17.4 JSON Import ----
# Mini Beispiel aus dem Package
library(jsonlite)
json <-
  '[
{"Name" : "Mario", "Age" : 32, "Occupation" : "Plumber"},
{"Name" : "Peach", "Age" : 21, "Occupation" : "Princess"},
{},
{"Name" : "Bowser", "Occupation" : "Koopa"}
]'
mydf <- fromJSON(json)
mydf

# editieren wir die Daten ein bisschen
mydf$Ranking <- c(3, 1, 2, 4)

# und wandeln es zurück nach JSON
toJSON(mydf, pretty=TRUE)


# Beispiel aus dem "echten Leben"
library(httr)
data.json <- fromJSON("http://maps.googleapis.com/maps/api/directions/json?origin=Bern,Fabrikstrasse&destination=Bern,Wankdorffeldstrasse")
data.json <- unlist(data.json)
lat1 <- data.json["routes.legs.start_location.lat"]
lon1 <- data.json["routes.legs.start_location.lng"]
lat2 <- data.json["routes.legs.end_location.lat"]
lon2 <- data.json["routes.legs.end_location.lng"]
distanz <- data.json["routes.legs.distance.value"]
c(lat1,lon1,lat2,lon2,distanz)


#17.5 APIs ----
#Beispiel: World development indicators (Worldbank)
# install.packages("WDI")
library(WDI)
WDIsearch(string="gdp", field="name", cache=NULL)
DF <- WDI(country="all", indicator="NY.GDP.PCAP.PP.CD", start=2010, end=2015) # GDP per Capita kaufkraftbereinigt

# was sind die reichsten Länder 2010?
library(dplyr)
filter(DF, year==2010) %>%
  arrange(-NY.GDP.PCAP.PP.CD) %>%
  head()

# und wie sieht es 2015 aus?
filter(DF, year==2015) %>%
  arrange(-NY.GDP.PCAP.PP.CD) %>%
  head()


#Beispiel 2: Quandl (API zu einer Vielzahl von Datenquellen). Vorsicht: Datenqualität immer ein bisschen hinterfragen!
  # install.packages("Quandl")
library(devtools)
install_github('quandl/R-package')
library(Quandl)

# Authentifizieren (bitte eigenen Account anlegen)
Quandl.api_key("WQoTGqsPCVdpwhtS3xzt")

# Suche nach "Swiss market index" auf quandl.com. Rechts oben "export data" -> R
smi <- Quandl("YAHOO/INDEX_SSMI", trim_start="1990-11-08", trim_end="2015-10-29")
head(smi)

# Inflationsrate
i <- Quandl("RATEINF/INFLATION_CHE", trim_start="1984-01-30", trim_end="2015-09-29")
head(i)


#17.6 Daten aus Datenbanken----
library(DBI)
library(RMySQL)

# Verbindung definieren
con <-  dbConnect(MySQL(),
                  username = "dataviz",
                  password = "CASdataviz2016",
                  host = "db4free.net",
                  port = 3306,
                  dbname = "cas_dataviz"
)

# Get-Anfrage schicken
dbGetQuery(con, "show databases")

# neue Tabelle erstellen
dbSendQuery(con, "CREATE TABLE anmeldungen (id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            vorname VARCHAR(30) NOT NULL,
            nachname VARCHAR(30) NOT NULL,
            email VARCHAR(50),
            reg_date TIMESTAMP)"
            )

# schauen welche Tabellen es gibt
dbGetQuery(con, "show tables")

#   Tables_in_cas_dataviz
# 1           anmeldungen

# Alle Zeilen der Tabelle löschen
# dbSendQuery(con, "DELETE from anmeldungen")

dbSendQuery(con, "INSERT into anmeldungen (vorname, nachname) values ('Rudi', 'Farys')")
dbSendQuery(con, "INSERT into anmeldungen (vorname, nachname,email) values ('Test', 'Test','test@test.de')")

# einfache Abfrage
daten <- data.frame(dbGetQuery(con, "SELECT * FROM anmeldungen"))

daten

dbDisconnect(con)


#18.1.1 Beispiel: Grundlagen ####
# Histogramm von 100 Zufallszahlen erstellen
p <- hist(rnorm(n=100,sd=.8))

# Exportieren
pdf("myhistogram.pdf")  #öffne file stream (neuer graphics device, leitet output um auf "myhistogram.pdf")
hist(rnorm(n=100,sd=.8))
dev.off() #file stream unbedingt wieder schliessen!!

#hier können dann auch Formatvorschriften gemacht werden:
pdf("myhistogram.pdf", width = 12, height = 8)
hist(rnorm(n=100,sd=.8))
dev.off()


# andere einfache Plots
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
plot(cars) # Scatterplot


#### 19.2 Beispiel: Export von Tabellen ####
# Summary Statistiken und einfache Tabellen

library(stargazer)
Prestige <- read.csv("http://farys.org/daten/Prestige.csv")
stargazer(Prestige) #tex
stargazer(Prestige,type="text") #ascii
stargazer(head(Prestige),type="text", summary=FALSE) # blanke Inhalte ausgeben
stargazer(Prestige,type="html",out = "prestige.html") #  html
# Datei schreiben über Option out="path/file"

library(ReporteRs)
 mydoc = docx() # docx erzeugen
mydoc = addFlexTable(mydoc, FlexTable(head(Prestige))) # Tabelle zufügen
writeDoc(mydoc, file = "prestige.docx") # in Datei schreiben



# Regressionstabellen:

# Ein paar Zufallszahlen
x1 <- rnorm(100)
x2 <- rnorm(100)
y <- rnorm(100) + 2*x1 + 1*x2

fit1 <- lm(y~x1)
fit2 <- lm(y~x2)

library(texreg)
htmlreg(list(fit1, fit2), file = "meinetabelle.doc") # fake doc file
htmlreg(list(fit1, fit2), file = "meinetabelle.html") # html
texreg(list(fit1, fit2), booktabs = FALSE, dcolumn= FALSE) # tex

#oder mit stargazer:
stargazer(list(fit1, fit2), type = "html", out="regression.html")


# 20.1 Lineare Regression ####
# Berufliches Prestige und Bildung bzw. Einkommen

# Paket "car" laden bzw. installieren, da dort der Beispieldatensatz "Prestige" enthalten ist
library(car) # alternativ, falls car Probleme mit Abhaenigkeiten macht: Prestige <- read.csv("http://farys.org/daten/Prestige.csv")

# FÜr folgendes Beispiel brauchen wir jedoch die Funktion scatter3d() aus car. Das Dependency Problem lässt sich ggf. so lösen:
# install.packages("lme4") # dependency für altes pbkrtest
# packageurl <- "https://cran.r-project.org/src/contrib/Archive/pbkrtest/pbkrtest_0.4-4.tar.gz"
# install.packages(packageurl, repos=NULL, type="source") # von hand installieren
# install.packages("car") # jetzt car installieren mit den manuell installierten dependencies
# library(car)
library(rgl)
# Wie kann man sich eine Regression mit zwei erklärenden Variablen vorstellen? Als Ebene durch eine 3d Punktewolke!
scatter3d(Prestige$income,Prestige$prestige,Prestige$education, fit="linear")

# Ein kleines Modell schätzen:
fit <- lm(prestige ~ education + income, data=Prestige)

# summary() ist eine generische Funktion. Für ein lm() Objekt wird ein typischer Überblick über Koeffizienten und Modellgüte gegeben
summary(fit)

# Was steckt im fit Objekt?
names(fit)

# Zugriff auf Koeffizienten und andere Bestandteile
fit$fitted.values # Vorhersage (y-Dach)
fit$residuals     # Residuen = Fehler, d.h. die Abweichung der beobachteten Werte
# von der Modellvorhersage
coef(fit)         # Koeffizienten
fit$coefficients


# 21.2 Zeitreihenanalysen
# install.packages("quantmod")
library(quantmod)
getSymbols("^SSMI")

head(SSMI)

# install.packages("forecast")
library(forecast)

fit <- auto.arima(to.monthly(SSMI)[,"SSMI.Adjusted"])

plot(forecast(fit,h=6))


