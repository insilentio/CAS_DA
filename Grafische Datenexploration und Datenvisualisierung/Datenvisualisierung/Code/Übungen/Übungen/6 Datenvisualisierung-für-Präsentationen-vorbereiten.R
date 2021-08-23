################################################################
## Skript:      6 Datenvisualisierung für Präsentationen
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
######################################

## Libraries
library(ggplot2)

####
# ggplot2 bietet eine Reihe an Möglichkeiten, Graphiken auf einfache Weise zu modifzieren 
# und sie auf diese Weise für ein weiteres Publikum zugänglich zu machen und/oder
# um den Grafiken so einen individuellen Look zu verpassen.

#######################
# (1) Titel setzen
###################

# Ergänzen sie das Benzin-Histogramm mit dem Titel "Benzinverbrauch von Motorfahrzeugen" 
# verwenden Sie dafür labs()

# labs
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title = "Benzinverbrauch von Motorfahrzeugen")

# Ergänzen Sie den Titel mit einem Untertitel (n=32)
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title = "Benzinverbrauch von Motorfahrzeugen", subtitle = "n=32")

#######################
# 2) x- und y-Achsenbeschriftung
###################

# Überschreiben Sie die bestehenden Labels mit "Meilen pro Gallone" auf der x-Achse 
# und "Häufigkeiten" auf der y-Achse
# xlab(), ylab()
ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2)+
  labs(title = "Benzinverbrauch von Motorfahrzeugen", subtitle = "n=32")+
  labs(x="Meilen pro Gallone",y= "Häufigkeiten")

#############
# 3) Legende
######

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
  scale_fill_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))

# Beachten Sie: Die Merkmalsausprägungen auf der x-Achse haben sich nicht verändert
# Dafür müsste scale_x_discrete verwendet werden

ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  labs(fill="Behandlung")+
  scale_fill_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))+
  scale_x_discrete(labels=c("Kontrollgruppe", "Behandlung 1", "Behandlung 2"))

# Alternativ könnte man über levels() die bestehenden labels im dataframe überschreiben
levels(PlantGrowth$group) = c("Kontrollgruppe", "Behandlung 1", "Behandlung 2")

#######################
# 4) Anmerkungen in Grafiken
###################

# Anmerkungen können verwendet werden um, 
# Zusatzinformationen in der Grafik zu platzieren und
# um so das Publikum auf Besonderheiten hinzuweisen

# Dafür können wir ein geom_text() verwenden
# Beispielsweise können wir mit geom_text()
# eine Datenwolken in einem Scatterplot beschriften


# Daten - faithful - Old Faithful Geyser Data
help(faithful)
faithful

# Ausgangspunkt ist ein Scatterplot zur Frage:
# Wie lange dauert es bis der alte, treue Geyser ausbricht? 
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()

# Textschnippsel werden über das Koordinatensystem platziert
# geom_text(aes(x=,y=),label="Dieser Text wird angezeigt")
# platzieren Sie zwei Textschnippsel in der Grafik die "Frühstarter" und "Spätzünder" markieren.
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_text(aes(x=50,y=2.8), label = "Frühstarter")+
  geom_text(aes(x=90,y=3.8), label = "Spätzünder")

# geom_label() funktioniert ähnlich und verziert die Textschnippsel 
# mit einem Rahmen
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_label(aes(x=50,y=2.8), label = "Frühstarter")+
  geom_label(aes(x=90,y=3.8), label = "Spätzünder")


##
# Die Möglichkeit ausserhalb der Grafik Fussnoten zu setzen ist nützlich um beispielsweise
# einen Hinweis zur Datenquellen zu platzieren
# hier hilft erneut labs() mit der Option: caption= 
# Setzen Sie die Fussnote: "Quelle: Old Faithful Geyser Data"
ggplot(faithful,aes(x=waiting,y=eruptions))+
  geom_point()+
  geom_label(aes(x=50,y=2.8), label = "Frühstarter")+
  geom_label(aes(x=90,y=3.8), label = "Spätzünder")+
  labs(caption="Quelle: Old Faithful Geyser Data")

#######################
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


#######
# b) Farben mit Ausprägungen von Variablen verknüpfen
# Dafür werden Variablen als ästhetische Parameter innerhalb aes() übergeben
# (Das kennen Sie bereits aus dem Skript Plot-Techniken-drei-Variablen)

# Übergeben Sie die Variable Cultivar als Füllfarbe (fill)

library(gcookbook)

# Übergeben Sie die Werte der Variable Cultivar als Füllfarbe (fill)
# Alle Versionen führen zum selben Ergebnis
ggplot(cabbage_exp, aes(x=Date,y=Weight,fill=Cultivar))+
  geom_bar(position="dodge",stat="identity")


######
# (6) Themes
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
# Löschen Sie den Titel der Legende(legend.title)
ggplot(PlantGrowth,aes(x=group,y=weight,fill=group))+
  geom_boxplot()+
  theme(legend.title = element_blank())


####
# Sie können auch ein eigenes theme  mit mehreren Modifikationen definieren
### Aufgabe: Versuchen Sie zu verstehen, 
# was theme_clean macht

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

