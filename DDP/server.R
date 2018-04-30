#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)
library(reshape2)
library(ggplot2)
library(maps)

Manufacturing <- read_csv("data/Manufacturing.csv")
MfgEmpsByState <- Manufacturing[Manufacturing$NAICS2012_TTL=='Manufacturing'&Manufacturing$GEO_TTL!='United States',c(4,9,10)]
MfgEmpsByStateYear <- dcast(MfgEmpsByState, GEO_TTL ~ YEAR, value.var = "EMP")
MfgEmpsByStateYear$YOY <- MfgEmpsByStateYear$`2016`-MfgEmpsByStateYear$`2015`
MfgEmpsByStateYear$YOY_PCT <- 100*MfgEmpsByStateYear$YOY/MfgEmpsByStateYear$`2015`

# Filter example (where clause)
# MfgEmpsByState[MfgEmpsByState$YEAR==2016,]
# MfgEmpsByState[MfgEmpsByState$YEAR==2016&MfgEmpsByState$NAICS2012_TTL=='Manufacturing',]

# move this into the web page
jobGrowth <- c( MfgEmpsByStateYear[MfgEmpsByStateYear$YOY_PCT>=0,]$GEO_TTL)
jobLoss <- c( MfgEmpsByStateYear[MfgEmpsByStateYear$YOY_PCT<0,]$GEO_TTL)

jobGrowthColor = "green"
jobLossColor = "red"

dfLegend <- data.frame("Classification"=c("Job Growth","Job Loss"),"Color"=c("green","red"))

#map(database = "state")
#map(database = "state",regions = jobGrowth, col = jobGrowthColor,fill=T,add=TRUE)
#map(database = "state",regions = jobLoss, col = jobLossColor,fill=T,add=TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$selected_var <- renderText({input$checkGroup})
  output$tbl <- renderTable(dfLegend)
  output$distPlot <- renderPlot({
    
    # draw the histogram with the specified number of bins
    map(database="state") # border

    #    if (1 %in% input$checkGroup) {
    
    if (is.element(1,input$checkGroup)) {
      map(database = "state",regions = jobGrowth, col = jobGrowthColor,fill=T,add=TRUE)
    }
    if (is.element(2,input$checkGroup)) {
      map(database = "state",regions = jobLoss, col = jobLossColor,fill=T,add=TRUE)
    }
  })
  
})

# Define server logic required to draw a histogram
#server <- function(input, output) {
#   
#   output$distPlot <- renderPlot({
#      # generate bins based on input$bins from ui.R
#      x    <- faithful[, 2] 
#      bins <- seq(min(x), max(x), length.out = input$bins + 1)
#      
#      # draw the histogram with the specified number of bins
#      hist(x, breaks = bins, col = 'darkgray', border = 'white')
#   })
#}
#
# Run the application 
#shinyApp(ui = ui, server = server)

