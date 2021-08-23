################################################################
## Skript:      4 Plot-Techniken-drei-Variablen
## Studiengang: CAS Datenanalyse FS 17
## Modul:       Graphische Datenexploration und Datenvisualisierung  
## Lernziele:   Techniken der Datenexploration mit R - drei Variablen
##
####################################

##
# Libraries
library(ggplot2)
library(vcd)
library(dplyr)


###
# Mosaic-Plot 
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

## Es wird ersichtlich, dass mehr Leute für ein Studium abgewiesen(rejected) als zugelassen (admitted) wurden
## und das bei der Gruppe der zugelassen mehr Männer vertreten sind. Werden Frauen diskriminiert? (deshalb wurde geklagt)
## Der Vergleich über die Departement ist so jedoch schwierig.


# Mosaik-Plot mit Zulassung, Geschlecht und Departement
mosaic(~Admit+Gender+Dept,data=UCBAdmissions)

## Was wird ersichtlich, wenn wir zuerst nach Departement splitten?
mosaic(~Dept+Gender+Admit,data=UCBAdmissions)



## Zusätzliche optische Unterstützung gibt es mit den Optionen highlighting und direction
## Highlighting hebt Ausprägungen einer Variable farblich hervor
## direction gibt an in welche Richtung die Splitt's erfolgen v=vertical, h=horizontal
## Heben Sie die Geschlechter farblich hervor mit folgendem Code-Schnippsel
## highlighting = "Gender",highlighting_fill=c("lightblue","pink"), direction=c("v","v","h")
## Testen Sie die Darstellungsmöglichkeiten indem Sie die Parameter "v" und "h" austauschen.

mosaic(~Dept+Gender+Admit,data=UCBAdmissions,
       highlighting = "Gender",highlighting_fill=c("lightblue","pink"),
       direction=c("v","v","h"))



## Fällt Ihnen etwas auf bezüglich Zulassung nach Geschlecht?




#################### 
# Linienplots mit einer Gruppen-Variable ergänzt
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


######
# Barplots mit drei Variablen
# 2 kategoriale Variablen und eine metrische Variable (Outcome)
# Wenn theoretische begründete Vorstellungen zu Ursache und Wirkungszusammenhängen bestehen. 
# Bietet sich folgende Anordnung an: x-Achse (erklärende Variable), Y-Achse (zu erklärende Variable),
# Farb-Unterschiede für Gruppen (Drittvariablen)

# Daten - Data from a cabbage field trial (Summary)
library(gcookbook)
help("cabbage_exp")

# Erstellen Sie einen Barplot, der auf der X-Achse die Information zum Datum enthält, 
# an welchem der Versuchs-Kohl gepflanzt wurde (Date), das mittlere Gewicht auf der y-Achse 
# sowie die unterschiedlichen Kultivierungsmethoden (cultivar) farblich aufzeigt (fill=)
# Hat die Kultivierungsmethode einen Einfluss auf das mittlere Gewicht der untersuchten Kohle?
ggplot(cabbage_exp, aes(x=Date,y=Weight,fill=Cultivar))+
  geom_bar(position="dodge",stat="identity")

# Ohne position="doge" wird ein gestapelter Barplot gezeigt.
# Für den Vergleich der Kultivierungsmethoden sind die getrennten Balken aber effektiver


#########
# Scatterplots mit 3 Variablen
# (2 kontinuierliche Variablen) und eine Gruppenvariable 


# Benötigte Library (für Daten)
library(gcookbook)

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


####
# Sind Plots mit drei kontinuierlichen Variablen möglich?
# Klar. Hier kommt der Der Bubble-Chart/Ballon-Chart


## Daten: countries - Health and economic data about countries around the world from 1960-2010
library(gcookbook)
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

