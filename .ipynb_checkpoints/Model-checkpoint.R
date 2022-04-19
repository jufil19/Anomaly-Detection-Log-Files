

data <- read.csv("eventmatrixlabel.csv")

# Running a random forest

library(randomForest)
library(dplyr)
library(MLmetrics)
library(MASS)
library(DAAG)
library(tree)

set.seed(2021)

data <- data %>% mutate(Label = factor(ifelse(Label == 'Anomaly', 1, 0)))
str(data)

training_prop <- 0.80
training_size <- floor(training_prop * nrow(data))
training_index <- sample(seq_len(nrow(data)), size = training_size)

training_data <- data[training_index, ]
test_data <- data[-training_index, ]

label_training <- as.factor(data[training_index, 50]) #response variable for training
label_test <- data[-training_index, 50] #response variable for test

#### Tree ######

tree.mod <- tree(Label~., data = training_data)
cv.tree.mod <- cv.tree(tree.mod, FUN = prune.tree) # full grown tree is better - no pruning
plot(cv.tree.mod, type = 'b')


plot(tree.mod)
text(tree.mod)

predict_test_tree <- predict(tree.mod, newdata = test_data)

##### Random Forest ########

randomforest.mod <- randomForest(Label~., data = training_data, importance = TRUE, ntree = 100)

plot(1:length(randomforest.mod$err.rate[,1]), randomforest.mod$err.rate[,1], type="l", 
     xlab="Number of trees", ylab="OOB error rate", main="Random Forest")


varImpPlot(randomforest.mod)


predict_test <- predict(randomforest.mod, newdata = test_data, type = "response")


Sensitivity(label_test, predict_test)
Precision(label_test, predict_test)
Specificity(label_test, predict_test)
F1_Score(label_test, predict_test)

summary(randomforest.mod)







curve(sqrt(abs(x))+ sqrt(abs(y)) = 1)

