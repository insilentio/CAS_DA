################################################################
## Skript:      7 Grafiken speichern
## Studiengang: CAS Datenanalyse FS 16
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   (1) Graphiken exportieren
##              (2) Graphiken in PPP oder Word ablegen mit ReporteRs
##
######################################

## library
library(ggplot2)


## Während einer Session erstellte Grafiken werden zwischengespeichert.
## Über die Pfeile im Plot-Menü kann durch die Grafiksammlung geblättert werden

## Grafiken lassen sich über die Benutzeroberfläche speichern (Export)
## oder direkt mittels Syntax

#####
# ggsave ist ein nützliche Funktion um Grafiken zu exportieren

## (1)
# Grafiken erstellen

ggplot(mtcars, aes(x=mpg))+
  geom_histogram(binwidth=2,fill="#FF0000",colour="black")+
  labs(title="Benzinverbrauch von Motorfahrzeugen", subtitle="\n (n=32)",
       x="Meilen pro Gallone",y="Häufigkeiten")

## (2)
# ggsave("Titeldergraphik.format") speichert die Grafik ins Arbeitsverzeichniss
ggsave("mtcarshisto.pdf")


# Standardmässig wird die letzte Graphik gespeichert. Es ist aber auch möglich, 
# die Graphik in einem Objekt zu speichern und das Objekt für den Export zu verwenden
# ggsave("mtcarshisto.pdf",plot=graphobjekt) 


# Die Endung des Filenames gibt ggpsave den Hinweis in welchem format die Graphik exportiert werden soll
# PDF ist ideal für die weitere Bearbeitung in einem Grafikprogramm
# Auch für print-Dokument sind pdfs gut verwendbar
# png() ist relativ flexibel
## Andere Formate können verwendet werden (bspw. jpeg(),bmp(),tiff(),xfig, postscript())

## Höhe und Breite lassen sich ebenfalls justieren
## Speichern Sie ein pdf mit folgendem Format: width = 15, height = 10, units = "cm")

ggsave("mtcarshisto.pdf",width = 15, height = 10, units = "cm")



### Besondere Möglichkeiten bietet das Package ReporteRs
### Damit ist es möglich Grafiken von R aus in ein Powerpoint oder Word file zu speichern
### Grafiken lassen sich als editierbare Vektorgrafiken speichern
### D.h. Grafiken können im Nachhinein "von Hand" angepasst werden.
### Quelle:
### http://davidgohel.github.io/ReporteRs/


## Testen Sie es aus:

## library
library(ReporteRs)


# Erstelle Sie ein PowerPoint-Dokument (im Arbeitsverzeichniss)
doc <- pptx()

# Betrachten Sie die Funktion pptx(), damit Sie einen Überblick zu den möglichen Folientypen haben
pptx()

# Fügen Sie eine neue TitelSeite zum Objekt doc hinzu
doc<-addSlide(doc, "Title Slide")

# Setzen Sie den Titel "CAS Datenanalyse FS 2017"
doc<-addTitle(doc, "CAS Datenanalyse FS 017")

# Fügen Sie eine neue Folienseite hinzu (mit Speichersockel für zwei Inhalte)
doc <- addSlide(doc, "Two Content")

# Beschriften Sie die neue Folie mit dem Titel "Editierbare Vektor Graphik versus (uneditierbares) Raster Format"
doc<- addTitle(doc, "Editierbare Vektor Graphik versus (uneditierbares) Raster Format" )

# Speichern Sie einen Boxplot im objekt bp
bp <- ggplot(data=PlantGrowth, aes(x=group, y=weight, fill=group))+
  geom_boxplot()

# Fügen Sie die Boxplot-Grafik als editierbare Vektor-Graphik hinzu
doc <- addPlot(doc, function() print(bp), vector.graphic = TRUE)

# Fügen Sie die Boxplot Grafik als Raster-Graphik hinzu
doc <- addPlot(doc, function() print(bp), vector.graphic = FALSE )

# Speichere das Dokument ins Arbeitsverzeichnis
writeDoc(doc, file = "editable-ggplot2.pptx")




