library(shiny)

#Create UI asking for which month you wanna consider and which parameters
#to use to predict Ozone levels
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Ozone linear modeling"),
  h5('This application considers the Ozone levels registered from May to September
     1973 and let the user calculate the coefficients of a linear model predicting
     Ozone levels with one or more of 3 other variables in the dataset as predictors.
     First select which month/months you want to consider for calculating the linear
     model (a plot will show the ozone levels during the selected period), then select
     which parameter/parameters to include in the model.'),
  
  # Sidebar with a slider input for which months to consider, and a checkbox
  # input for which parameters to use in modeling 
  sidebarLayout(
    sidebarPanel(
      h5('Which Months do you want to consider? From May (5th) to September (9th)'),
      sliderInput('months',
                  'months',
                  min = 5,
                  max = 9,
                  value = c(5,9)),
      h5('Which parameter do you want to include in the linear model for Ozone levels?'),
      checkboxInput('solar','Solar Radiation (lang)', value = FALSE),
      checkboxInput('wind','Wind Speed (mph)', value = FALSE),
      checkboxInput('temp','Temperature (F)', value = FALSE),
      submitButton('Calculate linear model')
    ),
    
    # Show a plot of the Ozone levels in the months considered
    mainPanel(
      h4('Ozone levels in the dates considered'),
      plotOutput('ozonelev'),
      h6('Missing ozone values (NA) appear on the graph as interruptions in the timeline'),
      h4('Linear model coefficients'),
      tableOutput('model')
      
    )
  )
))
