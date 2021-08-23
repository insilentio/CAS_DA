library(corrplot)
library(ggplot2)
library(dplyr)
library(reshape2)
library(vcd)

#1. Laden des Datensatzes ####
gemeindedaten<-read.csv("gemeindedaten.csv")

#2. Übersicht verschaffen ####
names(gemeindedaten)
str(gemeindedaten)
head(gemeindedaten)
summary(gemeindedaten)

#3. NAs und Faktoren ####
gemeindedaten$polit_pda <- as.numeric(as.character(gemeindedaten$polit_pda))

#4. Fragen ####
#Anzahl Gemeinden
nrow(gemeindedaten)

#mittlere Einwohnerzahl
mean(gemeindedaten$bev_total)
summary(gemeindedaten$bev_total)

#Einwohnerzahl max
gemeindedaten %>%
  top_n(n = 1, wt= bev_total) %>%
  select(gmdename, bev_total)

#Einwohnerzahl min
gemeindedaten %>%
  top_n(n = -1, wt= bev_total) %>%
  select(gmdename, bev_total)

#Grafiken
#5. In welchem Kanton gibt es am meisten Gemeinden? In welchem am wenigsten? ####
ggplot(gemeindedaten)+
  aes(x = reorder(kantone, -table(kantone)[kantone]))+
  geom_bar()

#6. Betrachten Sie die Einwohnerzahlen der Gemeinden gruppiert nach Sprachregionen.####
#Wie heissen die jeweils grössten Gemeinden?
max.gemeinde <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=1,wt=bev_total) %>%
  select(sprachregionen, gmdename, bev_total)
ggplot(gemeindedaten)+
  aes(x = factor(sprachregionen), y=bev_total)+
  geom_boxplot()+
  geom_text(data=max.gemeinde, label=max.gemeinde$gmdename, nudge_x = .2)

#7. Betrachten Sie die Veränderung der Einwohnerzahl von 2010 bis 2014 nach Sprachregionen. ####
#In welcher Sprachregionen sind die Gemeinden am stärksten gewachsen?
#In welcher am wenigsten oder gibt es Sprachregionen, in welcher die Einwohnerentwicklung
#in der Tendenz sogar eher rückläufig ist? Analysieren sie zusätzlich graphisch,
#ob die Unterscheidung von städtischen und ländlichen Gemeinden dabei eine Rolle spielt?
wachs.gemeinde <- gemeindedaten %>%
  group_by(sprachregionen,stadt_land) %>%
  summarise(wachstum = mean(bev_1014))
ggplot(wachs.gemeinde)+
  aes(x = sprachregionen, y = wachstum, col = stadt_land)+
  geom_point()+
  geom_abline(intercept = 0, slope = 0)

#8. Untersuchen Sie die Zusammenhangsstruktur folgender Variablen: ####
#bev_dichte, bev_ausl, alter_0_19, alter_20_64, alter_65,bevbew_geburt, sozsich_sh, strafen_stgb
#Gibt es Korrelationen? Falls ja, lassen Sie sich erklären oder sind sie eher unerwartet?
#Suchen Sie sich einen Ihnen interessant erscheinenden Zusammenhang und
#schauen Sie sich diesen in einem eigenen Scatterplot an
cor.gemeinde <- gemeindedaten %>%
  select(bev_dichte, bev_ausl, alter_0_19, alter_20_64, alter_65., bevbew_geburt, sozsich_sh, strafen_stgb)
gcor <- cor(cor.gemeinde)
corrplot(gcor, addCoef.col = "black",number.cex=0.7, diag = F)
#es gibt diverse Korrelationen, am auffäligsten die negative Korrelation zw. Ü65 und U65, sowie
#zw. ausl. Bevölkerungsanteil und Bevölkerungsdichte
ggplot(cor.gemeinde)+
  aes(x = alter_65., y = alter_0_19)+
  geom_point()+
  geom_smooth(method = "lm")

#9. Visualisieren Sie eine Kontingenztabelle mit den Variablen Stadt_Land und Sprachregionen. ####
#Welcher Gemeindetyp überwiegt bei deutschsprachigen Gemeinden, welcher bei italienischsprachigen Gemeinden.
#Gibt es in jeder Sprachregion isolierte Städte?
kontingenz = arrange(data.frame(table(gemeindedaten[5:6])),sprachregionen)
mosaic(~sprachregionen+Freq+stadt_land,data = kontingenz,
       highlighting = "stadt_land",highlighting_fill=c("blue","red","orange","green"),
       direction = c("h","v","h"))

#10. Erstellen Sie ein politisches Profil nach Sprachregionen mit der Hilfe der Variablen zu den Wähleranteilen.####
polit.gemeinde <- na.omit(merge(melt(gemeindedaten[c(1,38:48)],id = "bfsid"), gemeindedaten[c(1,5)]))
polit.gemeinde <- polit.gemeinde %>%
  group_by(sprachregionen,variable) %>%
  summarise(wert = mean(as.numeric(value)))
ggplot(polit.gemeinde)+
  aes(x=variable, y=wert, group=sprachregionen, col=sprachregionen)+
  geom_polygon(fill=NA) + 
  coord_polar() + facet_wrap(~ sprachregionen) + 
  theme(axis.text.x = element_text(size = 6))+
  theme(legend.position = "none")

#11. Wählen Sie eine der bereits erstellten Graphiken aus und verfeinern Sie diese so, dass Sie von anderen gut verstanden wird (Titel, Fussnote etc.)
#und ästhetisch möglichst überzeugt.
ggplot(polit.gemeinde)+
  aes(x=variable, y=wert, group=sprachregionen, col=sprachregionen)+
  geom_polygon(fill=NA) + 
  coord_polar() + facet_wrap(~ sprachregionen) + 
  labs(x = "Sprachgruppe",
       y = "Wähleranteil pro Partei in %",
       title = "Verteilung der politischen Parteien in den vier Sprachregionen der Schweiz",
       caption = "Quelle: Regionales Portrait der Schweizer Gemeinden 2014 (Open-Data Portal des Bundes)")+
  theme_bw()+
  theme(axis.text.x = element_text(size = 6))+
  theme(legend.position = "none")




