shinyServer(function(input, output) {
  
  output$data_table <-  DT::renderDataTable({
    DT::datatable(data) %>% 
      formatStyle(c("G1", "G2", "G3"),
                    backgroundColor = "#bedaef") %>%
      formatCurrency("MarketCap.in.M", "$", digits = 0)
  })
  
  DataPlot <- reactive({
    g1 <- input$grade_1
    g2 <- input$grade_2
    g3 <- input$grade_3
    
    data %>% 
      dplyr::mutate(Points = g1*G1 + g2*G2 + g3*G3)
  })
  
  DataPlotTable <- reactive({
    req(DataPlot())
    brushedPoints(df = DataPlot(),
                  brush = input$selected_points)
  })
  
  output$plot <- renderPlot ({
    ggplot2::ggplot(DataPlot(), aes(Points, MarketCap.in.M)) +
      geom_point() + geom_smooth(method = "lm") +
      xlab("Your Calculated Score") + ylab("Market Capitalization in Million USD")
  })

  output$plot_data_table <-  DT::renderDataTable({
    df <- DataPlotTable()
      
    shiny::validate(need(nrow(df) > 0, "No records to display"))
    
    DT::datatable(df,
                  selection = "none")
  })
  
  output$download_bt <- downloadHandler(
    filename = "data.csv",
    content = function(file) {
      write.csv(DataPlotTable(), file)
    }
  )
  
})
