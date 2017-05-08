library(ggplot2)
library(dplyr)
library(plotly)


df <- read.csv("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/df1.csv") 

function(input, output, session) {
  
  selectedData <- reactive({
    dfSlice <- df %>%
      filter(Name==input$Name)
  })
  
  output$plot1 <- renderPlotly({
    dfSlice <- df %>%
      filter(Name == input$Name)
    plot_ly(selectedData(), x = ~Year, y = ~Hires, color = ~Name, type='scatter',
            mode = 'lines', width = 400)
  })
  
  output$stats <- renderPrint({
    dfSliceName <- selectedData() %>%
      filter(Name == input$Name)
    
    summary(dfSliceName$Hires)
  })
  
}