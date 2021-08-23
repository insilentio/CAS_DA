library(e1071)

#1. Implement a function calculating the weighted empirical error for the MNIST classification exercise
#Empirical Class Distribution
h = hist(mnist_matrix_test$label,breaks = ((0:10)-0.1))

#Number of training examples
n = length(mnist_matrix_test$label)

#Weights per class
weights = h$counts/n

#weights to training data minus 1
weights_to_test_data = weights[mnist_matrix_test$label+1] # +1 as we use the index, which in r starts with 1

weights_to_test_data = weights_to_test_data + 1 # define a weight, gets larger with large datasets

#position of missclassified
missclassification_index = (pred) != test_label

#sum of weights missclassified
sum_missclassified = sum(weights_to_test_data[missclassification_index])

#done
weighted_error = sum_missclassified / n
weighted_error


# second approach
we3 = 0

for (i in 1:10){    #für jede Klasse
  ind = (i-1) == test_label
  temp_cross = ind&missclassification_index
  print(sum(temp_cross, na.rm=FALSE)/sum(ind, na.rm=FALSE))
  we3 = we3 + (1 + weights[i])*sum(temp_cross, na.rm=FALSE)
}
we3 = we3/n
we3
# absolute number of cases that are missclassified
sum((pred) != test_label, na.rm=FALSE)

#2. Have a look at the 1st slide titeled "In this lecture, we will cover..." of decision trees and list reasons why the presented flow chart is not a arborescence tree.

#https://en.wikipedia.org/wiki/Tree_(graph_theory)

# --> Trees are not allowed to have loops!

#3. Implement an MNIST classifier using either RandomForrest

library(randomForest)
model = randomForest(as.factor(label) ~ .,data=mnist_matrix_train, importance=TRUE, ntree=200)
pred = predict(model,mnist_matrix_test)
table(pred,mnist_matrix_test$label)
#evaluate
sum(pred == test_label)/nrow(mnist_matrix_test)
