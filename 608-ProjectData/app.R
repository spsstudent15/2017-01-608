#Final Project Updated 20170516-0145
#Armenoush Aslanian-Persico


#############################################
#LOAD LIBRARIES AND DATA
#############################################

library(shiny)
library(plotly)

desc1 <- read.csv(url("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/desc.csv"), 
                  stringsAsFactors = FALSE)  

df2 <- read.csv(url("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/df-agencybyqtr2.csv"), 
                stringsAsFactors = FALSE)  

dfbudget <- read.csv(url("https://raw.githubusercontent.com/spsstudent15/2017-01-608/master/608-ProjectData/dfbudget.csv"), header=TRUE)
dfbudget<-head(dfbudget,14)


#############################################
#UI
#############################################
 
ui <- 
  navbarPage("New York City Hiring Trends", id="nav", ##added
             
tabPanel("Introduction",
         titlePanel("Who Runs New York City?"), 
         img(src="http://blog.ohny.org/wp-content/uploads/Q-New-York-State-Pavilion-Unisphere_credit-Brendan-Crain.jpg", width = 600),    
         p("Image Source: OHNY.org"),

             br(),
             br()
        ), #end tabpanel 
         
tabPanel("Interactive Graph",   
  
  fluidPage(    
  titlePanel("Where Can I Get A Job?"),
  sidebarLayout(      
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
    
    mainPanel(
      plotOutput("qtrPlot",height=700)  
    )
    
  )
)
), #end tabpanel


tabPanel("Plotly Graph",
         fluidPage(  
           titlePanel("Where Are My Taxes Going?"), 
           br(),
           br(),
           plotlyOutput("plot"), 
                     br(),
                     strong("What Does This Graph Show?"),
                     p("For the selected agencies, the Y axis indicates the average number of yearly hires in 2014 through 2016. 
                       The X axis indicates the most recent projected budget for Fiscal Year 2018, which ends in June 2018. 
                       An agency using less money while hiring more people could arguably be operating more efficiently."),
                     br(),
                      strong("What Doesn't This Consider?"),
                     p("Some agencies have seasonal workers, such as Parks and Sanitation, who hire for summer recreation and winter snow removal. 
                       These hiring counts may skew the data to make agencies appear more efficient than they are."),
           p("The budget amount consists of more than just hiring costs. 
             Personnel is usually the most significant budget expense. However, some agencies have substantial operating expenses which may be skewing this graph. "))
  ), #end tabpanel

tabPanel("Insights",
         titlePanel("Why Should I Care?"),
         img(src="http://www.ohny.org/sites/default/files/M-MMB%20Cupola_Harald%20Hoyer%20%20via%20Wikimedia%20Commons.jpg", width = 600),    
         p("Image Source: Open House New York"),
         br(),
         br(),
         strong("What's Interesting About the Data?"),
         p("Explanation of Insights"),
         br(),
         p("Additional Explanation")
  ), #end tabpanel

tabPanel("Sources",
         titlePanel("Where Can I Learn More?"),
         img(src="http://freshkillspark.org/wp-content/uploads/2013/06/View-from-North-Mound-960x520.jpg", width = 600),    
         p("Image Source: freshkillspark.org"),
         br(),
         url <- a("Dataset for NYC Hiring and Procurement", href="https://data.cityofnewyork.us/City-Government/City-Record-Online/dg92-zbpx"),
         br(),
         url <- a("Github Repository for This Project", href="https://github.com/spsstudent15/2017-01-608/tree/master/608-ProjectData"),
         br(),
         url <- a("New York City's Office of Management and Budget", href="http://www1.nyc.gov/site/omb/index.page"),
                  br(),
         url <- a("Work for New York City!", href="http://www.nyc.gov/jobs"),
         br(),
         br(),
         p("Thanks for viewing!")
  ) #end tabpanel

)

#############################################
#SERVER
#############################################

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
            col="#a5d6a7")
  })
  
  
output$plot <- renderPlotly({
  plot_ly(
     dfbudget, x = ~FY18Budget, y = ~AvgHires,
      # Hover text:
      text = ~paste("Agency: ", Agency, '<br>Average Hires:', AvgHires),
      color = ~AvgHires, size = ~AvgHires, marker=list(sizeref=0.05, sizemode="area"))%>%
      
      layout(title = "Agency Average Hires 2014-2016 vs. FY18 Budget")
  })
  
}

#Run the application 

shinyApp(ui = ui, server = server)

