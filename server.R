library(shiny)
library(datasets)
library(reshape2)
require(rCharts)

shinyServer(function(input, output) {
  
  ##################### DataBase ####################
  pisa <- read.csv("data/PISA2012-10--06-2014.csv", head=TRUE, sep=",")
  
  
  output$valueB <- renderPrint({ input$select }) 
  output$valueC <- renderPrint({ input$checkGroup })
  
  ##################### Graphs ####################
  
  output$meanPlot <- renderChart({ 
      data <-pisa[pisa$sbj== input$select  & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "mean")]
      n1 <- nPlot("grp", "mean", data, type="multiBarChart")
      n1$set(dom = "meanPlot", width=500)
      n1$chart(forceY = c(300, 600), showControls = FALSE)
      n1$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#")      
      return(n1)
                    
  })
            
  output$distributionPlot <- renderChart({ 
    temp<-pisa[pisa$sbj==input$select & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "level1c", "level1b", "level1a", "level2", "level3", "level4", "level5", "level6")]
    data<-melt(temp)
    n2 <- nPlot("grp","value", group="variable", data, type="multiBarChart")
    n2$set(dom = "distributionPlot", width=500)
    n2$chart(stacked = TRUE)
    n2$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0) + '%'} !#")
    return(n2)
  })
  
  output$genderPlot <- renderChart({ 
    temp<-pisa[pisa$sbj==input$select & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "men", "women")]
    data<-melt(temp)
    n3 <- nPlot("grp","value", group="variable", data, type="multiBarChart")
    n3$set(dom = "genderPlot", width=500)
    n3$chart(forceY = c(300, 600), showControls = FALSE)
    n3$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#")
    return(n3)
  })
  
  output$socioEconomicPlot <- renderChart({ 
    temp<-pisa[pisa$sbj==input$select & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "lower", "middle", "high")]
    data<-melt(temp)
    n4 <- nPlot("grp","value", group="variable", data, type="multiBarChart")
    n4$set(dom = "socioEconomicPlot", width=500)
    n4$chart(forceY = c(300, 600), showControls = FALSE)  
    n4$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#")
    return(n4)
  })

  
})
