# Data 608 Homework 3
# Armenoush Aslanian-Persico
# Problem 1
# Server Script


## Question 1
#As a researcher, you frequently compare mortality rates from particular causes across different States. 
#You need a visualization that will let you see (for 2010 only) the crude mortality rate, across all States, 
#from one cause (for example, Neoplasms, which are effectively cancers). 
#Create a visualization that allows you to rank States by crude mortality for each cause of death.


# Libraries
library(shiny)
library(ggplot2)
library(dplyr)

# Load data
df <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE, stringsAsFactors = FALSE)

# Subset for 2010 only
df2010 <- subset(df, Year==2010)

# Unique causes of death for 2010
allcauses <- as.data.frame(unique(df2010$ICD.Chapter))

# Create user-interface definition
function(input, output) {
  showrates <- reactive({showrates <- subset(df2010, ICD.Chapter==input$cause)})
  output$plot1 <- renderPlot({
    ggplot(showrates(), aes(x=Crude.Rate, y=reorder(State, -Crude.Rate)))+
      scale_x_continuous(limits=c(0, max(showrates()$Crude.Rate))+5, expand = c(0,0))+
      geom_segment(aes(yend=State), xend=0, color="blue")+
      geom_point(size=3, color = "red") +
      theme_bw()+
      theme(panel.grid.major.y = element_blank(), axis.title=element_text(size=14))+
      xlab("2010 CDC Mortality Rate") +
      ylab("State") +
      ggtitle(input$cause)
  }) 
}
