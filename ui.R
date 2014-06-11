library(shiny)
library(ggplot2)
library(markdown)
require(rCharts)

shinyUI(navbarPage(
  title="Tik-Hinuch",
  tabPanel("Dashboard", 
        
    tags$head(tags$link(rel="stylesheet", type="text/css", href="style.css")),

  div(class = "row", 
    div(selectInput("select", label = "", 
      choices = list("Math" = "Math", "Math Computer" = "MathCompExam", "Science" = "Science", "Reading" = "Reading", "Reading Digital"="ReadingDigital"), 
      selected = "Math"), class = "span2"),
    div(checkboxGroupInput("checkGroup", label = "", 
     choices = list("OECD" = "OECD", "Israel" = "Israel", "Hebrew" = "Hebrew", "Arabic" = "Arabic",
      "Hebrew Official"= "HebrewOfficial", "Hebrew Religious"="HebrewReligious", "Hebrew Orthodox" = "HebrewOrthodox"), 
     selected = list("Hebrew", "Arabic", "OECD", "Israel")), class = "span8")
    ),
div(width=12,
  div(class = "row",
    div(showOutput("meanPlot", "nvd3"), class = "span6"),
    div(showOutput("distributionPlot", "nvd3"), class = "span6")
    ),

  div(class = "row", 
   
    div(showOutput("genderPlot", "nvd3"), class = "span6"),
    div(showOutput("socioEconomicPlot", "nvd3"), class = "span6")
    )
  )),
  tabPanel("Data", 
    dataTableOutput('dataTable')),
  tabPanel("About",
          includeMarkdown("about.html"))


  )
)
