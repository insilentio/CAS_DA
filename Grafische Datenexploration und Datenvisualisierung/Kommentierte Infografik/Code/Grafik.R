## Aufgabe: Grafik erstellen und als PDF exportieren für Verwendung im 2. Kursteil Grafik- und Datenvisualisierung

gemeindedaten<- read.csv("gemeindedaten.csv")
names(gemeindedaten)

library(ggplot2)
library(dplyr)
library(RColorBrewer)

### 1. version ####
ggplot(gemeindedaten)+
  aes(x=bev_ausl,y=polit_svp,color=sprachregionen, size=bev_total)+
  geom_smooth(method = "lm", se = T)+
  geom_point()
  

### 2. Version ####
id.total <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=1,wt=bev_total) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen)
id.ausl <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=1,wt=bev_ausl) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen)
id.ausl2 <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=-1,wt=bev_ausl) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen)
id.svp <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=1,wt=polit_svp) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen)
id.svp2 <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=-1,wt=polit_svp) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen)

kombi <- rbind(id.total,id.ausl,id.svp, id.ausl2, id.svp2)
titel <- "In den Schweizer Gemeinden wird umso mehr SVP gewählt, je kleiner der Anteil der ausländischen Wohnbevölkerung ist"
subtit <- "Korrelation zwischen SVP-Wähleranteil und Grösse der ausländischen Bevölkerung (pro Gemeinde, nach Sprachregionen)"
cap <- "Quelle: Regionales Portrait der Schweizer Gemeinden 2014 (Open-Data Portal des Bundes)"
xlabel <- "Ausländischer Bevölkerungsanteil in %"
ylabel <- "SVP Wähleranteil in %"

ggplot(gemeindedaten)+
  aes(x=bev_ausl,y=polit_svp,color=sprachregionen, size=bev_total)+
  geom_smooth(method = "lm", se = F)+
  geom_point(data = kombi,aes())+
  geom_text(data = kombi, aes(label = kombi$gmdename), nudge_x = 7)+
  scale_size_area(max_size=8)+
  labs(x = xlabel, y = ylabel, title = titel, subtitle = subtit, caption = cap)+
  theme_bw()



### 3. Version ####
gemeindedaten<- read.csv("gemeindedaten.csv")
gemeindedaten <- gemeindedaten %>%
  filter(!is.na(polit_svp)) %>%
  mutate(bev_einh = 100 - bev_ausl, svp_absolut = bev_total*polit_svp/100)
id.ausl <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=1,wt=bev_ausl) %>%
#  top_n(n=1,wt=bev_total) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen,bev_einh)
id.svp <- gemeindedaten %>%
  group_by(sprachregionen) %>%
  top_n(n=1,wt=polit_svp) %>%
  select(bfsid,gmdename,bev_total,bev_ausl,polit_svp,sprachregionen,bev_einh)

kombi <- rbind(id.svp, id.ausl)

titel <- "Je mehr Schweizer in der Gemeinde, desto höher der SVP-Wähleranteil"
cap <- "Quelle: Regionales Portrait der Schweizer Gemeinden 2014 (Open-Data Portal des Bundes)"
ylabel <- "SVP Wähleranteil in %"
subtit <- "Korrelation zwischen SVP-Wähleranteil und Anteil der einheimischen Bevölkerung (pro Gemeinde)"
xlabel <- "Einheimischer Bevölkerungsanteil in %"

theme_db<-function(base_size=12) {
  theme(
    panel.background=element_blank(),
    legend.position = "none",
    plot.caption = element_text(size = 6),
    plot.title = element_text(face = "bold")
  )
} 

## Teil1:
farben <- c("paleturquoise", "skyblue", "seagreen", "blue")
ggplot(gemeindedaten)+
  aes(x=bev_einh,y=polit_svp)+
  geom_point(data = gemeindedaten, color = "grey")+
  geom_point(data = kombi, aes(color = sprachregionen ), size=5)+
  scale_color_manual(values=farben)+
  geom_smooth(method = "lm", se = F)+
  geom_text(data = kombi, aes(label = kombi$gmdename), nudge_y = -3)+
  geom_label(aes(x=90,y=70),label="Höchster SVP-Wähleranteil", color="red")+
  geom_label(aes(x=50,y=5),label="Höchster Ausländeranteil", color="red")+
  labs(x = xlabel, y = ylabel, title = titel, subtitle = subtit, caption = cap)+
  theme_db()+
  theme(legend.position = c(.1,.9), legend.title = element_blank())

## verworfenen Variante:
# svp1 <- data.frame(x = as.numeric(as.character(c(80,id.svp[1,]$polit_svp))),
#                          y = as.numeric(as.character(c(75,id.svp[1,]$bev_einh))))
# names(svp1) <- c("polit_svp","bev_einh")
# svp2 <- data.frame(x = as.numeric(as.character(c(80,id.svp[2,]$polit_svp))),
#                    y = as.numeric(as.character(c(75,id.svp[2,]$bev_einh))))
# names(svp2) <- c("polit_svp","bev_einh")
# svp3 <- data.frame(x = as.numeric(as.character(c(80,id.svp[3,]$polit_svp))),
#                    y = as.numeric(as.character(c(75,id.svp[3,]$bev_einh))))
# names(svp3) <- c("polit_svp","bev_einh")
# svp4 <- data.frame(x = as.numeric(as.character(c(80,id.svp[4,]$polit_svp))),
#                    y = as.numeric(as.character(c(75,id.svp[4,]$bev_einh))))
# names(svp4) <- c("polit_svp","bev_einh")

# ggplot(gemeindedaten)+
#   aes(x=bev_einh,y=polit_svp)+
#   geom_point(data = gemeindedaten, color = "grey")+
#   geom_point(data = kombi, aes(color = sprachregionen ), size=5)+
#   geom_smooth(method = "lm", se = F)+
#   geom_text(data = kombi, aes(label = kombi$gmdename), nudge_y = -3)+
#   #  geom_polygon(data = id.svp2, color = "black", fill = NA)+
#    geom_line(data = svp1, arrow = arrow())+
#    geom_line(data = svp2, arrow = arrow())+
#    geom_line(data = svp3, arrow = arrow())+
#    geom_line(data = svp4, arrow = arrow())+
#   labs(x = xlabel, y = ylabel, title = titel, subtitle = subtit, caption = cap)+
#   theme_db()+
#   theme(legend.position = c(.1,.9), legend.title = element_blank())

## Teil 2
# xlabel <- "Siedlungsraum"
# titel <- "Je ländlicher die Gemeinde, desto höher der SVP-Wähleranteil"
# subtit <- "Gewichteter SVP-Wähleranteil nach Art des Siedlungsraums"
# 
# id.svpmean <- gemeindedaten %>%
#   group_by(stadt_land ) %>%
#   summarise(svp_absolut = sum(svp_absolut), bev_total = sum(bev_total), mean(polit_svp)) %>%
#   mutate(polit_svp = svp_absolut/bev_total*100) %>%
#   arrange(polit_svp)
#          
# ggplot(id.svpmean)+
#   aes(x=reorder(stadt_land, polit_svp),y=polit_svp)+
#   geom_col(width = .4, fill="#FFFFFF",color="black")+
#   geom_label(aes(x=1,y=22),label="städtisch", color="red")+
#   geom_label(aes(x=4,y=37.5),label="ländlich", color="red")+
#   labs(x = xlabel, y = ylabel, title = titel, subtitle = subtit, caption = cap)+
#   theme_db()


xlabel <- "Anteil der unter 20-65-Jährigen an der Bevölkerung (in %)"
titel <- "Je weniger Renter, desto höher der SVP-Wähleranteil"
subtit <- "Gewichteter SVP-Wähleranteil nach Anteil der 20- bis 65-Jährigen an der Bevölkerung"
xnames <- c("unter 40%", "40-50%", "50-60%", "60-70%", "über 70%")

gemeinde65 <- gemeindedaten %>%
  select(alter_20_64,polit_svp) %>%
  mutate(alter65 = case_when(
    alter_20_64 <= 40 ~ 1,
    alter_20_64 <= 50 ~ 2,
    alter_20_64 <= 60 ~ 3,
    alter_20_64 <= 70 ~ 4,
    T ~ 5
  )) %>%
  group_by(alter65) %>%
  summarise(alter_20_64 = mean(alter_20_64), polit_svp = mean(polit_svp))

ggplot(gemeinde65)+
  aes(x=alter65,y=polit_svp)+
  geom_col(width = .4, fill="#FFFFFF",color="black")+
  geom_label(aes(x=1,y=9),label="viele\nRentner", color="red")+
  geom_label(aes(x=5,y=39.5),label="wenig\nRentner", color="red")+
  scale_x_continuous(breaks = c(1:5), labels = xnames)+
  labs(x = xlabel, y = ylabel, title = titel, subtitle = subtit, caption = cap)+
  theme_db()


## Teil 3
xlabel <- "Siedlungsgrösse (in 1000 Personen)"
titel <- "Je kleiner die Gemeinde, desto höher der SVP-Wähleranteil"
subtit <- "Gewichteter SVP-Wähleranteil nach Bevölkerungsgrösse der Gemeinden"
xnames <- c("bis 5", "5 bis 10", "10 bis 20", "20 bis 50", "50 bis 100", "über 100")

gemeindegroesse <- gemeindedaten %>%
  select(bev_total,polit_svp) %>%
  mutate(groesse = case_when(
    bev_total <= 5000 ~ 1,
    bev_total <= 10000 ~ 2,
    bev_total <= 20000 ~ 3,
    bev_total <= 50000 ~ 4,
    bev_total <= 100000 ~ 5,
    T ~ 6
  )) %>%
  group_by(groesse) %>%
  summarise(bev_total = sum(bev_total), polit_svp = mean(polit_svp))

ggplot(gemeindegroesse)+
  aes(x=groesse,y=polit_svp)+
  geom_col(width = .4, fill="#FFFFFF",color="black")+
  geom_label(aes(x=1,y=36.5),label="kleine \nGemeinde", color="red")+
  geom_label(aes(x=6,y=19),label="grosse \nGemeinde", color="red")+
  scale_x_reverse(breaks = c(1:6), labels = xnames)+
  labs(x = xlabel, y = ylabel, title = titel, subtitle = subtit, caption = cap)+
  theme_db()
  
