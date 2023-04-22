"
期中題目：
1. OK 對 y 做 label encoding；把 chem 和 bio 合併成 X
2. OK 切割 training and testing 資料 (9:1)
3. OK 配適模型（CART、ctree 兩個）
4. OK 預測 測試集
5. OK 紀錄準確度 (DT: 0.4827586、CT: 0.5172414)
6. OK 對x做log轉換 砍太多0的變數 (DT: 0.4482759、CT: 0.5172414)
7. 再紀錄一次精準度
"

library(AppliedPredictiveModeling)
library(rpart)
library(party)
library(caret)
library(partykit)
data(hepatic)
# write.csv(bio, "bio.csv")
# write.csv(chem, "chem.csv")
# write.csv(injury, "injury.csv")

X_train <- read.csv("X_train.csv")[, -c(1)]
y_train <- as.factor(read.csv("y_train.csv")[, 2])
X_test <- read.csv("X_test.csv")[, -c(1)]
y_test <- as.factor(read.csv("y_test.csv")[, 2])

training <- cbind(X_train, y_train)

#----- 配適模型
model_DT <- train(y_train~., data = training, 
                  method = "rpart2", tuneLength = 7, 
                  trControl = trainControl(method = "cv"))
model_DT
# model_DT$finalModel
# rparttree = as.party(model_DT$finalModel)
# plot(rparttree)

model_CT <- train(y_train~., data = training,
                  method = "ctree2", tuneLength = 7,
                  trControl = trainControl(method = "cv"))
model_CT

#----- 預測 測試集
pred_DT <-  predict(model_DT, newdata = X_test)
cmatrix_DT <- confusionMatrix(pred_DT, y_test)
cmatrix_DT$overall[1]  # accuracy

pred_CT <- predict(model_CT, newdata = X_test)
cmatrix_CT <- confusionMatrix(pred_CT, y_test)
cmatrix_CT$overall[1]  # accuracy

#----- 對x做log轉換 砍太多0的變數
X_train_del <- read.csv("X_train_del.csv")[, -c(1)]
X_test_del <- read.csv("X_test_del.csv")[, -c(1)]

training_del <- cbind(X_train_del, y_train)

#----- 再紀錄一次精準度
model_DT_del <- train(y_train~., data = training_del, 
                  method = "rpart2", tuneLength = 5, 
                  trControl = trainControl(method = "cv"))
model_DT_del
# model_DT$finalModel
# rparttree = as.party(model_DT$finalModel)
# plot(rparttree)

model_CT_del <- train(y_train~., data = training_del,
                  method = "ctree2", tuneLength = 5,
                  trControl = trainControl(method = "cv"))
model_CT_del

pred_DT_del <-  predict(model_DT_del, newdata = X_test_del)
cmatrix_DT_del <- confusionMatrix(pred_DT_del, y_test)
cmatrix_DT_del$overall[1]  # accuracy

pred_CT_del <- predict(model_CT_del, newdata = X_test_del)
cmatrix_CT_del <- confusionMatrix(pred_CT_del, y_test)
cmatrix_CT$overall[1]  # accuracy
