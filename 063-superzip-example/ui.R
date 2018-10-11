library(leaflet)

# Choices for drop-downs
navbarPage("Superzip", id="nav",
           tabPanel("Boxplot",
                    plotOutput("Boxplot")),
           tabPanel("Data explorer",
                    fluidRow(
                      column(3,
                             selectInput("states",
                                         "States",
                                         c("All states"="", structure(state.abb, names=state.name), "Washington, DC"="DC"), multiple=TRUE)
                      )
                    ),
                    hr(),
                    DT::dataTableOutput("ziptable")
           ),

           conditionalPanel("false", icon("crosshair"))
)
