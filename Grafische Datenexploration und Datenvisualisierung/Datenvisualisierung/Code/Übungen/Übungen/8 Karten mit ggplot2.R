################################################################
## Skript:      8 - Karten mit ggplot2
## Studiengang  CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung 
## Lernziel:    Auf der Basis von shapefile-Daten Choroplethen-Karten mit ggplot erstellen
##
####################################


# Libraries
library(ggplot2)  # Für die Darstellung von Karten
library(rgdal)    # Damit shapefile Daten geladen werden können
library(dplyr)    # Für die Datenaufbereitung
library(rgeos)    # Für fortify
library(maptools) # Für fortify

#if (!require(gpclib)) install.packages("gpclib", type="source") ohne rgeos
#gpclibPermit()


############
# Geodaten laden (shapefile)
setwd("Arbeitsverzeichnis")
schweiz<-readOGR("shp",layer="g1g17")


# Kleine Inspektion der shapefile-Daten
plot(schweiz)
str(schweiz)
summary(schweiz)
head(schweiz,2)
names(schweiz)

# Das shapefile lässt sich mit fortify() ins klassische dataframe Format pressen
schweiz <- fortify(schweiz, region = "GMDNR")
str(schweiz)


############
# Karten mit ggplot

# Zeichen sie die Schweiz mit Punkten
ggplot(schweiz)+
  geom_point(aes(x=long,y=lat))

# Vielleicht doch besser mit Polygonen
ggplot(schweiz)+
  geom_polygon(aes(x=long,y=lat,group=group))

######
# Bringen wir etwas Farbe in die Sache
# Aufgabe: Zeichnen Sie die Schweiz mit roter Fläche (geom_polygon) 
# und weissen Gemeindegrenzen (geom_path)
ggplot(schweiz)+
  aes(x=long,y=lat,group=group)+
  geom_polygon(fill="#FF0000")+
  geom_path(color="#FFFFFF")


# Verwenden Sie zusätzlich untenstehendes theme_clean()
# um den "Balast" los zu werden
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

# Die Projektion ist nicht ideal
# probieren Sie +coord_equal()
ggplot(schweiz) + 
  aes(long,lat, group=group)+
  geom_polygon(fill="#FF0000")+
  geom_path(color="#FFFFFF")+
  theme_clean()+
  coord_equal()



#####################
# Lasst uns eine Choroplethen-Karte zeichnen!

## Wohnen junge und alte Menschen innerhalb der Schweiz in unterschiedlichen Regionen?
##


###############
# Zuerst müssen wir die Shapefile-Daten mit Kennzahlen der Gemeinden kombinieren 
# (Es sind jene aus der Open-Data Übung)

##
# Gemeindedaten Regionalporträit der Schweiz laden
gemeindedaten<-read.csv("gemeindedaten.csv")



##
# Daten zusammenführen
schweiz$id<-as.numeric(schweiz$id)
schweiz<-arrange(schweiz,id) 
schweiz.df<-left_join(schweiz,gemeindedaten,by=c("id"="bfsid"))
schweiz.df<-arrange(schweiz.df,as.numeric(schweiz.df$order))


# Alternatives Datenladen (aufbereitete Daten von Moodle runterladen)
schweiz.df<-read.csv("schweizGeo.csv")



# Die folgende Grafik zeigt eine Choroplethen-Karte mit dem Anteil 0-19-Jähriger
# je Gemeinde. Je dünkler die Farbe desto tiefer der Anteil
ggplot(schweiz.df) + 
  aes(long,lat, group=group,fill=alter_0_19) + 
  geom_polygon()+
  geom_path(color="black") +
  coord_equal() +
  labs(fill="Altersgruppe \n 0 bis 19 Jahre \n (in %)")+
  theme_clean()

# Aufgabe: Finden Sie eine passende farbliche Darstellung 
# zu Darstellung der räumlichen Unterschiede 

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


####
# Aufgabe:
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




