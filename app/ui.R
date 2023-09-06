shinyUI(
  navbarPage(
    theme = shinythemes::shinytheme("sandstone"),
    title = "The Mining Stock Scale",
    tabPanel(
      title = "Adjust your mining stocks",
      wellPanel(
        sliderInput(inputId = "grade_1",
                    label = "Weight on Grade 1",
                    min = 0,
                    max = 20, 
                    step = 1,
                    value = 10),
        sliderInput(inputId = "grade_2",
                    label = "Weight on Grade 2",
                    min = 0,
                    max = 20,
                    step = 1,
                    value = 7),
        sliderInput(inputId = "grade_3",
                    label = "Weight on Grade 3",
                    min = 0,
                    max = 6, 
                    step = 0.6,
                    value = 0.6)
      ),
      plotOutput("plot", brush = "selected_points"),
      br(),
      DT::dataTableOutput("plot_data_table"),
      br(),
      br(),
      downloadButton(outputId = "download_bt", "Download Table")
    ),
    tabPanel(
      title = "Documentation",
      h3("Video documentation - Embedded from Youtube"),
      br(),
      tags$iframe(src = "https://www.youtube.com/embed/vySGuusQI3Y",
                  style = "width: 900px; height: 450px")
    ),
    tabPanel(title = "Data table with underlying data",
             tags$style(
               HTML(
                 "table.display.dataTable > tbody > tr.selected > *,
                  table.display.dataTable > tbody > tr.odd.selected > *,
                  table.display.dataTable > tbody > tr.selected:hover > *  {
                          box-shadow: inset 0 0 0 9999px #7eb6e0 !important;
                          color: #333;
                          background-color: #FFFFFF;
                            }"
               )
             ), 
             DT::dataTableOutput("data_table"))
  )
)
