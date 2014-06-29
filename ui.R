library(shiny)

shinyUI(navbarPage(title="Tik-Hinuch", inverse=TRUE, collapsable=TRUE, fluid=TRUE, responsive=TRUE,
  tabPanel("Dashboard", uiOutput("dashboard")),
        
    # tags$head(tags$link(rel="stylesheet", type="text/css", href="style.css")),

  tabPanel("Data", uiOutput("data")),

  tabPanel("About", includeMarkdown("www/about.html"))
   
  )

)
        

   