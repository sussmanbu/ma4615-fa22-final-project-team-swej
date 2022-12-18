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
#for ease in calling column names


ui <- fluidPage(
  selectInput(inputId = "gender",
              label = "Choose a Variable",
              choices = c("male", "female"),
              selected = "male"),
  checkboxGroupInput(inputId = "ethnicity", label = "Choose Ethnicity or Ethnicities", 
                     selected = "White",
                     choices = c("Mexican American", "Other Hispanic", 
                                 "White", "Black", "Other Race")),
  sliderInput(inputId = "year", label = "Year Survey was Conducted",
              min = 2000, max = 2018, value = 2000, step = 2, animate = TRUE),
  plotOutput("line")
)
server <- function(input, output) {
  output$line <- renderPlot({
      modelData %>% filter(Gender == input$gender, Year == input$year,
                           Ethnicity == input$ethnicity) %>% 
        ggplot(aes(x = Age, y = MAP)) + geom_point(aes(color = Ethnicity)) + 
          geom_hline(aes(yintercept = median(MAP), color="Median MAP")) +
        labs(title = "Mean Arterial Pressure (MAP) vs. Age by Chosen Demographics", 
             x = "Age", y = "Mean Arterial Pressure") + xlim(0,100)+ ylim(0,180) +
      coord_fixed(200/700)

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
