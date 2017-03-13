# Data 608 Homework 3
# Armenoush Aslanian-Persico
# Problem 2
# Server Script


## Question 2
#Often you are asked whether particular States are improving their mortality rates (per cause) 
#faster than, or slower than, the national average. 
#Create a visualization that lets your clients see this for themselves 
#for one cause of death at the time. 
#Keep in mind that the national average should be weighted by the national population.


# Libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Load data
df <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE, stringsAsFactors = FALSE)


# Create server script
shinyServer(function(input, output) {
  output$myplot <- renderPlot({
    data <- df %>% 
      filter(State==input$states, ICD.Chapter==input$causes)
    usavg <- df %>% 
      filter(ICD.Chapter==input$causes) %>% 
      group_by(Year) %>% 
      summarise(rateyr=(sum(as.numeric(Deaths))/sum(as.numeric(Population))*100000))
    ggplot(data, aes(x=Year, y=Crude.Rate, color='purple')) + 
      geom_line(size=3) + 
      geom_line(aes(x=usavg$Year, y=usavg$rateyr, color='green'),size=2) + 
      scale_color_manual(
        name='Legend', 
        values=c('green'='green', 'purple'='purple'), 
        labels=c('National Average', 'State'))
  })
})

#Note: Had some issues with plot display for null values.
#Received error: Aesthetics must be either length 1 or the same as the data (1): x, y, colour