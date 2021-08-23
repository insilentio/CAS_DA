##
## Skript:      1 WarmUpmitR ####
## Studiengang: CAS Datenanalyse 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Verstehen, wie bereits installierte Datensätze geladen werden
##              (2) Erste (nichtvisuelle) Datenexploration 
##

## Übungsdatensätze in R ###

# Lassen Sie sich die Datensätze anzeigen, die in R für Übungszwecke implementiert sind
data()

## Suchen Sie den Datensatz zu "Motor Trend Car Road Tests" und führen Sie eine erste Begutachtung durch, 
## die Ihnen Aufschluss zu folgenden Fragen geben
## Hinweis: Die Daten müssen nicht explizit geladen werden
## Sie stehen sozusagen direkt zur Verfügung
mtcars

## Mit help erhalten Sie zusätzliche Informationen zu den Daten
help("mtcars")

#
# Begutachten Sie den Datensatz
# Wieviele Variablen sind vorhanden?
ncol(mtcars)
# Wie heissen die Variablen?
names(mtcars)
# Wieviele Objekte gibt es?
nrow(mtcars)
# Was sind die Objekte?
rownames(mtcars)
# Wie sind die Variablen kodiert? Welche Datenypen liegen vor?
str(mtcars) # Obige Angaben sind ebenfalls einsehbar
# Lassen Sie sich die ersten und die letzten sechs Objekte anzeigen
head(mtcars)
tail(mtcars)

# Was ist der Wertebereich für die Anzahl Zylinder (cyl)?
# Wie hoch ist die durchschnittliche Pferdestärke (hp)? Wie hoch ist der Median?
summary(mtcars)

# Installieren Sie mit untenstehender ipak-Funktion die Pakete, die später benötigt werden
# Quelle: https://gist.github.com/stevenworthington/3178163
# "ggplot2", "gcookbook", "vcd", "corrplot","ggthemes","ReporteRs","dplyr","GGally","scales","reshape2","tibble"
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("ggplot2", "gcookbook", "vcd", "corrplot","ggthemes", "ReporteRsjars",
              "ReporteRs","dplyr","GGally","scales","reshape2","tibble")
ipak(packages)


##
## Skript:      2 Plot-Techniken-eine-Variable ####
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Univarite Techniken der Datenexploration mit R
##              (2) Unterschiede konventionelle Plot-Methode und ggplot erkennen 
##              (3) Kernelemente von ggplot kennenlernen (daten, aes und geom_)
##      
## Libraries
library(ggplot2)

# Daten - Motor Trend Car Road Tests - mtcars
# Führen Sie eine erste Datenbegutachtung durch, damit Sie eine grundlegende Vorstellung
# der verwendeten Daten haben
help(mtcars)

## Balken-Diagramme
# Erstellen Sie ein Balken-Diagramm für die Zylinderzahl mit der konventionellen Plot Funktion
barplot(table(mtcars$cyl))

# Man beachte: es ist nötig, eine Häufigkeitsauszählung einzuweben

# Erstellen Sie ein Balken-Diagramm mit ggplot 
# Übergeben Sie die Varialbe cyl einmal als kategoriales Merkmal (factor) 
# und einmal als metrisches Merkmal (numeric)

# Mit Zylinder als kategorialem Merkmal
ggplot(mtcars, aes(x=factor(cyl)))+
  geom_bar()

# Mit Zylinder als kontinuierliches Merkmal
ggplot(mtcars, aes(x=as.numeric(cyl)))+
  geom_bar()


## Ein Kuchendiagram
# Zeichnen Sie ein Kuchendiagram mit der konventionellen Plot Funktion
cylinder<-table(mtcars$cyl)
pie(cylinder)

## In ggplot gibt es keine direkte Umsetzung eines Kuchendiagrammes, weil Hadley Wickham, wie viele andere Statistiker
## glaubt, dass Kuchendiagramme ungenau sind
## Mit ein bisschen Arbeit lässt sich jedoch ein Kuchendiagramm über einen Barchart und der 
## einem polaren Koordinaten-System -> coord_polar() erstellen
## vgl. http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html
## oder http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization


## Histogramme
# http://www.r-bloggers.com/how-to-make-a-histogram-with-basic-r/
# Untersuchen Sie die Verteilung der Variable mpg (miles per gallon)
# Die Variable gibt Auskunft zum Benzinverbrauch
# (eine Meile ~1.6 KM, eine Gallone ~ 3.8 liter)

# Erstellen Sie ein Histogramm mit der konventionellen Plot Funktion
# In welche Kategorie fallen am meisten Fahrzeuge?
hist(mtcars$mpg)

# Die Intervallbreite wird von R automatisch bestimmt.

# Verändern Sie die Zahl der Klassen über die Option breaks 
# Wie sieht das Histogram aus mit 5,7,10 Unterteilungen aus?
# Ändert sich etwas in Bezug auf die Aussage, welch Kategorie von Benzinverbrauch am häufigsten vorkommt?
hist(mtcars$mpg, breaks=10)

# Hinweis: die Bandbreite wird nicht direkt umgesetzt
# Mehr Kontrolle hat man, wenn man die Intervallsgrenzen als vector übergibt.

# Mit ggplot verwendet man geom_histogram()
# Erstellen Sie ein Histogramm mit ggplot

# Was passiert, wenn wir einfach mit einem geom_bar() arbeiten?
ggplot(mtcars, aes(x=mpg))+
  geom_bar()

# Nicht ideal, weil mpg eine kontinuierliche Variable ist. Genau dafür ist das Histogram

# ggplot nutzt dafür das geom_histogram()
ggplot(mtcars, aes(x=mpg))+
  geom_histogram()

# Wie geht ggplot bei der Bestimmung der Breite der Intervalle vor?
# ggplot verwendet bins=30 als default
# Mit ggplot lässt sich die Breite der Klassen bspw. über "binwidth" steuern 
# Justieren Sie die Intervallbreit so, dass sie ungefähr der Einteilung von breaks=10 mit der konvetionellen Plot-Funktion entspricht.
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=3)

# Histogramme beinhalten immer einen Informationsverlust
# Die Verteilung innerhalb der Intervalle bleibt unbekannt. Testen Sie unterschiedliche Anzahlen für Einteilungsklassen (bins) 


## Boxplot
# 
# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit der konventionellen Plotfunktion
boxplot(mtcars$hp)

# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit ggplot
ggplot(data=mtcars, aes(x="",y=hp))+
  geom_boxplot()
# Hinweis: geom_boxplot braucht eine Spezifikation für das x-aes, daher x=""

# Gibt es ein Auto, dass Aufgrund der Daten als Ausreiser bezeichnet werden kann? Um welches Auto handelt es sich?
ggplot(data=mtcars, aes(x=factor(""),y=hp))+
  geom_boxplot()+
  geom_text(data=mtcars[mtcars$hp>300,],label=rownames(mtcars[mtcars$hp>300,]))


## Wrap-Up: Funktionsweise von ggplot2
#
# ggplot benötigt im Minimum 
# (1) Daten(data), 
# (2) eine Definition der zu visualisierenden Variablen (aes)
# und (3) eine Anweisung zur visuellen Repräsentation der Daten (geom_)
# Die Grafik wird Komponentenweise aufgebaut (+)

# Es gibt unterschiedliche Schreibweisen und Möglichkeiten zur Spezifikation der Parameter
# Untenstehende Varianten führen alle zum selben Ergebnis
# Im Rahmen des Kurses wird in der Regel die erste Schreibweise verwendet

# Variante 1
ggplot(data=mtcars, aes(x=factor(""),y=hp))+
  geom_boxplot()

# Variante 2
ggplot(data=mtcars)+
  aes(x=factor(""),y=hp)+
  geom_boxplot()

# Variante 3
ggplot()+
  geom_boxplot(data=mtcars,aes(x=factor(""),y=hp))

# ggplot-Graphiken können als eigene Objekte gespeichert (und erweitert) werden
boxplot<-ggplot()
boxplot<-boxplot+geom_boxplot(data=mtcars,aes(x=factor(""),y=hp))
boxplot

# Was passiert hier?
ggplot(data=mtcars, aes(x=factor(""),y=disp))+
  geom_boxplot(aes(x=factor(""),y=hp))+
  geom_point()

# Einmal definierte Parameter werden "nach unten" vererbt und können nicht überschrieben werden



##
## Skript:      3 Plot-Techniken-zwei-Variablen ####
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziel:    1) Bivariate Techniken der Datenexploration mit R oder Visualisierungen mit zwei Variablen
##              2) Erstellen von geläufigen Diagrammen: Liniendiagrammen, gruppierte Box- und barplots und Scatterplots
##              3) Weitere Elemente von ggplot kennenlernen: statistics, themes und scales
##
##
## Libraries
library(ggplot2)
library(dplyr)

## Liniendiagramme
# Geeignet für ein kontinuerliches Merkmal (viele Ausprägungen 5+) auf der x-Achse  
# und ein kontinuerliches Merkmal auf der y-Achse (Bsp. eine Zeitreihe)

# Daten- BOD > Biochemical Oxygen Demand
# Schauen Sie sich den Datensatz an. Was wurde mit dem Datensatz untersucht? Was wurde gemessen?
help(BOD)

# Wie entwickelt sich die biochemische Sauerstoff-Nachfrage von Wasser über die Zeit?
# Erstellen Sie ein Liniendiagram mit der Zeit (Time) auf der x-Achse und der Sauerstoff-Nachfrage (demand) auf der y-Achse

# ggplot zeichnet Linien mit geom_line()
ggplot(BOD,aes(x=Time, y=demand)) +
  geom_line()

# Fügen Sie der Grafik ebenfalls die Messpunkte hinzu (mit +geom_point)
# Nur so wird ersichtlich, für welche Zeitpunkte tatsächlich Messungen vorliegen.
# Sind für alle Zeitpunkte Messdaten vorhanden?
ggplot(BOD,aes(x=Time, y=demand)) +
  geom_line() +
  geom_point()


## Balkendiagramme 
#
# Geeignet für ein kontinuierliches Merkmal mit wenig Ausprägungen oder ein kategoriales Merkmal auf der x-Achse
# und einem kontinuierlichem Merkmal auf der y-Achse (Bpsw. Gruppenvergleiche für wenige Beobachtungen)

# Wie sieht der BOD-Line-Plot von oben (x=Time, y=demand) mit Balken aus?

# Wie sieht der BOD-Plot mit Balken aus? Falsch
ggplot(BOD,aes(x=Time, y=demand)) +
  geom_bar()

ggplot(BOD,aes(x=demand)) +
  geom_bar()

# Achtung: Die Standardeinstellung von geom_bar() ist stat="count", d.h. die Höhe der Balken wird entsprechend der Anzahl Ausprägungen je Kategorie gezeichnet. 
help(geom_bar)
# Das passt prima für eine Häufigkeitsauszählung, nicht jedoch für die Anwendung hier.
# Im vorliegenden Fall soll die Länge der Balken entsprechend der beobachteten Werte gezeichnet werden. 
# Überschreiben Sie den Standardparameter mit dem Zusatz stat="identity"

# Wie sieht der BOD-Plot mit Balken aus? Richtig
ggplot(BOD,aes(x=Time, y=demand)) +
  geom_bar(stat="identity")


## EXTRA zu Balkendiagramme 
# Eine elegante Alternative zum Bar Charts ist der Cleveland Dot Plot
# Er verwendet Punkte mit Linien anstelle von Balken
# Er ist übersichtichler, weil weniger "Tinte" verwendet wird (Edward Tufte, Daten-Design-Guru, empfiehlt möglichst auf Grafik-Junk zu verzichten, d.h. überflüssige "Tinte" zu entfernen)
# Der Cleveland-Dot-Plot eignet sich daher für den Vergleich vieler Gruppen/Objekte 
# (kategoriale Variablen mit vielen Ausprägungen) weil er übersichtlicher ist

# Benötigte Library (für die Daten)
library(gcookbook)

# Daten: tophitters2001: Batting averages of the top hitters in Major League Baseball in 2001
# Baseball-Statistik der besten 144 Hitter 

# Inspizieren Sie die Daten
str(tophitters2001)
help("tophitters2001")

# Wir wollen die mittlere Anzahl getroffener Schläge je Spieler untersuchen (avg)

## Als Bar-Plot (geom_bar)
ggplot(tophitters2001, aes(x=name,y=avg)) +
  geom_bar(stat="identity")

# Als Punkt-Plot (geom_point)
ggplot(tophitters2001, aes(x=avg,y=name)) +
  geom_point()

# Es sind zu viele! Wir wollen wirklich nur die Besten
# Grenzen Sie die Daten auf die jene Hitters ein, die eine Trefferquote >0.31 haben
tophit<-filter(tophitters2001, avg>0.30)

# Erstellen Sie nochmals einen Punkte-Plot
ggplot(tophit, aes(x=avg,y=name)) +
  geom_point()

# Jetzt ordnen wir die Namen (mit reorder())
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_point()


# Und noch ein bisschen Zusatzästhetik. Voilà ein Cleveland-Dot-Plot 
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_segment(aes(yend=name),xend=0, colour="grey50")+
  geom_point(size=2)+
  labs(x="Mittlere Trefferquote je Versuch",y="")+
  theme_bw()+
  theme(panel.grid.major.y=element_blank())

# Ende EXTRA zu Balkendiagramme 


## Boxplots 
# Sind besonders für Gruppenvergleiche von kontinuierlichen Variablen mit vielen Beobachtungen geeignet
# Nutzen Sie erneut den Auto-Datensatz (mtcars)
# Übergeben Sie die Zahl der Zylinder(cyl) als x-Wert und die PS(hp) als Y-Wert

ggplot(data=mtcars, aes(x=factor(cyl),y=hp))+
  geom_boxplot()

# Beeinflusst die Zahl der Zylinder die PS?
# Würde sagen, ja.

## Streudiagram / Scatterplot
#
# Geeignet zur Darstellung beobachteter Wertepaare zweier metrischer Variablen

# Daten (heightweight): Height and weight of schoolchildren
# Machen Sie sich mit den Daten vertraut. Welche Informationen beinhaltet der Datensatz?

# Erste Dateninspektion
heightweight
help("heightweight")

# Erstellen Sie einen Scatterplot mit dem Alter der Schulkinder(ageYear) auf der X-Achse 
# und dem Grösse (heightIn) auf der Y-Achse
# Frage: Wie hängt das Alter mit der Grösser zusammen?
ggplot(heightweight, aes(x=ageYear,y=heightIn)) +
  geom_point()

# Frage: Gibt es einen Zusammenhang zwischen dem Alter und der Grösse der Schulkinder?
# Der Zusammenhang kann mit einer Regressionslinie veranschauchlicht werden
# +stat_smooth(method=lm, se=FALSE)
ggplot(heightweight, aes(x=ageYear,y=heightIn)) +
  geom_point()+
  geom_smooth(method="glm", se=F)


## EXTRA zu Scatterplot
# Was geschieht, wenn viele Datenpunkte vorliegen (grosse Datensätze)?
# Die Datenpunkte überlagern (Overplotting) und 
# es wird schwierig die Verteilung der Daten in diesem Bereich zu erkennen
# Daten: diamonds Data - Prices of 50,000 round cut diamonds

# Erste Dateninspektion
diamonds
help(diamonds)
str(diamonds)

# Nun zeichnen wir einen Scatterplot mit über 54'000 Datenpunkten
# Plotten Sie das Gewicht der Diamanten (carat) auf der x-Achse und 
# den Preis in US-Dollars (price) auf der y-Achse
ggplot(diamonds, aes(x=carat,y=price))+
  geom_point()

# Einige Muster werden kenntlich, Grenzen bei 1, 1.5 und 2 carat
# Insbesondere im Bereich von 0 bis 2 carat bleibt die Sache obskur

# Es besteht die Möglichkeit, die Dichte zusätzlich mit einer Farbe zu visualisieren
# Dafür wird die Funktion stat_bin2d() verwendet, die die Fläche in Rechtecke einteilt 
# und die Anzahl der Beobachtungen innerhalb eines Rechteckes farblich abbildet (ein fill-aesthetic wird eingefügt)
# Dichte ist je Bins visualisiert
ggplot(diamonds, aes(x=carat,y=price))+
  geom_bin2d(bins=50)

# Die verwendete Farbskale können wir überschreiben mit einem scale_fill_gradient-Element
ggplot(diamonds, aes(x=carat,y=price))+
  stat_bin2d(bins=50)+
  scale_fill_gradient(low="lightblue",high="red",limits=c(0,6000))



##
## Skript:      4 Plot-Techniken-drei-Variablen ####
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   Techniken der Datenexploration mit R - drei Variablen
##
# Libraries
library(ggplot2)
library(vcd)
library(dplyr)

## Mosaic-Plot 
# zur Visualisierung von bivariaten Häufigkeitsverteilungen 
# von kategorialen Variablen

# Daten - UCBAdmissions - Student Admissions at UC Berkeley
# Schauen Sie sich die Daten an
UCBAdmissions
help("UCBAdmissions")
str(UCBAdmissions)

# UCBAdmissions ist ein aggregierter Datensatz von Bewerbern der Universität 
# Berkley unterschieden nach Departement und Geschlecht

# Hintergrund: Von 2691 Bewerbern, wurden 1198 (44.5%) zugelassen
# Zum Vergleich: von den 1835  Bewerberinnen, wurden ledilgich 557 (30.4%) zugelassen
# Die Universität Berkley wurde entsprechend verklagt.
# Bei der Diskriminierungsklage gegen die Universität Berkeley handelt es sich 
# um ein berühmtes Beispiel zur Veranschaulichung des Simpson-Paradoxons
# https://de.wikipedia.org/wiki/Simpson-Paradoxon
#
# Frage: Wurden Frauen wirklich benachteiligt ?

# Das Datenformat ist etwas spezieller
# (3-dimensionales Array, können mit table() erstellt werden)
## 3-Way Frequency Table Beispiel
## mytable <- table(A, B, C) 

# Schauen Sie sich die Daten mit ftable() an
ftable(UCBAdmissions)

## Ein Mosaik-Plot unterteilt die Daten der Reihenfolge der Eingabe nach
# Mosaik-Plot mit Zulassungen und Geschlecht
mosaic(data=UCBAdmissions,~Admit+Gender)

# Was können Sie aus dem Mosaik-Plot in Bezug 
# auf die Zulassungspraktiken nach Geschlecht ablesen?
# Bei der Gruppe der Zugelassenen überwiegen Männer

# Es wird ersichtlich, dass mehr Leute für ein Studium abgewiesen(rejected) als zugelassen (admitted) wurden
# und das bei der Gruppe der zugelassen mehr Männer vertreten sind. Werden Frauen diskriminiert? (deshalb wurde geklagt)
# Der Vergleich über die Departement ist so jedoch schwierig.

# Mosaik-Plot mit Zulassung, Geschlecht und Departement
mosaic(~Admit+Gender+Dept,data=UCBAdmissions)

# Was wird ersichtlich, wenn wir zuerst nach Departement splitten?
mosaic(~Dept+Gender+Admit,data=UCBAdmissions)

# Zusätzliche optische Unterstützung gibt es mit den Optionen highlighting und direction
# Highlighting hebt Ausprägungen einer Variable farblich hervor
# direction gibt an in welche Richtung die Splitt's erfolgen v=vertical, h=horizontal
# Heben Sie die Geschlechter farblich hervor mit folgendem Code-Schnippsel
# highlighting = "Gender",highlighting_fill=c("lightblue","pink"), direction=c("v","v","h")
# Testen Sie die Darstellungsmöglichkeiten indem Sie die Parameter "v" und "h" austauschen.

mosaic(~Dept+Gender+Admit,data=UCBAdmissions,
       highlighting = "Gender",highlighting_fill=c("lightblue","pink"),
       direction=c("v","v","h"))

# Fällt Ihnen etwas auf bezüglich Zulassung nach Geschlecht?


## Linienplots mit einer Gruppen-Variable ergänzt
# kategoriale Variable auf der x-Achse, metrische auf der y-Achse + kategoriale Variable (Gruppe)
# Daten: ToothGrowth - The Effect of Vitamin C on Tooth Growth in Guinea Pigs
help(ToothGrowth)

# Die Studie untersucht den Effekt von Vitamin C auf die Zähne. Dafür wurden unterschiedliche
# Verabreichungsmethoden getestet (VC=ascorbic acid, OJ=orange juice)
# Sind die Zähne der Meerschweinchen in Abhängigkeit der Dosis und der Verabreichungsmethode gewachsen?

# Wir berechnen das mittlere Wachstum der Zähne der Meerschweinchen 
# nach Verabreichungsmethode und Dosis (6 Gruppen) und speichern diese im Objekt tg
tg<-ToothGrowth%>% 
  group_by(supp,dose) %>% 
  summarise(length= mean(len))

# Erstellen Sie zur Beantwortung der Untersuchungsfrage
# einen Linien-Plot mit der Dosis auf der x-Achse (dose) und der Länge der Zähne auf der y-Achse (length)
# Stellen Sie den Linienverlauf nach Verabreichungsmethode farblich dar (colour=supp)
ggplot(tg,aes(x=dose, y=length,colour=supp)) +
  geom_line()

# Erstellen Sie  den selben Linien-Plot, der die Verabreichungsmethode über unterschiedliche Linientypen darstellt (linetype) anstatt über Farben
# Zeichnen Sie zusätzlich zu den Linien alle Messpunkte in die Grafik ein
ggplot(tg,aes(x=dose, y=length,linetype=supp)) +
  geom_line() +
  geom_point()


## Barplots mit drei Variablen
# 2 kategoriale Variablen und eine metrische Variable (Outcome)
# Wenn theoretische begründete Vorstellungen zu Ursache und Wirkungszusammenhängen bestehen. 
# Bietet sich folgende Anordnung an: x-Achse (erklärende Variable), Y-Achse (zu erklärende Variable),
# Farb-Unterschiede für Gruppen (Drittvariablen)

# Daten - Data from a cabbage field trial (Summary)
help("cabbage_exp")

# Erstellen Sie einen Barplot, der auf der X-Achse die Information zum Datum enthält, 
# an welchem der Versuchs-Kohl gepflanzt wurde (Date), das mittlere Gewicht auf der y-Achse 
# sowie die unterschiedlichen Kultivierungsmethoden (cultivar) farblich aufzeigt (fill=)
# Hat die Kultivierungsmethode einen Einfluss auf das mittlere Gewicht der untersuchten Kohle?
ggplot(cabbage_exp, aes(x=Date,y=Weight,fill=Cultivar))+
  geom_bar(position="dodge",stat="identity")

# Ohne position="doge" wird ein gestapelter Barplot gezeigt.
# Für den Vergleich der Kultivierungsmethoden sind die getrennten Balken aber effektiver


## Scatterplots mit 3 Variablen
# (2 kontinuierliche Variablen) und eine Gruppenvariable 

# Daten: heightweight - Height and weight of schoolchildren
# Nehmen Sie eine erste Dateninspektion vor
heightweight
help("heightweight")

# Ausgangspunkt ist der im vorangehenden Skript erstellte Scatterplot, 
# der Grösse und Alter der Schulkinder plottet
ggplot(heightweight, aes(x=ageYear,y=heightIn)) +
  geom_point()

# Wie sieht der Plot aus, wenn Geschlechterunterschiede (sex) farblich abgebildet werden (colour=)? Ist der Zusammenhang von Alter und Grösse für Mädchen und Jungs anders?
ggplot(heightweight, aes(x=ageYear,y=heightIn,colour=sex)) +
  geom_point()

# Ergänzen Sie den Plot mit einem stat_smooth(method=loess)
# Damit werden Linien mit lokaler Anpassung an die Daten angezeigt, 
# um den Zusammenhang von Alter und Grösse für Mädchen und Jungs unterschieden darzustellen
ggplot(heightweight, aes(x=ageYear,y=heightIn,colour=sex)) +
  geom_point()+
  stat_smooth(method=loess)


## Sind Plots mit drei kontinuierlichen Variablen möglich?
# Klar. Hier kommt der Der Bubble-Chart/Ballon-Chart
## Daten: countries - Health and economic data about countries around the world from 1960-2010
str(countries)
help(countries)

# Die Daten werden eingegrenzt - nur 2009
countsub<-filter(countries, Year==2009)

# Zeilen mit fehlenden Werten und die Variable laborrate[5] werden gelöscht)
countsub<-countsub %>%
  na.omit() %>%
  select(-laborrate)

# Wie ist der Zusammenhang zwischen Kindersterblichkeit(infmortality), 
# Gesundheitsausgaben (healthexp) und dem Bruttosozialprodukt (GDP)?
# Erstellen Sie zur Beantwortung dieser Frage einen Bubble-Chart 
# mit den Gesundheitsausgaben auf der x-Achse, der Kindersterblichkeit 
# auf der y-Achse und dem Bruttosozialprodukt visualisiert über die Grösse der Punkte
# über aes(x=,y=,size=)
ggplot(countsub, aes(x=healthexp, y=infmortality, size=GDP))+
  geom_point()

# Wenn man die Kreise etwas grösser zeichen will, braucht es scale_size_area(max_size=)
ggplot(countsub, aes(x=healthexp, y=infmortality, size=GDP))+
  geom_point() +
  scale_size_area(max_size=10)

# Alternative-Darstellung 
ggplot(countsub, aes(x=GDP, y=healthexp, size=infmortality))+
  geom_point() +
  scale_size_area(max_size=15)


##
## Skript:      5 Spezialisierte-Auswertungstechniken ####
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziel:    Visuelle Auswertungstechniken kennenlernern 
##              zur Visualisierung mehrerer Variablen
##

## Visualisation von Korrelationsmatrizen mit einem Correlogram
## Mittels Correlogram lässt sich ein schneller Überblick zu Zusammenhängen in den Daten erhalten
# Daten - mtcars: Motor Trend Car Road Tests
#help(mtcars)

# Eine Korrleationsmatrize gibt alle paarweise möglichen Korrelation wieder
# Packen Sie den ganzen Datensatz in die Funktion cor()
cor(mtcars)

# Es ist schwierig zu erkennen, wo die Musik spielt
# Ein Korrelations-Plot kann Abhilfe schaffen 
# Speichern Sie das Resultat im Objekt mcor
# und plotten Sie dieses Objekt mit corrplot()
mcor<-cor(mtcars)
library(corrplot)
corrplot(mcor)

# corrplot verfügt über verschiedene nützliche Optionen.
help("corrplot")
# Ergänzen Sie die corrplot mit der Option addCoef.col = "black"
corrplot(mcor, addCoef.col = "black")

# Mit "number.cex" justiert die Textgrösse 
corrplot(mcor, addCoef.col = "black",number.cex=0.5)

## Scatterplot-Matrix
# Ähnlich wie eine Korrelationsmatrix visualisiert eine Scatterplot-Matrize 
# bivariate Zusammenhänge in Daten

## Daten: countries - Health and economic data about countries around the world from 1960-2010
library(GGally)
help(countries)

# Wir untersuchen, wie Wirtschaftswachstum (GDP), Erwerbsquote(laborrate)
# Gesundheitsausgaben (healthexp) und Kindersterblichkeit (infmortality)
# korrelieren

# Erneut wird zuerst ein Subset für das Jahr 2009 erstellt
c2009<-countries %>%
  filter(Year==2009) %>%
  select(c(-Code,-Year))

# Die Funktion ggpairs() ist ausgezeichnet für Scatterplot-Matrizen
# Erstellen Sie eine Scatterplot/Korrelations-Matrix aller Variablen des reduzierten 
# Datensatzes c2009 (Achtung: schliessen Sie die Variable "Name" aus)
ggpairs(c2009[,2:5])

# Der Plot unterscheidet drei Bereiche: Die Diagonale (diag), den Bereich oberhalb der 
# Diagonale (upper) und den Bereich unterhalb der Diagonale (lower)
# Varieren Sie die Standardeinstellung wie folgt:
# (1) Ersetzen Sie die Dichtfunktion in der Diagonalen mit Bar-Plots
# (2) Ergänzen Sie die Scatterplots mit einer linearen Kurve 
ggpairs(c2009[,2:5], 
        diag = list(continuous="barDiag"),
        lower = list(continuous="smooth"))

# Zwischen welchen Variablen ist die Korrelation am stärksten? GDP und healthexp
# ist der Zusammenhang überall linear? Nein, GDP vs infmortality + healthexp vs infmortality

# Ein Modell, dass die Kindersterblichkeit untersucht, sollte diese Terme 
# entsprechend in quadrierter Form mit ins Modell aufnehmen

M1<-lm(data=c2009, infmortality~GDP+laborrate+healthexp)
summary(M1)

c2009$GDP2<-c2009$GDP^2
c2009$healthexp2<-c2009$healthexp^2

M2<-lm(data=c2009, infmortality~GDP+GDP2+laborrate+healthexp+healthexp2)
summary(M2)

## Facets oder Trellis-Plots
# Faceting ist eine spezielle ggplot Technik, die es erlaubt Subplots geschichtet nach Gruppen darzustellen
# Deswegen sind Factes besonders für Gruppenvergleiche geeignet
# Diese Art von Plots werden auch Trellis Graphen genannt (weil Sie wie Gitter aussehen)

# Daten mpg - Fuel economy data from 1999 and 2008 for 38 popular models of car
help(mpg)

# Ausgangsplot: ein Scatterplot mit Hubraum (displ) und Benzinverbrauch (hwy)
ggplot(mpg, aes(x=displ, y=hwy))+
  geom_point()

# Nutzen Sie die Facets-Funktion indem Sie obige Scatterplots unterschieden nach Antriebssystem darstellen (drv) 

# Stellen die Subplots vertikal dar (+facet_grid(var~.))
ggplot(mpg, aes(x=displ, y=hwy))+
  geom_point()+
  facet_grid(drv ~.)

# Stellen Sie die Subplots mit horizontaler Anordnung dar (+facet_grid(.~var))
ggplot(mpg, aes(x=displ, y=hwy))+
  geom_point()+
  facet_grid(.~drv )

# Nehmen Sie einen zweifache Facet-Splits vor (Zylinderzahl (cyl) ~ Antriebssystem (drv))
ggplot(mpg, aes(x=displ, y=hwy))+
  geom_point()+
  facet_grid(drv~cyl)

## Bonus
# Radar-Charts
# ermöglichen es Profile zu bilden und so erweitere visuelle Vergleiche anzustellen
# Damit wir einen Radarcharts bauen können, müssen die Daten im long-Format sein
#
library(scales)
library(reshape2)
library(tibble)

profil_cars <- mtcars %>%
  rownames_to_column( var = "car" ) %>% # Zeilennamen werden als Variable gespeichert
  mutate_each(funs(rescale), -car) %>%  # Reskalieren der Variablen zwecks Vergleichbarkeit
  melt(id.vars=c("car"), measure.vars=colnames(mtcars)) %>% 
  arrange(car)

# Schauen Sie sich den neuen Datensatz an, damit sie verstehen, wie er umgeformt ist
head(profil_cars)
str(profil_cars)

# Zeichne wir aber zuerst nur ein Profil für den "Ferrari Dino"
ferrari<-profil_cars %>%
  filter(car=="Ferrari Dino")

# Zeichnen Sie die Werte für den Ferrari als Linienplot
# Achtung: es braucht group=1 bei den aesthetics, damit ggplot weiss, dass die Werte zusammengehören
ggplot(ferrari)+
  aes(x=variable,y=value,group=1)+
  geom_line()

# Jetzt transformieren wir das xy-Koordinatensystem einfach in ein polares Koordinatensystem
# coord_polar()
ggplot(ferrari)+
  aes(x=variable,y=value,group=1)+
  geom_line()+
  coord_polar()

# Fast, die Lücke ist unschön
# wenn wir stattdessen die Linie als Fläche zeichnen (geom_polygon()), sieht es besser aus.
# Wenn wir die Füllfläche leer lassen fill=NA und nur die Linie einfäbren color="black"
# sieht es aus wie eine Linie
ggplot(ferrari)+
  aes(x=variable,y=value,group=1)+
  geom_polygon(color="black",fill=NA)+
  coord_polar()

# Probieren Sie nun die Systemmatik auf den Datensatz mit allen Autos (profil_cars) zu übertragen
# Damit je Auto ein eigenes Profil gezeichnet wird, bietet sich ein facet_wrap an
# Hinweis: mit theme(legend.position = "none") entfernen sie die Legende, die hier überflüssig ist
ggplot(profil_cars)+
  aes(x=variable, y=value,group=car,color=car) +
  geom_polygon(fill=NA) + 
  coord_polar() + facet_wrap(~ car) + 
  theme(axis.text.x = element_text(size = 5))+
  theme(legend.position = "none")

##
# vgl. auch http://www.r-chart.com/2016/10/the-grammar-of-graphics-and-radar-charts.html
# oder als Alternative: https://www.ggplot2-exts.org/ggradar.html



##
## Skript:      6 Datenvisualisierung für Präsentationen ####
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:
## (1) Titel und Untertitel setzen
## (2) X und Y-Achsen-Beschriftung
## (3) Legende anpassen
## (4) Text in Plots platzieren
## (5) Farben anpassen
## (6) Den Look von Grafiken anpassen mit "Themes"
##

# ggplot2 bietet eine Reihe an Möglichkeiten, Graphiken auf einfache Weise zu modifzieren 
# und sie auf diese Weise für ein weiteres Publikum zugänglich zu machen und/oder
# um den Grafiken so einen individuellen Look zu verpassen.
#
# (1) Titel setzen
#
# Ergänzen sie das Benzin-Histogramm mit dem Titel "Benzinverbrauch von Motorfahrzeugen" 
# verwenden Sie dafür labs()
# labs
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title ="Benzinverbrauch von Motorfahrzeugen")

# Ergänzen Sie den Titel mit einem Untertitel (n=32)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  ggtitle("Benzinverbrauch von Motorfahrzeugen",subtitle="n=32")

#
# 2) x- und y-Achsenbeschriftung
#
# Überschreiben Sie die bestehenden Labels mit "Meilen pro Gallone" auf der x-Achse 
# und "Häufigkeiten" auf der y-Achse
# xlab(), ylab()
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(x="Meilen pro Gallone",y="Häufigkeiten")

#
# 3) Legende
#
# Setzen Sie den neuen Titel "Behandlung" mit labs(fill=)
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")

# Die Beschriftung der Legendenausprägungen geschieht über die Modifikation der Skala
# Die Labels lassen sich über scale_fill_discrete(labels=) anpassen
# überschreiben Sie die bestehenden Labels
# indem Sie einen Vektor mit den Bezeichnungen "Kontrollgruppe, "Behandlung 1", "Behandlung 2" übergeben
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")+
  scale_fill_discrete(labels=c("Kontrollgruppe","Behandlung 1","Behandlung 2"))

# Beachten Sie: Die Merkmalsausprägungen auf der x-Achse haben sich nicht verändert
# Dafür müsste scale_x_discrete verwendet werden
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")+
  scale_fill_discrete(labels=c("Kontrollgruppe","Behandlung 1","Behandlung 2"))+
  scale_x_discrete(labels=c("Kontrollgruppe","Behandlung 1","Behandlung 2"))

# Alternativ könnte man über levels() die bestehenden labels im dataframe überschreiben

#
# 4) Anmerkungen in Grafiken
#
# Anmerkungen können verwendet werden um, Zusatzinformationen in der Grafik zu platzieren und
# um so das Publikum auf Besonderheiten hinzuweisen

# Dafür können wir ein geom_text() verwenden
# Beispielsweise können wir mit geom_text() eine Datenwolken in einem Scatterplot beschriften

# Daten - faithful - Old Faithful Geyser Data
help(faithful)
faithful

# Ausgangspunkt ist ein Scatterplot zur Frage:
# Wie lange dauert es bis der alte, treue Geyser ausbricht? 
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()

# Textschnipsel werden über das Koordinatensystem platziert
# geom_text(aes(x=,y=),label="Dieser Text wird angezeigt")
# platzieren Sie zwei Textschnippsel in der Grafik die "Frühstarter" und "Spätzünder" markieren.
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_text(aes(x=50,y=2.5),label="Frühstarter")+
  geom_text(aes(x=67,y=4.5),label="Spätzünder")

# geom_label() funktioniert ähnlich und verziert die Textschnipsel 
# mit einem Rahmen
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_label(aes(x=50,y=2.5),label="Frühstarter")+
  geom_label(aes(x=67,y=4.5),label="Spätzünder")

#
# Die Möglichkeit ausserhalb der Grafik Fussnoten zu setzen ist nützlich um beispielsweise
# einen Hinweis zur Datenquellen zu platzieren
# hier hilft erneut labs() mit der Option: caption= 
# Setzen Sie die Fussnote: "Quelle: Old Faithful Geyser Data"
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_label(aes(x=50,y=2.5),label="Frühstarter")+
  geom_label(aes(x=67,y=4.5),label="Spätzünder")+
  labs(caption="Quelle:Old Faithful Geyser Data")

#
# 5) Farben mit ggplot()
# Es gibt zwei Arten wie ggplot mit Farben arbeitet
# a) Farben direkt definieren
# b) Farben mit Ausprägungen von Variablen verknüpfen

# a) Farben direkt definieren geschieht innerhalb der geoms_
# fill= wird verwendet, um die Farbe von Fläche zu füllen
# colour/color= wird für Linien verwendet

# Färben Sie die Flächen des Histogrammes mit roter Farbe ein ("red")
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="red")

# Färben Sie die Flächen des Histogrammes mit roter Farbe ein
# Verwenden Sie nun jedoch (Hexadecimal RGB-Codes) rot=#FF0000
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="#FF0000")

# Färben Sie die Flächen des Histogrammes mit roter Farbe ein 
# und zeichnen Sie die Rahmen der Balken schwarz
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="#FF0000",colour="black")

#
# b) Farben mit Ausprägungen von Variablen verknüpfen
# Dafür werden Variablen als ästhetische Parameter innerhalb aes() übergeben
# (Das kennen Sie bereits aus dem Skript Plot-Techniken-drei-Variablen)

# Übergeben Sie die Werte der Variable Cultivar als Füllfarbe (fill)
# Alle Versionen führen zum selben Ergebnis
ggplot(cabbage_exp, aes(x=Date,y=Weight,fill=Cultivar))+
  geom_bar(position="dodge",stat="identity")

## EXTRA
# Per default wählt ggplot die standard farbpalette
# Die zu verwendende Farbpalette lässt sich aber auch modifizieren
# Dafür müssen wir die Skala der fill bzw. der colour Variable anpassen
# scale_fill_manual() übernimmt Farbpaletten für Flächen
# scale_colour_manual() übernimmt Farbpaletten fürLinien

# Aber welche Farben wählt man?
# Auf der Seite http://colorbrewer2.org/ können verschiedene Farbkombinationen ausgetestet werden, 
# die über Hexadecimal-Codes an R übergeben werden können
# R ColorBrewer stellt verschiedene Palette zur Verfügung
library(RColorBrewer)

# Alle Farben anzeigen
display.brewer.all()

# Es existieren drei Klassen von Farbskalen, 
# (1) tief-zu-hoch oder sequentielle Farbskala
# (2) kategoriale oder qualitative Farbskala
# (3) polarisierte mit "neutral" in der Mitte oder divergierende Farbsckala

# Eine Farbpalette anzeigen lassen 
# display.brewer.pal(n=Anzahl gewünschter Farben,name="Name der Palette"
display.brewer.pal(n=3,name="Greens")

# speichern Sie die palette mit  der Funktion brewer.pal() in einem eigenen Objekt.
greens<-brewer.pal(n = 3, name = "Greens")

# Und übergeben Sie die Palette mit scale_fill_manual(values=) einer Grafik
ggplot(cabbage_exp, aes(x=Date,y=Weight))+
  geom_bar(aes(fill=Cultivar),position="dodge",stat="identity",color="black")+
  scale_fill_manual(values=greens)

# Oder Sie übergeben eigens ausgewählte Farben als Vector
greens2<-c("#7FFFD4","#66CDAA")

ggplot(cabbage_exp, aes(x=Date,y=Weight))+
  geom_bar(aes(fill=Cultivar),position="dodge",stat="identity",color="black")+
  scale_fill_manual(values=greens2)

# Tipp: Stimmen Sie die Farben ihrer Grafiken auf die Farben des CI ihres Unternehmens ab.

#
# (6) Theme
# Theme-Komponenten kontrollieren alle nicht datenspezfischen optischen Parameter
# Schauen Sie sich die Optionen von theme an
help(theme)
# Jedes einzelne Element der Liste kann modifiziert werden

# Wenn man beispielsweise die Schriftfarbe und Grösse des Titels anpassen möchte,
# steuert man das entsprechende Element(plot.title) an nach Aufruf von theme() an 
# und überschreibt den default-Wert
# Das sieht so aus:
# theme(plot.title=element_text(color="red",size=rel(2))) 
# obiger Code setzt einen roten Titel und verdoppelt die Textgrösse
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title ="Benzinverbrauch von Motorfahrzeugen",subtitle="n=32")+
  theme(plot.title=element_text(color="red",size=rel(2)))

# Dabei muss darauf geachtet werden, dass ein zum Zielelement passendes
# Element übergeben wird
# element_text für Text
# element_line für Linien
# element_rect für Rechtecke
# etc.
# element_blank() löscht das Element

# Verwenden Sie untenstehenden Plot mit weight-Histogrammen gruppiert nach
# Behandlungs- und Kontrollgruppe
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()

# Die Bezeichnung der kategorialen Variable (Unterscheidung von Behandlungs- und Kontrollgruppe)
# ist doppelt geführt:
# Einmal als x-Achsenbeschriftung und einmal bei der Legende.
# Aufgabe: Löschen Sie den Titel der Legende(legend.title)
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  theme(legend.title = element_blank())

#
# Sie können auch ein eigenes theme  mit mehreren Modifikationen definieren
# Aufgabe: Versuchen Sie zu verstehen, was theme_clean macht
theme_clean<-function(base_size=12) {
  theme(
    axis.title=element_blank(),
    axis.text=element_blank(),
    panel.background=element_blank(),
    panel.grid=element_blank(),
    axis.ticks.length=unit(0,"cm")  
  )
}  

## Sie können ein neues Theme aktivieren indem Sie es als Komponente 
## an eine Grafik hängen oder Sie ändern das theme für die aktuelle Session mit theme_set(theme_xy())
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_clean()

## EXTRA
# Neben dem Standard theme (theme_grey) existieren einige weitere vordefinierte Themes,
# die den Look der Graphiken stark verändern.
## theme_classic /theme_bw

# Verwenden Sie das Histogramm mit den mtcars-Daten zum Benzinverbrauch (mpg).
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)

# Plotten Sie das Histogramm mit theme_classic() 
# Das theme_classic ähnelt der Ästehtik der Standard-Plots
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_classic()

# Schwarz/Weiss theme
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_bw()

## Jeffrey B.Arnold stellt im Package ggthemes einige weitere themes zur Verfügung
## https://cran.r-project.org/web/packages/ggthemes/vignettes/ggthemes.html
## Testen Sie das theme des Grossmeisters Edward Tufte (theme_tufte)
library(ggthemes)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_tufte()

## Testen Sie das theme von fivethirtyeight
## http://fivethirtyeight.com/ (Website von Nate Silver)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  theme_fivethirtyeight()



##
## Skript:      7 Grafiken speichern ####
## Studiengang: CAS Datenanalyse FS 16
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Graphiken exportieren
##              (2) Graphiken in PPP oder Word ablegen mit ReporteRs
##

## Während einer Session erstellte Grafiken werden zwischengespeichert.
## Über die Pfeile im Plot-Menü kann durch die Grafiksammlung geblättert werden
## Grafiken lassen sich über die Benutzeroberfläche speichern (Export) oder direkt mittels Syntax
# ggsave ist ein nützliche Funktion um Grafiken zu exportieren

## (1)
# Grafiken erstellen
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="#FF0000",colour="black")+
  labs(title="Benzinverbrauch von Motorfahrzeugen", subtitle="\n (n=32)",
       x="Meilen pro Gallone",y="Häufigkeiten")

## (2)
# ggsave("Titeldergraphik.format") speichert die Grafik ins Arbeitsverzeichniss
# speichern sie die Grafik als pdf
ggsave("Benzinverbrauch von Motorfahrzeugen.pdf")

# Standardmässig wird die letzte Graphik gespeichert. Es ist aber auch möglich, 
# die Graphik in einem Objekt zu speichern und das Objekt für den Export zu verwenden
# ggsave("mtcarshisto.pdf",plot=graphobjekt) 

# Die Endung des Filenames gibt ggpsave den Hinweis in welchem format die Graphik exportiert werden soll
# PDF ist ideal für die weitere Bearbeitung in einem Grafikprogramm
# Auch für print-Dokument sind pdfs gut verwendbar
# png() ist relativ flexibel
# Andere Formate können verwendet werden (bspw. jpeg(),bmp(),tiff(),xfig, postscript())
# Höhe und Breite lassen sich ebenfalls justieren
# Speichern Sie ein pdf mit folgendem Format: width = 15, height = 10, units = "cm")
ggsave("mtcarshisto.pdf",width = 15,height = 10,units = "cm")


## Besondere Möglichkeiten bietet das Package ReporteRs
# Damit ist es möglich Grafiken von R aus in ein Powerpoint oder Word file zu speichern
# Grafiken lassen sich als editierbare Vektorgrafiken speichern
# D.h. Grafiken können im Nachhinein "von Hand" angepasst werden.
# Quelle:
# http://davidgohel.github.io/ReporteRs/

# Testen Sie es aus:
library(ReporteRs)

# Erstellen Sie ein neues PowerPoint-Dokument 
doc <- pptx()

# Betrachten Sie die Funktion pptx(), damit Sie einen Überblick zu den möglichen Folientypen haben
pptx()

# Fügen Sie eine neue TitelSeite zum Objekt doc hinzu
doc<-addSlide(doc, "Title Slide")

# Setzen Sie den Titel "CAS Datenanalyse FS 17"
doc <- addTitle(doc, "CAS Datenanalyse FS 17")
# Fügen Sie eine neue Folienseite hinzu (mit Speichersockel für zwei Inhalte)
doc <- addSlide(doc, "Two Content")

# Beschriften Sie die neue Folie mit dem Titel "Editierbare Vektor Graphik versus (uneditierbares) Raster Format"
doc <- addTitle(doc, "Editierbare Vektor Graphik versus (uneditierbares) Raster Format")

# Speichern Sie einen Boxplot im objekt bp
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group))+
  geom_boxplot()

# Fügen Sie die Boxplot-Grafik als editierbare Graphik hinzu
doc <- addPlot(doc, function() print(bp), vector.graphic = TRUE )

# Fügen Sie die Boxplot Grafik als Raster-Graphik hinzu (deaktivieren Sie die vector.graphic Option)
doc <- addPlot(doc, function() print(bp), vector.graphic =F)

# Speicheren Sie das Dokument ins Arbeitsverzeichnis
writeDoc(doc, file = "editable-ggplot2.pptx")



##
## Skript:      8 - Karten mit ggplot2 ####
## Studiengang  CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung 
## Lernziel:    Auf der Basis von shapefile-Daten Choroplethen-Karten mit ggplot erstellen
##
# Libraries
library(rgdal)    # Damit shapefile Daten geladen werden können
library(rgeos)    # Für fortify
library(maptools) # Für fortify

#if (!require(gpclib)) install.packages("gpclib", type="source") ohne rgeos
#gpclibPermit()

## Geodaten laden (shapefile)
schweiz<-readOGR("GeoDaten Schweiz/shp",layer="g1g15")

# Kleine Inspektion der shapefile-Daten
plot(schweiz)
str(schweiz)
summary(schweiz)
head(schweiz,2)
names(schweiz)

# Das shapefile lässt sich mit fortify() ins klassische dataframe Format pressen
schweiz <- fortify(schweiz, region = "GMDNR")
str(schweiz)


## Karten mit ggplot
# Zeichen sie die Schweiz mit Punkten
ggplot(schweiz)+
  geom_point(aes(x=long,y=lat))

# Vielleicht doch besser mit Polygonen
ggplot(schweiz)+
  geom_polygon(aes(x=long,y=lat,group=group))

# Bringen wir etwas Farbe in die Sache
# Aufgabe: Zeichnen Sie die Schweiz mit roter Fläche (geom_polygon) 
# und weissen Gemeindegrenzen (geom_path)
ggplot(schweiz)+
  aes(x=long,y=lat,group=group)+
  geom_polygon(fill="#FF0000")+
  geom_path(color="#FFFFFF")

# Verwenden Sie zusätzlich untenstehendes theme_clean(), um den "Ballast" los zu werden
theme_clean<-function(base_size=12) {
  require(grid)
  theme_grey(base_size)
  theme(
    axis.title=element_blank(),
    axis.text=element_blank(),
    panel.background=element_blank(),
    panel.grid=element_blank(),
    axis.ticks.length=unit(0,"cm"),
    plot.margin=unit(c(0,0,0,0),"lines"),
    complete=TRUE
  )
}

# Et voilà
ggplot(schweiz) + 
  aes(long,lat, group=group)+
  geom_polygon(fill="#FF0000")+
  geom_path(color="#FFFFFF")+
  theme_clean()

# Die Projektion ist nicht ideal, probieren Sie +coord_equal()
ggplot(schweiz) + 
  aes(long,lat, group=group)+
  geom_polygon(fill="#FF0000")+
  geom_path(color="#FFFFFF")+
  theme_clean()+
  coord_equal()

# Lasst uns eine Choroplethen-Karte zeichnen!
## Wohnen junge und alte Menschen innerhalb der Schweiz in unterschiedlichen Regionen?
# Zuerst müssen wir die Shapefile-Daten mit Kennzahlen der Gemeinden kombinieren 
# (Es sind jene aus der Open-Data Übung)
# Gemeindedaten Regionalporträt der Schweiz laden
gemeindedaten<-read.csv("gemeindedaten.csv")

# Daten zusammenführen
schweiz$id<-as.numeric(schweiz$id)
schweiz<-arrange(schweiz,id) 
schweiz.df<-left_join(schweiz,gemeindedaten,by=c("id"="bfsid"))
schweiz.df<-arrange(schweiz.df,as.numeric(schweiz.df$order))

# Alternatives Datenladen (aufbereitete Daten von Moodle runterladen)
#schweiz.df<-read.csv("schweizGeo.csv")

# Die folgende Grafik zeigt eine Choroplethen-Karte mit dem Anteil 0-19-Jähriger
# je Gemeinde. Je dünkler die Farbe desto tiefer der Anteil
ggplot(schweiz.df) + 
  aes(long,lat, group=group,fill=alter_0_19) + 
  geom_polygon()+
  geom_path(color="black") +
  coord_equal() +
  labs(fill="Altersgruppe \n 0 bis 19 Jahre \n (in %)")+
  theme_clean()

## Aufgabe: Finden Sie eine passende farbliche Darstellung zur Darstellung der räumlichen Unterschiede 
# Modifzieren Sie dafür die Füllfarb(n)
# Verwenden Sie  scale_fill_distiller()
# Dies ist die colorbrewer Umsetzung für kontinuierliche Variablen
# scale_fill_distiller(typ=seq) = sequentielle Skala
# scale_fill_distiller(typ=div) = divergierende Skala
# scale_fill_distiller(typ=qual) = qualitative Skala
# Auf http://colorbrewer2.org/ können Sie die Farben vorab testen
# Hilfreich ist auch dieser Link:
# http://ggplot2.tidyverse.org/reference/scale_brewer.html

# Achtung: Die Colorbrewer Farbsets sind für kategoriale Variablen optimiert.
# Für kontinuierliche Variablen eignen sich auch
# scale_fill_gradient()  = sequentielle Skala
# scale_fill_gradient2() = divergierende Skala
# und eigene Farben

# Die Lösung verwendet eine divergierende Farbskala mit einem neutralen Farbwert in der Mitte
# und roter Einfärbung für unterdurchschnittliche Werte sowie grüner Einfärbung für überdurchschnittliche Werte
# mit Hilfe von scale_fill_gradient2() 
ggplot(schweiz.df) + 
  aes(long,lat, group=group,fill=alter_0_19) + 
  geom_polygon()+
  geom_path(color="black") +
  coord_equal() +
  labs(fill="Altersgruppe \n 0 bis 19 Jahre \n (in %)")+
  theme_clean()+
  scale_fill_gradient2(low = "red", mid="grey", high = "#00FF77", midpoint = median(schweiz.df$alter_0_19, na.rm = T))

## Aufgabe:
# Wählen sie einen Kanton und untersuchen Sie den Anteil Kinder und Jugendlicher je Gemeinde
# im Vergleich zu den nationalen Werten
# Tipp: Arbeiten Sie mit den BFS-ID's um die Darstelllung der Karte einzugrenzen.
# https://de.wikipedia.org/wiki/Gemeindenummer
head(schweiz.df)
ggplot(schweiz.df %>% filter(kantone == "ZH")) + 
  aes(long,lat, group=group,fill=alter_0_19) + 
  geom_polygon()+
  geom_path(color="black") +
  coord_equal() +
  labs(fill="Altersgruppe\n0 bis 19 Jahre\n(in %)")+
  theme_clean()+
  scale_fill_gradient2(low = "red", mid="grey", high = "#00FF77", midpoint = median(schweiz.df$alter_0_19, na.rm = T))



##
## Skript:      9 - Karten mit leaflet ####
## Studiengang  CAS Datenanalyse 16/17
## Modul:       Graphische Datenexploration und Datenvisualisierung 
## Lernziel:    Mit Hilfe von leaflet einfache interaktive Punktekarten zeichnen
##
##
# Libraries
library(leaflet)

# leaflet rufen sie mit der Funktion leaflet() auf
# Mit dem Pipe-Operator %>% werden Karten komponentenweise aufgebaut
# Damit eine Karte erscheint, braucht es sogenannte Tiles. addTiles() fügt die OpenStreetMap hinzu
# 
# Ausführliche Beschreibungen der leaflet Funktionen finden Sie hier:
# https://rstudio.github.io/leaflet/

## Aufgabe: Zentrieren Sie die Karte auf Bern und platzieren Sie ein Popup-Marker 
# mit der Aufschrift "Hallo Bern" mit Hilfe von addMarkers()
# Tipp: nutzen Sie http://de.mygeoposition.com/

# Bern
leaflet() %>%
  addTiles() %>%
  addMarkers(lng=8.5644800, lat=47.2949280, popup="Hallo Thalwil!") 

# Ersetzen sie die standardmässig erscheinende OpenStreetMap Karte mit Hilfe von addProviderTiles()... 

# ...mit der Stamen.Toner-Karte  
leaflet() %>%
  addTiles() %>%
  addMarkers(lng=8.5644800, lat=47.2949280, popup="Hallo Thalwil!") %>%
  addProviderTiles("Stamen.Toner")

# ...mit der CartoDB.Positron
leaflet() %>%
  addTiles() %>%
  addMarkers(lng=8.5644800, lat=47.2949280, popup="Hallo Thalwil!") %>%
  addProviderTiles("CartoDB.Positron")

## Nun versuchen wir die John Snow Karte nachzubauen
# Die Daten dazu finden Sie in Robin's Blog
# http://blog.rtwilson.com/john-snows-cholera-data-in-more-formats/
# oder auf Moodle

# Laden Sie die Daten
snowdf <- read.csv("SnowGIS/Snowdf.csv")   

# Zuerst zentrieren wir die Karte auf den relevanten Abschnitt (Soho in London)
m <- leaflet() %>% 
  addTiles() %>% 
  fitBounds(-.141,  51.511, -.133, 51.516)
m

# Nun zeichnen wir die Toten als Kreise ein
# Verwenden Sie dafür die AddCircles()-Funktion
# Sie benötigt im Minimum Angaben zu Höhen(coords.x1) und Breitengrade(coords.x2)
# Experimentieren Sie mit den optischen Parametern radius, opacity und col
# Um das Ergebnis zu optimieren
m <- m %>% addCircles(lng=snowdf$coords.x1,lat=snowdf$coords.x2, radius = 5,opacity=0.8,col="red")
m

# Ergänzen Sie die Karte mit einem Pop-Up-Marker, der auf die Pumpe verweist, an der die Cholera-Epidemie ausbrach
# Die Koordinaten sind: 
# lng=-0.1366679, lat=51.51334
# Verlinken Sie gleichzeitig den Wikipedia-Eintrag zur Cholero-Epidemie in der Broad-Street
# https://en.wikipedia.org/wiki/1854_Broad_Street_cholera_outbreak'>Wikipedia Eintrag zu Broad Street Cholera
m <- m %>% addMarkers(lng=-0.1366679, lat=51.51334, popup = "pump location")
m

# Speichern lässt sich die Karte über die Export-Funktion im Viewer.
# Die Karte lässt sich als html-Objekt speichern, d.h. sie können sie mit einem Browser öffnen
# und die Karte so auf ihrer Website einbinden



# Skript 10: Arbeiten mit plotly und shiny ####

# plotly
library(ggplot2)
library(plotly)
d <- diamonds[sample(nrow(diamonds), 1000), ]
p <- ggplot(data = d, aes(x = carat, y = price)) +
  geom_point(size = 4) +
  geom_smooth(aes(colour = cut, fill = cut))+
  theme_bw()+
  facet_wrap(~ cut)
p
ggplotly(p)

# #Shiny
# library(shiny)
# runExample("01_hello")
# runApp("App01", display.mode = "showcase")