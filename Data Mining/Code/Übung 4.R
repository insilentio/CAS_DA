## CAS DA FS2017: Data Mining
## Übung 4
## Daniel Baumgartner

# 1. Implement a function calculating the weighted empirical error for the MNIST classification exercise
# 2. Have a look at the 1st slide titled "In this lecture, we will cover..." of decision trees and list reasons why the presented flow chart is not a arborescence tree.
# See also: https://en.wikipedia.org/wiki/Tree_(graph_theory)
# 3. Implement an MNIST classifier using either RandomForrest or Gradient Boosted Trees (XGBOOST)


#### 1. 
error <- function(test, pred) {
  sqrt((sum((as.numeric(test$label) - as.numeric(pred))^2))/nrow(test))
}
error(test, pred)


#### 2.
# not all edges point away from the root


#### 3.
