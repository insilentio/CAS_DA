################################################################
## Skript:      3 Plot-Techniken-zwei-Variablen
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziel:    1) Bivariate Techniken der Datenexploration mit R oder Visualisierungen mit zwei Variablen
##              2) Erstellen von geläufigen Diagrammen: Liniendiagrammen, gruppierte Box- und barplots und Scatterplots
##              3) Weitere Elemente von ggplot kennenlernen: statistics, themes und scales
##
####################################

## Libraries
library(ggplot2)
library(dplyr)

#################
# Liniendiagramme
####
# Geeignet für ein ordinales Merkmal (viele Ausprägungen 5+) auf der x-Achse  
# und ein metrisches Merkmal auf der y-Achse (Bsp. eine Zeitreihe)

# Daten- BOD > Biochemical Oxygen Demand
# Schauen Sie sich den Datensatz an. Was wurde mit dem Datensatz untersucht? Was wurde gemessen?
help(BOD)

# Wie entwickelt sich die biochemische Sauerstoff-Nachfrage von Wasser über die Zeit?
# Erstellen Sie ein Liniendiagram mit der Zeit (Time) auf der x-Achse und der Sauerstoff-Nachfrage (demand) auf der y-Achse
plot(BOD$Time,BOD$demand, type = "l")
# ggplot zeichnet Linien mit geom_line()
ggplot(BOD)+
  aes(x=Time, y=demand)+
  geom_line()

# Fügen Sie der Grafik ebenfalls die Messpunkte hinzu (mit +geom_point)
# Nur so wird ersichtlich, für welche Zeitpunkte tatsächlich Messungen vorliegen.
# Sind für alle Zeitpunkte Messdaten vorhanden?
ggplot(BOD)+
  aes(x=Time, y=demand)+
  geom_line()+
  geom_point()

############
# Balkendiagramme 
#####

# Geeignet für ein kontinuierliches Merkmal mit wenig Ausprägungen oder ein kategoriales Merkmal auf der x-Achse
# und einem kontinuierlichem Merkmal auf der y-Achse (Bpsw. Gruppenvergleiche für wenige Beobachtungen)

# Wie sieht der BOD-Line-Plot von oben (x=Time, y=demand) mit Balken aus?
ggplot(BOD)+
  aes(x=Time, y=demand)+
  geom_bar(stat = "identity")

# Achtung: Die Standardeinstellung von geom_bar() ist stat="count", d.h. die Höhe der Balken wird entsprechend der Anzahl Ausprägungen je Kategorie gezeichnet. 
help(geom_bar)
# Das passt prima für eine Häufigkeitsauszählung, nicht jedoch für die Anwendung hier.
# Im vorliegenden Fall soll die Länge der Balken entsprechend der beobachtet Werte gezeichnet werden. 
# Überschreiben Sie den Standardparameter mit dem Zusatz stat="identity"


############
# EXTRA zu Balkendiagramme 
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
tophit<-tophitters2001[tophitters2001$avg>0.30,]

# Erstellen Sie nochmals einen Punkte-Plot
ggplot(tophit, aes(x=avg,y=name)) +
  geom_point()

# Jetzt ordnen wir die Namen (mit reorder())
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_point()


# Und noch ein bisschen Zusatzästhetik.
# Voilà ein Cleveland-Dot-Plot 
ggplot(tophit, aes(x=avg,y=reorder(name,avg))) +
  geom_segment(aes(yend=name),xend=0, colour="grey50")+  #xend ausserhalb aesthetics, wird dann nicht für Skala verwendet
  geom_point(size=4)+
  labs(x="Mittlere Trefferquote je Versuch",y="")+
  theme_bw()+
  theme(panel.grid.major.y=element_blank())

# EXTRA 
############

######
# Boxplots 

# Sind besonders für Gruppenvergleiche von metrischen Variablen mit vielen Beobachtungen geeignet
# Nutzen Sie erneut den Auto-Datensatz (mtcars)
# Übergeben Sie die Zahl der Zylinder(cyl) als x-Wert und die PS(hp) als Y-Wert
ggplot(mtcars)+
  aes(x=factor(cyl),y=hp)+
  geom_boxplot()

# Beeinflusst die Zahl der Zylinder die PS?


###################
# Streudiagram / Scatterplot
#####

## 
# Geeignet zur Darstellung beobachteter Wertepaare zweier metrischer Variablen

# Benötigte Libraries (für die Daten)
library(gcookbook)

# Daten (heightweight): Height and weight of schoolchildren
# Machen Sie sich mit den Daten vertraut. Welche Informationen beinhaltet der Datensatz?
?heightweight
head(heightweight)

# Erstellen Sie einen Scatterplot mit dem Alter der Schulkinder(ageYear) auf der X-Achse 
# und dem Grösse (heightIn) auf der Y-Achse
ggplot(heightweight)+
  aes(x=ageYear,y=heightIn)+
  geom_point()
# Frage: Gibt es einen Zusammenhang zwischen dem Alter und der Grösse der Schulkinder?

# Der Zusammenhang kann  mit einer Regressionslinie veranschauchlicht werden
# Die Regressionslinie zeigt den linearen mittlere Veränderung der Grösse in Abhängigkeit des Alters
# +stat_smooth(method=lm, se=FALSE)
ggplot(heightweight)+
  aes(x=ageYear,y=heightIn)+
  geom_point()+
  stat_smooth(method = lm, se=F)+
#  coord_polar()




# EXTRA zu Scatterplot
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
  stat_bin2d(bins=50)

# Die verwendete Farbskale können wir überschreiben mit einem scale_fill_gradient-Element
ggplot(diamonds, aes(x=carat,y=price))+
  stat_bin2d(bins=50)+
  scale_fill_gradient(low="lightblue",high="red",limits=c(0,6000))+
#  scale_x_continuous(limits = c(0,5))+
#  scale_y_log10()
