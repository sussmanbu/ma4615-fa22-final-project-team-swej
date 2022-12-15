#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(tidyverse)
library(shiny)

modelData <- read.csv("modelData.csv")
colnames(modelData)[3] <- "Gender"
colnames(modelData)[4] <- "Age"
colnames(modelData)[5] <- "Ethnicity"
age_plot <- ggplot(modelData, aes(x = Age, y = MAP)) + 
  geom_smooth(method = "gam") 
#initialize modelData dataset and change column names to be called later
#also intialize age_plot to facet

var_choices <- c("Gender", "Year", "Ethnicity")

ui <- fluidPage(
  selectInput(inputId = "var",
              label = "Choose a Variable",
              choices = var_choices),
  plotOutput("facet")
)
server <- function(input, output) {
  output$facet <- renderPlot({
    age_plot + facet_wrap( ~ modelData[,input$var])+
      labs(title = "Mean Arterial Pressure (MAP) vs. Age", 
           x = "Age", y = "Mean Arterial Pressure")
  })
}
shinyApp(ui, server)

# Define UI for application that draws a histogram
#ui <- fluidPage(

    # Application title
    #titlePanel("General Health Trends in Relation to "),

    # Show a plot of the generated distribution
    #mainPanel(plotOutput("distPlot")),

    #selectInput(inputId = "var",
                #label = "Health Variable",
                #choices = var_choices),
    
    #plotOutput("plotMAP")
#)

# Define server logic required to draw a histogram
#server <- function(input, output) {

    #output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        #x    <- faithful[, 2]
        #bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        #hist(x, breaks = bins, col = 'darkgray', border = 'white',
             #xlab = 'Waiting time to next eruption (in mins)',
             #main = 'Histogram of waiting times')
    #})
#}

# Run the application 
shinyApp(ui = ui, server = server)
