
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(DT)
library(dplyr)

source('functions.R')

shinyServer(function(input, output, session) {
  
  ###--- Reactive input data ---###
  text_in <- eventReactive(input$Submit,{ 
    validate(
      need(input$myText != "", "Please enter some data and click submit")
    )
    input$myText })
  
  ###--- Clear Input data ---###
  observeEvent(input$clearButton,{
    updateTextInput(session,"myText", value="")
  })
  
  ###--- demo data table ---###
  #Replace this step with NLP API call
  longwords_tbl <- eventReactive(input$Submit,{
    words <- as.character(unlist(strsplit(text_in(),' '))) #text()
    n <- sapply(1:length(words),function(X){nchar(words[X])})
    df <- data.frame(words,n)
    df$wordstart <- sapply(1:nrow(df),function(X){ gregexpr(df$words[X],text_in())[[1]][1][1] })
    df$wordend <- df$wordstart + df$n
    df <- filter(df, n > 7)
    df
  })
  
  ###--- tables ---###
  output$table1 <- renderDataTable({
    tableFormatFun(longwords_tbl())
  })
  
  # output$table2 <- renderDataTable({
  #   tableFormatFun(iris)
  # })
  
  ###--- html output with highlights ---###
  observeEvent(text_in(),{ #input$table1_rows_selectedinput$Submit}
    output$html <- renderUI({
      if (is.null(input$table1_rows_selected))
        return(HTML(text_in()))
      
      HTML(insert_str(text_in(),
                      c('<mark>','</mark>'),
                      c(longwords_tbl()$wordstart[input$table1_rows_selected]-15,
                        longwords_tbl()$wordend[input$table1_rows_selected]+15)
      ))
    })
  })

  
})
