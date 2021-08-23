library(e1071)
#mnist_matrix = read.csv( '/Users/Andrea/Documents/Iniziative/BFH/2017/5_course/code/MNIST.csv' )
mnist_matrix = read.csv( 'https://github.com/romeokienzler/developerWorks/raw/master/train.csv' )

mnist_matrix[,-1] = ceiling(mnist_matrix[,-1]/255)

# take only a subset to test the process
sample <- sample.int(nrow(mnist_matrix), floor(0.1*nrow(mnist_matrix)), replace = F)
mnist_matrix_red = mnist_matrix[sample,]
# build the train and test set
sample_train <- sample.int(nrow(mnist_matrix_red), floor(.95*nrow(mnist_matrix_red)), replace = F)
mnist_matrix_train = mnist_matrix_red[sample_train,]
mnist_matrix_test = mnist_matrix_red[-sample_train,]

# prepare the data for training and testing
train_no_label <- subset(mnist_matrix_train, select=-label)
train_label <- mnist_matrix_train$label 
test_no_label <- subset(mnist_matrix_test, select=-label)
test_label <- mnist_matrix_test$label


# train the model
svm_model <- svm(train_no_label,as.factor(train_label))

# test the model
pred <- predict(svm_model,test_no_label)
table((pred),test_label)

#Precision
truthVector = (pred) == test_label
good = length(truthVector[truthVector==TRUE])
bad = length(truthVector[truthVector==FALSE])
good/(good+bad)

#Error
bad/(good+bad)