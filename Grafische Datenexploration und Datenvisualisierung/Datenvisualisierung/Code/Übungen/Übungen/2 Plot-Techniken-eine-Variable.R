################################################################
## Skript:      2 Plot-Techniken-eine-Variable
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Univarite Techniken der Datenexploration mit R
##              (2) Unterschiede konventionelle Plot-Methode und ggplot erkennen 
##              (3) Kernelemente von ggplot kennenlernen (daten, aes und geom_)
##      
####################################

## Libraries
library(ggplot2)

###
# Daten - Motor Trend Car Road Tests - mtcars
# Führen Sie eine erste Datenbegutachtung durch, damit Sie eine grundlegende Vorstellung
# der verwendeten Daten haben
help(mtcars)

###############
# Balken-Diagramme

# Erstellen Sie ein Balken-Diagramm für die Zylinderzahl mit der konventionellen Plot Funktion
# Man beachte: es ist nötig, eine Häufigkeitsauszählung einzuweben
barplot(table(mtcars$cyl))

# Erstellen Sie ein Balken-Diagramm mit ggplot 
# Übergeben Sie die Varialbe cyl einmal als kategoriales Merkmal (factor) 
# und einmal als nummerisches Merkmal (numeric)
ggplot(mtcars,aes(x=as.factor(cyl)))+geom_bar()
ggplot(mtcars,aes(x=as.numeric(cyl)))+geom_bar()

###############
# Kuchendiagramme

# Zeichnen Sie ein Kuchendiagram mit der konventionellen Plot Funktion
# Auch hier ist nötig, eine Häufigkeitsauszählung einzuweben
pie(table(mtcars$cyl))


## In ggplot gibt es keine direkte Umsetzung eines Kuchendiagrammes, weil Hadley Wickham, wie viele andere Statistiker
## glaubt, dass Kuchendiagramme ungenau sind
## Mit ein bisschen Arbeit lässt sich jedoch ein Kuchendiagramm über einen Barchart und der Funktion coord_polar()
## erstellen

## vgl. http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html
## oder http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization

ggplot(mtcars,aes(x=cyl))+geom_bar()



###############
# Histogramme
# http://www.r-bloggers.com/how-to-make-a-histogram-with-basic-r/

# Untersuchen Sie die Verteilung der Variable mpg (miles per gallon)
# Die Variable gibt Auskunft zum Benzinverbrauch
# (eine Meile ~1.6 KM, eine Gallone ~ 3.8 liter)

# Erstellen Sie ein Histogramm mit der konventionellen Plot Funktion
# In welche Kategorie fallen am meisten Fahrzeuge?
hist(mtcars$mpg)

# Verändern Sie die Zahl der Klassen über die Option breaks 
# Wie sieht das Histogram aus mit 5,7,10 Unterteilungen aus?
# Ändert sich etwas in Bezug auf die Aussage, welch Kategorie von Benzinverbrauch am häufigsten vorkommt?
hist(mtcars$mpg, breaks = 10)


# Erstellen Sie ein Histogramm mit ggplot
# Wie geht ggplot bei der Bestimmung der Breite der Intervalle vor?
ggplot(mtcars,aes(x=mpg))+geom_histogram()
# Mit ggplot lässt sich die Breite der Klassen über "binwidth" steuern 
# Justieren Sie die Intervallbreite so, dass sie ungefähr der Einteilung von breaks=10 mit der konvetionellen Plot-Funktion entspricht.
ggplot(mtcars,aes(x=mpg))+geom_histogram(binwidth = 2.5)


###############
# Boxplot
# 

# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit der konventionellen Plotfunktion
boxplot(mtcars$hp)

# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit ggplot
# Hinweis: geom_boxplot braucht eine Spezifikation für das x-aes (bspw. x="")
ggplot(mtcars,aes(x="",y=hp))+geom_boxplot()
# Gibt es ein Auto, dass Aufgrund der Daten als Ausreiser bezeichnet werden kann? Um welches Auto handelt es sich?
mtcars[mtcars$hp > 300,]
ggplot(data=mtcars, aes(x="boxplot",y=hp))+
  geom_boxplot()+
  geom_label(data=mtcars[mtcars$hp > 300,],label=rownames(mtcars[mtcars$hp > 300,]))

#was passiert hier?
ggplot(data=mtcars, aes(x=factor(""),y=disp))+
  geom_boxplot(aes(x=factor(""),y=hp))+
  geom_point()
