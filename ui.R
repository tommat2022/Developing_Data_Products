library(shiny)

shinyUI(fluidPage(
  titlePanel("Prediction of new COVID-19 cases 7 days ahead in Chiba Prefecture"),
  sidebarLayout(
    sidebarPanel(
      helpText("Prediction of death a week ahead in Japan"),
      helpText("Parameters:"),
      sliderInput(inputId = "inTokyo",
                  label = "New patients in Tokyo:",
                  value = 3000,
                  min = 0,
                  max = 10000,
                  step = 50),
      sliderInput(inputId = "inKanagawa",
                  label = "New patients in Kanagawa:",
                  value = 2000,
                  min = 0,
                  max = 10000,
                  step = 50),
      sliderInput(inputId = "inSaitama",
                  label = "New patients in Saitama:",
                  value = 1000,
                  min = 0,
                  max = 10000,
                  step = 50),
      sliderInput(inputId = "inIbaraki",
                  label = "New patients in Ibaraki:",
                  value = 1000,
                  min = 0,
                  max = 10000,
                  step = 50),
      
      tags$img(src='Kanto_choice.jpg')
    ),

    mainPanel(
      htmlOutput("pText"),
      htmlOutput("pred"),
      plotOutput("Plot", width = "100%")
    )
    
  )
))