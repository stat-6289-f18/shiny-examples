library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(ggplot2)

senate_data <- read.csv("august_senate_polls.csv")

function(input, output, session) {

  ## Interactive Map ###########################################

  # Create the map
  # output$map <- renderLeaflet({
  #   leaflet() %>%
  #     addTiles(
  #       urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
  #       attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
  #     ) %>%
  #     setView(lng = -93.85, lat = 37.45, zoom = 4)
  # })
  #
  # observe({
  #   leafletProxy("map", data = zipdata) %>%
  #     clearShapes() %>%
  #     addCircles(~longitude, ~latitude, radius=radius, layerId=~zipcode,
  #       stroke=FALSE, fillOpacity=0.4, fillColor=pal(colorData)) %>%
  #     addLegend("bottomleft", pal=pal, values=colorData, title=colorBy,
  #       layerId="colorLegend")
  # })

  ## Data Explorer ###########################################
  senate <- reactive({df <- senate_data %>%
    select(cycle,state,error) %>%
    filter(state %in% input$states)
  df
  }
  )

  output$ziptable <- DT::renderDataTable({
    DT::datatable(senate(), escape = FALSE)
  })

  output$Boxplot <- renderPlot({
    ggplot(senate(),aes(x=cycle,y=error, group=cycle))+geom_boxplot()
  })


}
