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


#########
# Ein Kuchendiagram


# Zeichnen Sie ein Kuchendiagram mit der konventionellen Plot Funktion
cylinder<-table(mtcars$cyl)
pie(cylinder)


## In ggplot gibt es keine direkte Umsetzung eines Kuchendiagrammes, weil Hadley Wickham, wie viele andere Statistiker
## glaubt, dass Kuchendiagramme ungenau sind
## Mit ein bisschen Arbeit lässt sich jedoch ein Kuchendiagramm über einen Barchart und der 
## einem polaren Koordinaten-System -> coord_polar() erstellen

## vgl. http://www.r-chart.com/2010/07/pie-charts-in-ggplot2.html
## oder http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization





###############
# Histogramme
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
# 




#########
# Boxplot
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



########
# Wrap-Up: Funktionsweise von ggplot2
######
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








