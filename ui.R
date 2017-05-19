
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
  ),
  
  # Application title
  tags$div(id='titletext',titlePanel("My Project Name")),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      textAreaInput("myText","Enter Text Here:",height='300px',value = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque faucibus lectus sit amet nisi bibendum egestas. Pellentesque nisl nisi, viverra ac porta at, ultrices a ante. Curabitur enim quam, varius nec dui ac, aliquam dapibus ex. Quisque tincidunt aliquet dui, a consectetur neque scelerisque id. Praesent a felis et massa cursus viverra. Pellentesque venenatis tellus a est mollis, rutrum ultricies purus rutrum. Morbi gravida metus velit, a mollis justo tempus vel. Proin sodales eget nunc ac tincidunt. Nam condimentum, magna a vestibulum molestie, nisl ante laoreet justo, ut mollis ligula libero in dolor. Phasellus non sem eros. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Etiam hendrerit non purus non eleifend.")
      ,actionButton("Submit","Submit",icon=icon('check'))
      ,actionButton("clearButton","Clear Text",icon=icon('trash-o'))
    ),

  # Main Plot Panel
    mainPanel(
      fluidRow(
        column(width=6,
          tags$div(class='datatable',tags$h3('Structured Data'),DT::dataTableOutput("table1"))
        )
        ,column(width=6,
                tags$div(class='freetext',tags$h3('Free Text'),htmlOutput('html'))
        )
      )
    )
  )
))
