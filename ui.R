library(DT)
library(tidyverse)
library(readxl)
library(gridExtra)
library(ggpubr)


ui <- fluidPage(
  titlePanel("Credit Scoring Prediction"),
  
  sidebarLayout(
    sidebarPanel(
      tags$head(tags$style(".shiny-plot-output{height:100vh !important;}")),
      fileInput("file1", "Choose Excel File",
                multiple = FALSE,
                accept = "xlsx"),
    selectInput("response", "Response Variable:",
                choices = c("Financial Rating", "Qualitative Rating"),
                selected = "Financial Rating"),
    checkboxGroupInput("covariate", "Choose Covariates:",
                c("Qualitative rating about transparency", 
                  "Qualitative rating about shareholder's contribution",
                  "Favourable economic market",
                  "Sector will increase?",
                  "Management Quality",
                  "Hold by a bigger firm",
                  "CEO Involved",
                  "Help from the group on legal",
                  "Assets",
                  "Liability",
                  "Turnover",
                  "EBITDA",
                  "Debt on equity",
                  "Gross Operating Surplus Global Costs",
                  "Gross Operating Surplus Turnover 100"),
                textOutput("number")
    ),
    selectInput("family", "Choose Exponential Family:",
                choices = c("gaussian", "poisson", "binomial",
                            "negative binomial"),
                selected = "gaussian"),
    checkboxInput("buttonlog", "Box plots in log scale?"),
    actionButton("SaveDatabutton","Download data"),
    actionButton("SaveDatabuttonpredict", "Download prediction")
    ),
    
    mainPanel(
      tabsetPanel(
        type = "tabs",
        tabPanel("Data",DT::dataTableOutput("tbl")),
        tabPanel("Scatterplots", plotOutput("pairplot",
                                      width = "100%")),
        tabPanel("Boxplots", plotOutput("boxplot")),
        tabPanel("Histogram", plotOutput("histo") ),
        tabPanel("GAM Plots", plotOutput("gamplot",
                                         width="100%")),
        tabPanel("Model",  verbatimTextOutput("reg")),
        tabPanel("Predictions", tableOutput("pred")),
        tabPanel("Metrics_MSE", tableOutput("MSE"))
      )
    )
  )
)