# packages
library(tidyverse)
library(shiny)
library(shinythemes)

# data
spooky <- read_csv("spooky_data.csv")

# user interface
# fluidPage makes the page change sizes depending on the browser
ui <- fluidPage(
  # title panel
  titlePanel("A Halloween app!"),
  # sidebar
  sidebarLayout(
    # text that shows up in sidebar panel
    sidebarPanel("These are widgets",
                 # widgets go here
                 # this is a drop down menu
                 # there is a gallery of all the different types of widgets in Shiny

                 # first widget: choose a state
                 selectInput(
                   # give the widget an identifying name
                   inputId = "state_select",
                   # give the widget a label
                   label = "Choose a state:",
                   # give the choices within the widget
                   choices = unique(spooky$state)
                 ),

                 # second widget: radio buttons
                 radioButtons(inputId = "region_select",
                              label = "Choose a region:",
                              choices = unique(spooky$region_us_census)
                              )
                 ),
    # main panel for outputs
    mainPanel("Outputs go here",
              tableOutput(outputId = "candy_table"))
  )
)

# server
server <- function(input, output) {
  # create a reactive dataframe that reacts to user input
  state_candy <- reactive({
    spooky %>%
      # filter data frame by the input from state_select
      filter(state == input$state_select)
  })

  # name the output candy_table
  output$candy_table <- renderTable({
    state_candy()
  })

}

# tell R to create a shiny app from the ui and server from above
shinyApp(ui = ui, server = server)
