library(shiny)
library(datasets)
library(reshape2)
library(ggplot2)
library(markdown)
require(rCharts)

shinyServer(function(input, output, session) {
  
  pisa <- read.csv("data/PISA2012-11--06-2014.csv", head=TRUE, sep=",")  
  
  source("R/dashboard.R", local = TRUE)
  source("R/data.R", local = TRUE)
  
})
