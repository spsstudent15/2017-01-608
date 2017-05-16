#Final Project Updated 20170515
#Armenoush Aslanian-Persico

library(shiny)
#library(openxlsx)

df2 <- read.csv("df-agencybyqtr2.csv", stringsAsFactors = FALSE)  
desc1 <- read.csv("desc.csv", stringsAsFactors = FALSE)  

  
ui <- 
  navbarPage("New York City Hiring Trends", id="nav", ##added
             
tabPanel("Introduction",
         img(src="http://www1.nyc.gov/assets/designcommission/images/content/slideshows/1970-nyc-photo.jpg",
             width = 400),    
         p("p creates a paragraph of text."),

             br(),
             code("code displays your text similar to computer code"),
             br()), ##added
         
tabPanel("Interactive Graph",    ##added
  
  fluidPage(    
  # Give the page a title
  titlePanel("NYC Hiring by Agency, 2014-2016"),
  # Generate a row with a sidebar
  sidebarLayout(      
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("agency", "Agency:", 
                  choices=c("ACS",
                            "Correction",
                            "DCAS",
                            "DDC",
                            "DEP",
                            "DHS",
                            "DOB",
                            "DOH",
                            "DOT",
                            "DPR",
                            "DSNY",
                            "FDNY",
                            "HRA",
                            "NYPD")),
      hr(),
      helpText("Source: NYC Open Data"),
      verbatimTextOutput('desc')
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("qtrPlot",height=700)  
    )
    
  )
)
),
tabPanel("Insights",
         img(src="http://www1.nyc.gov/assets/designcommission/images/content/slideshows/1970-nyc-photo.jpg", width = 400),    
         p("p creates a paragraph of text."),
         br(),
         br(),
         code("code displays your text similar to computer code"),
         br()), ##added

tabPanel("Sources and Further Reading") ##added
) #added


#############################################
#SERVER


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$desc <- renderText({
    desc1t<-subset(desc1, Agency==input$agency, select = "Desc")  
    paste('You selected', desc1t)})
          
  # Fill in the spot we created for a plot
  output$qtrPlot <- renderPlot({

    
    # Render a barplot
    barplot(df2[,input$agency], 
            main=input$agency,
            ylab="Hires",
            xlab="Quarter",
            names.arg = df2$Agency,
            col="blue")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

