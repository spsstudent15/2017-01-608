library(ggplot2)
library(dplyr)
library(plotly)


  df <- read.csv("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/df1.csv")  
  
  fluidPage(
    headerPanel('New York City Agency Hiring Trends'),
    
    sidebarPanel(
      selectInput('Name', 'Agency Name', unique(df$Name), selected='DSNY')
    ),
  
    mainPanel(
      plotlyOutput('plot1'),
      verbatimTextOutput('stats'),
      tags$h5("Source: NYC Open Data")
    )
  )