output$data <- renderUI({
	sidebarLayout(

		sidebarPanel(width=3,
			selectInput("selectTableYear", "Year", c("All", unique(as.character(pisa$year)))), 
			selectInput("selectTableSubject", "Subject", c("All", unique(as.character(pisa$sbj)))), 
      selectInput("selectTableTopic", "Topic", c("All", unique(as.character(pisa$topic)))), 
			selectInput("selectTableGroup", "Group", c("All", unique(as.character(pisa$grp)))), 
   #checkboxGroupInput("show_vars", label = "Columns to show:", 
    # choices = names(pisa), selected = list("year", "sbj", "topic", "grp", "mean", "men", "women")),

			selectInput('show_vars', 'Columns to show', names(pisa), multiple=TRUE, selectize=FALSE, selected = list("year", "sbj", "topic", "grp", "mean", "men", "women"))
			),
		mainPanel(wellPanel(
			dataTableOutput("dataTable")
      )
			)
	)
})


output$dataTable <- renderDataTable({ 

	output$show_vars <- renderPrint(input$show_vars)
	dataTable<-pisa[, input$show_vars, drop = FALSE]

	if(input$selectTableYear != "All"){
		dataTable<-dataTable[dataTable$year == input$selectTableYear, input$show_vars, drop = FALSE]
	}

	if(input$selectTableSubject != "All"){
    
	  #choices =  unique(as.character(pisa$topic[c(pisa$sbj==input$selectSubject)])), 
	  
    
		dataTable<-dataTable[dataTable$sbj==input$selectTableSubject, input$show_vars, drop = FALSE]
	}

    if(input$selectTableTopic != "All"){
      dataTable<-dataTable[dataTable$topic==input$selectTableTopic, input$show_vars, drop = FALSE]
    }

	if(input$selectTableGroup != "All"){
		dataTable<-dataTable[dataTable$grp==input$selectTableGroup, input$show_vars, drop = FALSE]
	}

	dataTable

})








