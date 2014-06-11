library(shiny)
require(rCharts)
shinyUI(fluidPage(
  tagList(
    tags$head(
      tags$link(rel="stylesheet", type="text/css", href="style.css")
      )
    ),
  titlePanel("PISA Dashboard"),

  sidebarPanel(
    selectInput("select", label = h3("Topic"), 
      choices = list("Math" = "Math", "Math Computer" = "MathCompExam", "Science" = "Science", "Reading" = "Reading", "Reading Digital"="ReadingDigital"), 
      selected = "Math"),

    checkboxGroupInput("checkGroup", label = h3("Secletor"), 
     choices = list("OECD" = "OECD", "Israel" = "Israel", "Hebrew" = "Hebrew", "Arabic" = "Arabic", "Hebrew Official"= "HebrewOfficial", "Hebrew Religious"="HebrewReligious", "Hebrew Orthodox" = "HebrewOrthodox"), 
     selected = "Hebrew")
    ),


  mainPanel(width = 12,
    div(class = "row",
      div(showOutput("meanPlot", "nvd3"), class = "span6"),
      div(showOutput("distributionPlot", "nvd3"), class = "span6")
      ),
    div(class = "row",
      div(showOutput("genderPlot", "nvd3"), class = "span6"),
      div(showOutput("socioEconomicPlot", "nvd3"), class = "span6")
      )
    )
  )
)
