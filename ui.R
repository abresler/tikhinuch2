library(shiny)
library(ggplot2)
library(markdown)
require(rCharts)

shinyUI(navbarPage(
  title="Tik-Hinuch",
  tabPanel("Dashboard", 
        
    tags$head(tags$link(rel="stylesheet", type="text/css", href="style.css")),

  sidebarPanel( 
    div(selectInput("selectSubject", label = "", 
      choices =  unique(as.character(pisa$sbj)), 
      selected = "Math")),
    div(checkboxGroupInput("checkGroup", label = "", 
     choices = unique(as.character(pisa$grp)), 
     selected = list("Hebrew", "Arabic", "OECD", "Israel")))
    ),

  fluidRow(
    column(4, tags$h5("Mean"), showOutput("meanPlot", "nvd3")),
    column(4, tags$h5("Distribution"), showOutput("distributionPlot", "nvd3"))
    ),

  fluidRow(
   column(3),
    column(4, tags$h5("Gender"), showOutput("genderPlot", "nvd3")),
    column(4, tags$h5("Socio-Economic"), showOutput("socioEconomicPlot", "nvd3"))
    )
  ),
  tabPanel("Data",
     sidebarPanel(
     selectInput("selectTableYear", "Year:", c("All", unique(as.character(pisa$year)))), 
     selectInput("selectTableSubject", "Subject:", c("All", unique(as.character(pisa$sbj)))), 
     selectInput("selectTableGroup", "Group:", c("All", unique(as.character(pisa$grp)))), 

  checkboxGroupInput("show_vars", label = "Columns in PISA to show:", 
     choices = names(pisa), selected = list("year", "sbj", "topic", "grp", "mean", "men", "women"))),
       mainPanel(dataTableOutput("dataTable"))

  ),
        tabPanel("Explore"
          ),
  tabPanel("About",
          includeMarkdown("www/about.html"))
   


  )

)
        

   