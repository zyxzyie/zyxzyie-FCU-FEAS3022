library(AppliedPredictiveModeling)
data(FuelEconomy)
write.csv(cars2010, "cars2010.csv")
write.csv(cars2011, "cars2011.csv")
model1 = lm(FE ~ poly(EngDispl, 1),data= cars2010)
model2 = lm(FE ~ poly(EngDispl, 2),data= cars2010)

# par(mfrow=c(1,2))
plot(cars2010$EngDispl, cars2010$FE,main= '2010')
newdata =data.frame(EngDispl = seq(0,10,0.1))
lines(newdata$EngDispl, predict(model1,newdata))
lines(newdata$EngDispl, predict(model2,newdata))

plot(cars2011$EngDispl, cars2011$FE,main= '2011')
newdata =data.frame(EngDispl = seq(0,10,0.1))
lines(newdata$EngDispl, predict(model1,newdata))
lines(newdata$EngDispl, predict(model2,newdata))

#Check MSE
sum( (predict(model1,cars2011) - cars2011$FE)^2 )/245
sum( (predict(model2,cars2011) - cars2011$FE)^2 )/245

#How about we check MSE( X>3 )and MSE( X<3)?