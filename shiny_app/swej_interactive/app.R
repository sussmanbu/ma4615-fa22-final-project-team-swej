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
  titlePanel("Health Trend Analysis Through Mean Arterial Pressure (MAP) and Age"),
  sidebarLayout(
    position = "left",
    sidebarPanel(selectInput(inputId = "gender",
                                              label = "Choose a Variable",
                                              choices = c("Male", "Female"),
                                              selected = "male"),
                 checkboxGroupInput(inputId = "ethnicity", label = "Choose Ethnicity or Ethnicities", 
                                    selected = "White",
                                    choices = c("Mexican American", "Other Hispanic", 
                                                "White", "Black", "Other Race")),
                 sliderInput(inputId = "year", label = "Year Survey was Conducted",
                             min = 2000, max = 2018, value = 2000, step = 2, animate = TRUE),
                 code("Horizontal line in each plot is the collective Median MAP value 
                      (regardless of ethnicity) for chosen demographics at chosen year.
                      The curve seen is a line of best fit to the scatterplot by ethnicity."),
                 verbatimTextOutput("MAP_val")
                 ),
    mainPanel( 
              fluidRow(column(6, plotOutput("scatter")),
                       column(6, plotOutput("line"))),
              fluidRow(column(12, plotOutput("together"))),
    )
  )
)



server <- function(input, output) {
  
  output$MAP_val <- renderText({
    val <- modelData %>% filter(Gender == tolower(input$gender), Year == input$year,
             Ethnicity == input$ethnicity)
      paste("Median MAP Value in Plots:", toString(median(val$MAP)))
  })
  
  output$scatter <- renderPlot({
    modelData %>% filter(Gender == tolower(input$gender), Year == input$year,
                         Ethnicity == input$ethnicity) %>% 
      ggplot(aes(x = Age, y = MAP)) + geom_point(aes(color = Ethnicity))+
      geom_hline(aes(yintercept = median(MAP), color="Median MAP"))+
      labs(title = "MAP vs. Age by Chosen Demographics Scatterplot", 
           x = "Age", y = "Mean Arterial Pressure") + xlim(0,100)+ ylim(0,180) + 
      scale_x_continuous(breaks = seq(0, 100, by = 10), limits = c(0,100)) +
      scale_y_continuous(breaks = seq(0, 180, by = 20), limits = c(0,180)) + 
      coord_fixed(200/700)
  })
  
  output$line <- renderPlot({
    modelData %>% filter(Gender == tolower(input$gender), Year == input$year,
                         Ethnicity == input$ethnicity) %>% 
      ggplot(aes(x = Age, y = MAP)) + geom_smooth(aes(color = Ethnicity))+
      geom_hline(aes(yintercept = median(MAP), color="Median MAP"))+
      labs(title = "MAP vs. Age Line of Best Fit of Scatterplot", 
           x = "Age", y = "Mean Arterial Pressure") + xlim(0,100)+ ylim(0,180) + 
      scale_x_continuous(breaks = seq(0, 100, by = 10), limits = c(0,100)) +
      scale_y_continuous(breaks = seq(0, 180, by = 20), limits = c(0,180)) + 
      coord_fixed(200/700)
  })
  
  output$together <- renderPlot({
      modelData %>% filter(Gender == tolower(input$gender), Year == input$year,
                           Ethnicity == input$ethnicity) %>% 
        ggplot(aes(x = Age, y = MAP)) + geom_point(aes(color = Ethnicity), alpha = 0.3) + 
      geom_smooth(aes(x = Age, y = MAP, color = Ethnicity)) +
      geom_hline(aes(yintercept = median(MAP), color="Median MAP"), alpha = 0.5) +
      labs(title = "MAP vs. Age Scatterplot + Line of Best Fit", 
             x = "Age", y = "Mean Arterial Pressure") + 
      scale_x_continuous(breaks = seq(0, 100, by = 10), limits = c(0,100)) +
      scale_y_continuous(breaks = seq(0, 180, by = 20), limits = c(0,180)) + 
      coord_fixed(200/700)
    
  })
}
shinyApp(ui, server)


