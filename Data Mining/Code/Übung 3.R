## CAS DA FS2017: Data Mining
## Übung 3
## Daniel Baumgartner


mnist_matrix = read.csv( 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv' )
dim(mnist_matrix)
sort(unique(mnist_matrix[,1]))

par( mfrow = c(10,10), mai = c(0,0,0,0))
for(i in 1:100){
  y = as.matrix(mnist_matrix[i, 2:785])
  dim(y) = c(28, 28)
  image( y[,nrow(y):1], axes = FALSE, col = gray(255:0 / 255))
  text( 0.2, 0, mnist_matrix[i,1], cex = 3, col = 2, pos = c(3,4))
}

# 1. Führen Sie u.g. Source Code aus und beantworten Sie folgende Fragen
# a) Wieviele Bilder sind in der Matrix mnist_matrix encodiert
nrow(mnist_matrix)
# b) Da es sich um einen Supervised Machine Learning task handelt muss ein Label (Target Variable)
# bereitgestellt sein - welche Spalte der Matrix enthält das Label?
names(mnist_matrix)[1]
# c) Wieviele Pixel haben die Bilder?
ncol(mnist_matrix)-1
# d) Wie hoch/breit sind die Bilder?
sqrt(ncol(mnist_matrix)-1)


# 2. Nehmen Sie einen Classifier Ihrer Wahl und trainieren Sie Ihn mit der bereitgestellten Matrix.
# a) Teilen Sie die Matrix in ein sinnvolles Training und Test set auf, lesen Sie hierzu diesen Thread:
#   http://stats.stackexchange.com/questions/19048/what-is-the-difference-between-test-set-and-validation-set
# (Ein Validation Set wird hier nicht benötigt da nicht erwartet wird Parameter des Classifiers zu tunen)
# b) Verwenden Sie nun das Training Set um einen Classifier Ihrer Wahl zu trainieren
# c) Berechnen Sie den Prozentsatz der richtig klassifizierten Daten indem Sie Ihren trainierten Classifier auf das Test Set anwenden
# (Hinweis: Die Qualität des Classifiers wird nicht bewertet)

library(parallelSVM)

#reduce to 0's and 1's (only black and white pixels are relevant)
mnist_matrix[,-1] <- ceiling(mnist_matrix[,-1]/255)

sample <- sample.int(nrow(mnist_matrix), floor(.75*nrow(mnist_matrix)), replace = F)
train <- mnist_matrix[sample, ]
test <- mnist_matrix[-sample, ]

modSVM <- parallelSVM(train[2:785], as.factor(train$label), samplingSize = .3)

pred <- predict(modSVM, test[2:785])
table(pred, test$label)

#evaluate
truthVector = pred == test$label
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)


# try parallel prediction --> does not really work (yet)
test2 <- test[2:785]
class(modSVM)
library(foreach)
library(doSNOW)
num_splits<-4 #change the 4 to your number of CPU cores
cl<-makeCluster(num_splits) 
registerDoSNOW(cl)  
split_test <- sort(rank(1:nrow(test_no_label))%%num_splits)
pred_par <- foreach(i=unique(split_test),
                    .combine=c,.packages=c("e1071")) %dopar% {
                      as.numeric(predict(svm_model, newdata=test_no_label[split_test==i,]))
                      }
stopCluster(c1)
