output$dashboard <- renderUI({
# sidebarLayout(fluid=TRUE,
  wellPanel(
    tags$head(tags$link(rel="stylesheet", type="text/css", href="style.css")),
    
    selectInput("selectSubject", label = "", 
     choices =  unique(as.character(pisa$sbj)), 
     selected = "Math"),  
    
    uiOutput("selectTopic"),
    
    checkboxGroupInput("checkGroup", label = "", inline=TRUE,
     choices = unique(as.character(pisa$grp)), 
     selected = list("Hebrew", "Arabic", "OECD", "Israel")),
    
    
    div(class = "row", width=10,         
      
      div(showOutput("meanPlot", "nvd3"), class = "span5"),
      div(showOutput("distributionPlot", "nvd3"), class = "span5")
      )
    ,
    div(class="row", width=10, 
      div(showOutput("genderPlot", "nvd3"), class = "span5"),
      div(showOutput("socioEconomicPlot", "nvd3"), class = "span5")
      
      )
    )
})


output$selectTopic <- renderUI({
  selectInput("selectTopic", label = "", 
    choices =  unique(as.character(pisa$topic[c(pisa$sbj==input$selectSubject)])), 
    selected = "General")  
})

output$meanPlot <- renderChart({ 
  if(is.null(input$selectTopic))
    return ("General")  
  pisa <-pisa[pisa$sbj== input$selectSubject & pisa$topic== input$selectTopic  & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "mean")]
  n1 <- nPlot("grp","mean", pisa, type="multiBarChart")
  n1$templates$script <- "http://timelyportfolio.github.io/rCharts_nvd3_templates/chartWithTitle_styled.html"
  n1$set(dom = "meanPlot", width=500, title="Mean")
  n1$chart(showControls = FALSE)
  n1$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#", axisLabel = "PISA points", width=40)   
  return(n1)
})

output$distributionPlot <- renderChart({ 
  if(is.null(input$selectTopic))
    return ("General")
  pisa<-pisa[pisa$sbj== input$selectSubject & pisa$topic== input$selectTopic & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "level1c", "level1b", "level1a", "level2", "level3", "level4", "level5", "level6")]
  pisa<-melt(pisa)
  
  n2 <- nPlot("grp","value", group="variable", pisa, type="multiBarChart")
  n2$templates$script <- "http://timelyportfolio.github.io/rCharts_nvd3_templates/chartWithTitle_styled.html"
  
  n2$set(dom = "distributionPlot", width=500, title="Distribution")
  n2$chart(stacked = TRUE)
  n2$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0) + '%'} !#")
  return(n2)
})

output$genderPlot <- renderChart({ 
  if(is.null(input$selectTopic))
    return ("General")
  pisa<-pisa[pisa$sbj== input$selectSubject & pisa$topic== input$selectTopic & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "men", "women")]
  pisa<-melt(pisa)
  n3 <- nPlot("grp","value", group="variable", pisa, type="multiBarChart")
  n3$templates$script <- "http://timelyportfolio.github.io/rCharts_nvd3_templates/chartWithTitle_styled.html"
  
  n3$set(dom = "genderPlot", width=500, title="Gender")
  n3$chart(showControls = FALSE)
  n3$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#", axisLabel = "PISA points", width=40)
  return(n3)
})

output$socioEconomicPlot <- renderChart({ 
  if(is.null(input$selectTopic))
    return ("General")
  pisa<-pisa[pisa$sbj== input$selectSubject & pisa$topic== input$selectTopic & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "lower", "middle", "high")]
  pisa<-melt(pisa)
  n4 <- nPlot("grp","value", group="variable", pisa, type="multiBarChart")
  n4$templates$script <- "http://timelyportfolio.github.io/rCharts_nvd3_templates/chartWithTitle_styled.html"
  
  n4$set(dom = "socioEconomicPlot", width=500, title="Socio-Economic")
  n4$chart(showControls = FALSE)  
  n4$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#", axisLabel = "PISA points", width=40)
  return(n4)
})
