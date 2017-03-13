# Data 608 Homework 3
# Armenoush Aslanian-Persico
# Problem 2
# UI Script


## Question 2
#Often you are asked whether particular States are improving their mortality rates (per cause) 
#faster than, or slower than, the national average. 
#Create a visualization that lets your clients see this for themselves 
#for one cause of death at the time. 
#Keep in mind that the national average should be weighted by the national population.



# Load data
df <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE, stringsAsFactors = FALSE)

# Get unique lists of inputs
allcauses<-unique(df$ICD.Chapter)
allstates<-unique(df$State)

# Create UI script
shinyUI(fluidPage(
  title = "State Mortality Rates Over Time",
  fluidRow(
    column(6, selectInput('causes', 'Cause of Death', choices=sort(allcauses)) ),
    column(6, selectInput('states', 'State', choices=sort(allstates)) )
  ),
  fluidRow(
    plotOutput('myplot')
  )
))