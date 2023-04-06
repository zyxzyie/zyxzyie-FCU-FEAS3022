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

rpartTune <- train(
  solTrainXtrans, solTrainY, method = "rpart2", 
  tuneLength = 10, trControl = trainControl(method = "cv")
)

# number: 決定 K-fold 的次數
rpartTune_cv <- train(
  solTrainXtrans, solTrainY, method = "rpart2", 
  tuneLength = 10, trControl = trainControl(method = "cv", number = 5)
)

# 換成 repeated cv 且重複 cv 5次
rpartTune_repeat <- train(
  solTrainXtrans, solTrainY, method = "rpart2", 
  tuneLength = 20, 
  trControl = trainControl(method = "repeatedcv", number = 5, repeats = 5)
)
