#-----(0406)
library(rpart)
library(party)
library(caret)
library(AppliedPredictiveModeling)

data(solubility)
write.csv(solTrainX, "soltrainX.csv")
write.csv(solTrainXtrans, "soltrainXtrans.csv")
write.csv(solTrainY, "soltrainY.csv")
write.csv(solTestX, "soltestX.csv")
write.csv(solTestXtrans, "soltestXtrans.csv")
write.csv(solTestY, "soltestY.csv")

set.seed(100)

# 用 transformation 的資料 train
rpartTune <- train(
  solTrainXtrans, solTrainY, method = "rpart2", 
  tuneLength = 10, trControl = trainControl(method = "cv")
)

# number: 決定 K-fold 的次數
rpartTune_cv <- train(
  solTrainXtrans, solTrainY, method = "rpart2", 
  tuneLength = 10, trControl = trainControl(method = "cv", number = 5)
)
rpartTune_cv
rpartTune$finalModel
# 換成 repeated cv 且重複 cv 5次
rpartTune_repeat <- train(
  solTrainXtrans, solTrainY, method = "rpart2", 
  tuneLength = 20, 
  trControl = trainControl(method = "repeatedcv", number = 5, repeats = 5)
)

# 用 原始的資料 train
rpartTune_origin <- train(
  solTrainX, solTrainY, method = "rpart2", 
  tuneLength = 10, trControl = trainControl(method = "cv")
)

# 圖示化 tree
library(partykit)
rparttree = as.party(rpartTune$finalModel)
plot(rparttree)

# Prediction
pred = predict(rpartTune, newdata=solTrainXtrans)
cbind(solTrainY,pred)
plot(solTrainY,pred)
