# 匯入套件
library(mlbench)

# 讀取資料
data("PimaIndiansDiabetes")
dim(PimaIndiansDiabetes)
levels(PimaIndiansDiabetes$diabetes)
head(PimaIndiansDiabetes)

# 匯出資料
write.csv(PimaIndiansDiabetes, "data.csv")
