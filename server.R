library(shiny)
library(caret)
library(e1071)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
df = data.frame(diagnosis = diagnosis,Genotype = predictors[,"Genotype"])
inTrain = createDataPartition(df$diagnosis, p = 3/4)[[1]]
training = df[ inTrain,]
testing = df[-inTrain,]
modelFit<-train(diagnosis ~ Genotype, data = training, method = "glm")


shinyServer(function(input, output){
  output$summary <- renderText({
    summary(modelFit$finalModel)
    newdata <- data.frame(Genotype=as.character(input$genotype))
    p <- predict(modelFit, newdata)
    paste("The prediction is: ",as.character(p[1]))
  })
  output$text1<-renderText({paste("Possible predictions: ", levels(df$diagnosis)[1], " vs. ", levels(df$diagnosis)[2])})
  output$values <- renderTable({
    # Compose data frame
    data.frame(Predictor.Name = "Genotype", Predictor.Value = as.character(input$genotype))
  })
})