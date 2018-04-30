#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Manufacturing Job Growth/Loss by State"),
  h3("2016 compared to 2015 baseline"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("checkGroup", 
                         h3("Net Manufacturing Jobs"), 
                         choices = list("Growth States" = 1, 
                                        "Loss States" = 2),
                         selected = 1)),
    
    # Show a plot of the generated distribution
    mainPanel(
      # textOutput("selected_var"),
      tableOutput("tbl"),
      plotOutput("distPlot")
    )
  )
))


# Define UI for application that draws a histogram
#ui <- fluidPage(
#   
#   # Application title
#   titlePanel("Old Faithful Geyser Data"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#      sidebarPanel(
#         sliderInput("bins",
#                     "Number of bins:",
#                     min = 1,
#                     max = 50,
#                     value = 30)
#      ),
#      
#      # Show a plot of the generated distribution
#      mainPanel(
#         plotOutput("distPlot")
#      )
#   )
#)

# Run the application 
#shinyApp(ui = ui, server = server)

