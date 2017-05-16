#Final Project Updated 20170515
#Armenoush Aslanian-Persico

library(shiny)

desc1 <- read.csv(url("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/desc.csv"), 
                  stringsAsFactors = FALSE)  

df2 <- read.csv(url("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/app4/df-agencybyqtr2.csv"), 
                stringsAsFactors = FALSE)  



  
ui <- 
  navbarPage("New York City Hiring Trends", id="nav", ##added
             
tabPanel("Introduction",
         img(src="http://www.ohny.org/sites/default/files/M-MMB%20Cupola_Harald%20Hoyer%20%20via%20Wikimedia%20Commons.jpg", width = 600),    
         p("Image Source: Open House New York"),
             br(),
             br()), 
         
tabPanel("Interactive Graph",   
  
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
      verbatimTextOutput('desc'),
      helpText("Source: NYC Open Data, NYC.gov")
      
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("qtrPlot",height=700)  
    )
    
  )
)
),

tabPanel("Insights",
         img(src="http://freshkillspark.org/wp-content/uploads/2013/06/View-from-North-Mound-960x520.jpg", width = 600),    
         p("Image Source: freshkillspark.org"),
         br(),
         br()
),

tabPanel("Sources",
         img(src="http://www1.nyc.gov/assets/designcommission/images/content/slideshows/1970-nyc-photo.jpg", width = 400),    
         p("Image Source: NYC.gov"),
         br(),
         br()
)

)
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

#Run the application 

shinyApp(ui = ui, server = server)

