# Data 608 Homework 3
# Armenoush Aslanian-Persico
# Problem 1
# UI Script


## Question 1
#As a researcher, you frequently compare mortality rates from particular causes across different States. 
#You need a visualization that will let you see (for 2010 only) the crude mortality rate, across all States, 
#from one cause (for example, Neoplasms, which are effectively cancers). 
#Create a visualization that allows you to rank States by crude mortality for each cause of death.


# Load data
df <- read.csv("https://raw.githubusercontent.com/charleyferrari/CUNY_DATA608/master/lecture3/data/cleaned-cdc-mortality-1999-2010-2.csv", header = TRUE, stringsAsFactors = FALSE)

# Subset for 2010 only
df2010 <- subset(df, Year==2010)

# Unique causes of death for 2010
allcauses <- unique(df2010$ICD.Chapter)

# Create server logic
fluidPage(
  titlePanel("2010 CDC Mortality Rates"),
  fluidRow(selectInput("cause", "Cause of Death:", choices=sort(allcauses))), 
  plotOutput("plot1", height = 800)
)
