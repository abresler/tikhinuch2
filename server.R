library(shiny)
library(datasets)
library(reshape2)
library(ggplot2)
library(markdown)
require(rCharts)

shinyServer(function(input, output) {
  
  ##################### DataBase ##################
  pisa <- read.csv("data/PISA2012-11--06-2014.csv", head=TRUE, sep=",")  
  
  ##################### Graphs ####################
  #output$valueB <- renderPrint({ input$selectSubject }) 
  #output$valueC <- renderPrint({ input$checkGroup })

  output$meanPlot <- renderChart({ 
    pisa <-pisa[pisa$sbj== input$selectSubject  & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "mean")]
      n1 <- nPlot("grp", "mean", pisa, type="multiBarChart")
      n1$set(dom = "meanPlot", width=500)
      n1$chart(showControls = FALSE)
      n1$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#")      
      return(n1)
                    
  })
            
  output$distributionPlot <- renderChart({ 
    pisa<-pisa[pisa$sbj==input$selectSubject & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "level1c", "level1b", "level1a", "level2", "level3", "level4", "level5", "level6")]
    pisa<-melt(pisa)
    n2 <- nPlot("grp","value", group="variable", pisa, type="multiBarChart")
    n2$set(dom = "distributionPlot", width=500)
    n2$chart(stacked = TRUE)
    n2$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0) + '%'} !#")
    return(n2)
  })
  
  output$genderPlot <- renderChart({ 
    pisa<-pisa[pisa$sbj==input$selectSubject & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "men", "women")]
    pisa<-melt(pisa)
    n3 <- nPlot("grp","value", group="variable", pisa, type="multiBarChart")
    n3$set(dom = "genderPlot", width=500)
    n3$chart(showControls = FALSE)
    n3$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#")
    return(n3)
  })
  
  output$socioEconomicPlot <- renderChart({ 
    pisa<-pisa[pisa$sbj==input$selectSubject & pisa$year == 2012 & pisa$grp %in% c(input$checkGroup ), c("grp", "lower", "middle", "high")]
    pisa<-melt(pisa)
    n4 <- nPlot("grp","value", group="variable", pisa, type="multiBarChart")
    n4$set(dom = "socioEconomicPlot", width=500)
    n4$chart(showControls = FALSE)  
    n4$yAxis(tickFormat = "#!  function(y) {return y.toFixed(0)} !#")
    return(n4)
  })


  output$dataTable <- renderDataTable({    
    dataTable<-pisa[, input$show_vars, drop = FALSE]

    if(input$selectTableYear != "All"){
      dataTable<-dataTable[dataTable$year == input$selectTableYear, input$show_vars, drop = FALSE]

    }

    if(input$selectTableSubject != "All"){
      dataTable<-dataTable[dataTable$sbj==input$selectTableSubject, input$show_vars, drop = FALSE]

    }

    if(input$selectTableGroup != "All"){
      dataTable<-dataTable[dataTable$grp==input$selectTableGroup, input$show_vars, drop = FALSE]

    }
    
    dataTable

  })

})
