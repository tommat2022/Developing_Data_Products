library(shiny)
library(dplyr)
library(ggplot2)

# 1st step: pass inches to cm
new_case_select <- read.csv("new_case_select.csv")


# linear model
model1 <- lm(Chiba_afterweek ~ Tokyo + Kanagawa + Saitama + Ibaraki, data=new_case_select)

shinyServer(function(input, output) {
  output$pText <- renderText({
    paste("7 days after in Chiba")
  })
  
  output$pred <- renderText({
    df <- data.frame(Tokyo=input$inTokyo,
                     Kanagawa=input$inKanagawa,
                     Saitama=input$inSaitama,
                     Ibaraki=input$inIbaraki
                    )
    chiba <- round(predict(model1, newdata=df),0)
    paste0(strong(chiba))
    })


  output$Plot <- renderPlot({
    df <- data.frame(Tokyo=input$inTokyo,
                     Kanagawa=input$inKanagawa,
                     Saitama=input$inSaitama,
                     Ibaraki=input$inIbaraki
                     )
    chiba <- predict(model1, newdata=df)
    yvals <- c("Ibaraki","Saitama","Kanagawa", "Tokyo", "Chiba after 7 days")
    df <- data.frame(
      x = factor(yvals, levels = yvals, ordered = TRUE),
      y = c(input$inIbaraki,input$inSaitama,input$inKanagawa,input$inTokyo, chiba))
    ggplot(df, aes(x=y, y=x, color=c("red", "green", "blue", "purple","yellow"), fill=c("red", "green", "blue", "purple","yellow"))) +
      geom_bar(stat="identity", width=0.5) +
      xlab("") +
      ylab("Region") +
      scale_x_continuous(limits=c(0,10000)) +
      theme_minimal() +
      theme(legend.position="none",axis.text.y = element_text(size = 18), axis.text.x = element_text(size=12))
  })
})