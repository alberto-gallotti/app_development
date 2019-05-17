library(shiny)
library(dplyr)
library(ggplot2)
library(datasets)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  #Load airquality dataset
  ozonedf <- airquality
  
  #Create Date variable so to show variability of Ozone levels during time
  ozonedf$Date<-paste(ozonedf$Day,ozonedf$Month,'1973',sep = '-')
  ozonedf$Date<-as.Date(ozonedf$Date, format = '%d-%m-%Y')
  
  output$ozonelev <- renderPlot({
    # select only dates according to months selected in tue ui.R
    timespan<-c(input$months[1]:input$months[2])
    ozonedf_month<-filter(ozonedf, Month %in% timespan)
    
    # plot levels of ozone in the months selected in input$months from ui.R
    ozonelev<-ggplot(ozonedf_month, aes(x=Date, y=Ozone))+
      geom_line(color = 'green')+theme_dark()+ylab('Ozone Levels')
    ozonelev
  })
  
  
  # Create a linear model for ozone levels in the months selected
  output$model <- renderTable({
    # select only dates according to months selected in tue ui.R
    timespan<-c(input$months[1]:input$months[2])
    ozonedf_month<-filter(ozonedf, Month %in% timespan)
    
    ## consider only outcome (Ozone) and predictors (Solar.R, Wind, Temp)
    ozonetrain<-ozonedf_month[,1:4]
    
    ## consider predictors chosen and fit a linear model
    predictors<-c(T,input$solar,input$wind,input$temp)
    Variable<-c('Intercept','Solar Radiation','Wind Speed','Temperature (F)')
    if (sum(predictors)==1) {
      model<-print('You need to select at least one predictor')
    } else {
      ozonetrain<-ozonetrain[,predictors]
      model<-lm(Ozone~., data = ozonetrain)
      Variable<-Variable[predictors]
      print(rbind(Variable,model$coef))
    }
  })
  
})
