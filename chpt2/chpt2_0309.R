library(earth)
library(AppliedPredictiveModeling)
data(FuelEconomy)
marsFit <- earth(cars2010$EngDispl, cars2010$FE) #X variable; Y variable.
summary(marsFit)

#Prediction
pred2011 = predict(marsFit, cars2011$EngDispl)
plot(cars2011$EngDispl, cars2011$FE)
points(cars2011$EngDispl, pred2011, col=2,pty=2)

#Pseudo R-square
plot(cars2011$FE,pred2011)
cor(cars2011$FE,pred2011)^2

data <- trees
write.csv(data, "trees.csv")
