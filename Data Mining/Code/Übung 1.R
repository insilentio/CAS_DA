## CAS DA FS2017: Data Mining
## Übung 1
## Daniel Baumgartner
library(dplyr)
library(tidyr)
library(ggplot2)
library(data.table)
library(robustbase)

### 1. ####
lograw <- read.table("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/log", header = F)
#solution is overly complicated due to requirement of exercise: nested bind_cols would not be needed as the 
#timestamp in rows 1&2 is always the same
log1 <- lograw %>%
  arrange(V6) %>%
  slice(1:(n()/2)) %>%
  separate(V6,into=c("departmentid", "employeeid", "clientid"), sep=",", convert=T) %>%
  bind_cols(log1[seq(1,nrow(lograw), by=2),] %>%
              extract(V4,"hour","(:[[:digit:]]+:)") %>%
              extract(hour,"hour",regex="([[:digit:]]{2})", convert=T)
              ) %>%
  select(hour,employeeid,departmentid,clientid)
log1


### 2.####
lograw2 <- read.csv("https://raw.githubusercontent.com/romeokienzler/developerWorks/master/testdata.csv")
log2 <- as.data.table(lograw2)
log2 <- log2[,.(hour,employeeid,departmentid,clientid)]

#department und employee sind vertauscht
names(log2) <- c("hour", "departmentid", "employeeid", "clientid")
log2 <- log2[,.(hour,employeeid,departmentid,clientid)]

#do some non-fancy stuff first
#overview
summary(log2)
#covariance matrix, correlation matrix
cov(log2)
cor(log2)
#check histograms
ggplot(log2)+
  aes(hour)+
  geom_histogram(bins=23)
# slight hickup at hour 0
ggplot(log2)+
  aes(departmentid)+
  geom_histogram(bins=99)
ggplot(log2)+
  aes(employeeid)+
  geom_histogram(bins=9)
ggplot(log2)+
  aes(clientid)+
  geom_histogram(bins=999)

#no real insight so far
#let's check linear model
mod <- lm(hour~employeeid+departmentid+clientid, data = log2)
summary(mod)
#some indication that employee is the only relevant variable

#let's find some potential outliers with the mahalanobis distances
mcd <- covMcd(log2)
inv <- log2[mcd$mah>18] %>%
  group_by(hour,departmentid) %>%
  summarise(n=n()) %>%
  arrange(-n)
ggplot(inv)+
  aes(x=hour,y=n,fill=departmentid)+
  geom_col()+
  facet_grid(.~departmentid)
#--> only department 7 at hour 0  seems to be interesting
#let's check which employee
plot(table(log2[departmentid==7&hour==0,.(hour,employeeid,departmentid)]))
#or
ggplot(log2[departmentid==7&hour==0,.(hour,employeeid,departmentid)])+
  aes(x=employeeid)+
  geom_histogram(bins = 99)

## --> it's the employee 23 from dept 7 which causes an extraordinary thousand hits at hour 0 (midnight...)

