#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(openxlsx)

df2 <- read.csv("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/df-agencybyqtr.csv")  
  
  
ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Hiring by Agency"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("Agency", "Agency:", 
                  choices=as.list(df2$Agency)),
      hr(),
      helpText("NYC Agency Hiring, 2014-2016")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("qtrPlot")  
    )
    
  )
)

#############################################

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$qtrPlot <- renderPlot({
    
    # Render a barplot
    plot(Agency,, 
            main=input$Agency,
            ylab="Hires",
            xlab="Quarter")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

