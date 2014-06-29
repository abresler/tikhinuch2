library(shiny)

shinyUI(navbarPage(title="Tik-Hinuch", inverse=TRUE, collapsable=TRUE, fluid=TRUE, responsive=TRUE,
  tabPanel("Dashboard", uiOutput("dashboard")),
        
  tabPanel("Data", uiOutput("data")),

  tabPanel("About", includeMarkdown("www/about.html"))
   
  )

)
        

   