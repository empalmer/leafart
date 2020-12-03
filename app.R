#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
library(magrittr)
library(tibble)
library(tidyr)
library(purrr)
#library(leafart)
devtools::load_all()

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Leaves"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("nleaves",
                        "Number of leaves:",
                        min = 1,
                        max = 50,
                        value = 20),
            selectInput(
                "scale"
                , "Enter scale values"
                , selected = c(.8,.9)
                , choices = seq(.1,2,.1)
                , multiple = TRUE
                #, options = list(create = TRUE)
            ),
            selectizeInput(
                "angle"
                , "Enter angle values"
                , selected = c(-10,0,10)
                , choices = seq(-180,180,10)
                , multiple = TRUE
                #, options = list(create = TRUE)
            ),
            numericInput(
                "split",
                "Enter the number of splits",
                value = 3,
                min = 1,
                max = 20
            ),
            numericInput(
                "n_grow_iter",
                "Enter the number layers to grow",
                value = 6,
                min = 1,
                max = 10
            )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("leafplot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$leafplot <- renderPlot({
        list(nleaves = input$nleaves,
             ndistinct = 1,
             seed = 286,
             n_grow_iter = input$n_grow_iter,
             scale = as.numeric(input$scale),
             angle = as.numeric(input$angle),
             split = input$split,
             init_location = "random") %>%
            create_leaf_pile() %>%
            plot_leaves()

    })
}

# Run the application
shinyApp(ui = ui, server = server)
