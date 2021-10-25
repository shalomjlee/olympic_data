#dependencies
library(shiny)
library(shinydashboard)
library(tidyverse)
library(treemapify)
library(fresh)
# library(viridis)

#import data
#athlete data
olympic_df <- read.csv('data/athlete_events_clean.csv')
athletes_medals <- read.csv('data/athletes_medals.csv')

#add NOC code data
country_dict <- read.csv('data/country_definitions.csv', header = T) %>%
  select(NOC, region)

olympic_df <- olympic_df %>%
  group_by(NOC) %>% 
  merge(country_dict, by = 'NOC')

#factorize column for faceting
olympic_df$sex <- as.factor(olympic_df$sex)

#create df for athletes; remove duplicate entries for same athletes in the same year
athlete_df <- olympic_df %>% 
  distinct(id, year, .keep_all = T)

#create df for medals; remove duplicate medals for the same event in the same year
medal_df <- olympic_df %>% 
  distinct(year, event, medal, .keep_all = T) %>% 
  filter(medal != 'No Medal')


#begin server build
server <- function(input, output, session){
  
  #========== BEGIN CODE FOR TAB 2 ==========
  #ht/wt scatter for all
  country_filter_all <- reactive({
    athlete_df %>%
      filter(region == input$country_input)
  }) #end ht/wt df
  
  #ht/wt scatter for medalists
  country_filter_m <- reactive({
    athlete_df %>%
      filter(
        region == input$country_input,
        medal != 'No Medal'
      )
  }) #end ht/wt df for medalists
  
  #ht/wt scatter plot for all
  output$scatter_all <- renderPlot({
    ggplot(data = country_filter_all()) + 
      geom_point(
        mapping = aes(
          x = height,
          y = weight,
          color=sex
        )) + 
      geom_smooth(
        mapping = aes(
          x = height, 
          y = weight, 
          color=sex
        ), 
        method = "lm", 
        se = FALSE) +  
      labs(title = "Height vs. Weight of All Olympians")
  }) #end ht/wt scatter plot for all
  
  #ht/wt scatter plot for medalists
  output$scatter_medal <- renderPlot({
    ggplot(data = country_filter_m()) + 
      geom_point(
        mapping = aes(
          x = height, 
          y = weight, 
          color=sex
        )) + 
      geom_smooth(
        mapping = aes(
          x = height, 
          y = weight, 
          color=sex
        ), 
        method = "lm", 
        se = FALSE) +  
      labs(title = "Height vs. Weight of Medalists")
  }) #end ht/wt scatter plot for medalists
  
  #age histogram df
  noc_time_filter <- reactive({
    if (input$time_input == 'before 1990'){
      athlete_df %>%
        filter(
          region == input$country_input,
          year < 1990
        )
    } else if (input$time_input == '1990 and after'){
      athlete_df %>%
        filter(
          region == input$country_input,
          year >= 1990
        )
    }
  }) #end age histogram df
  
  #age histogram plot
  output$hist_age <- renderPlot({
    ggplot(noc_time_filter()) +
      geom_histogram(
        aes(
          age,
          fill = sex
        ),
        color = 'black',
        bins = 20
      )
  }) #end age histogram plot
  
  #total athlete counts
  country_filter_count <- reactive({
    athlete_df %>%
      filter(
        region == input$country_input,
        season == input$season_input
      ) %>% 
      group_by(year) %>% 
      summarize(count = n_distinct(name))
  }) #end input filter
  
  #total athlete counts plot
  output$line_all <- renderPlot({
    ggplot(country_filter_count()) +
      geom_line(aes(year, count))
  }) #end total athlete plot
  
  #total athlete counts + gender facet
  sex_facet <- reactive({
    athlete_df %>%
      filter(
        region == input$country_input,
        season == input$season_input
      ) %>% 
      group_by(year, sex) %>% 
      summarize(count = n_distinct(name))
  }) #end input filter
  
  #total athlete counts + gender facet plot
  output$line_facet <- renderPlot({
    ggplot(sex_facet()) +
      geom_line(aes(year, count)) +
      facet_grid(rows = vars(sex)) +
      labs(title = 'faceted by gender')
  }) #end gender facet plot
  
  #========== BEGIN CODE FOR TAB 3 ==========
  
  #athlete v medal scatter df
  cleaned_olympics_filtered3 <- reactive({
    athletes_medals %>%
      filter(season == input$choice3) %>% 
      filter(year ==input$choice4)
  }) #end athlete v medal df
  
  #athlete v medal scatter plot
  output$scatter_ath <- renderPlot({
    ggplot(data = cleaned_olympics_filtered3(), aes(athletes, medals)) + 
      geom_point(mapping = aes(color = region)) +
      labs(x="Number of Athletes", y="Number of Medals Won") +
      theme(legend.position = "none") + 
      geom_smooth(mapping = aes(x=athletes, y=medals, color = "green"), method = "lm", se = FALSE)
  }) #end athlete v medal scatter plot
  
  #athlete v medal extra info
  output$brush_info <- renderPrint({
    n = nrow(brushedPoints(cleaned_olympics_filtered3(), brush = input$p3_brush))
    if(n==0)
      return()
    else
      brushedPoints(cleaned_olympics_filtered3(), brush = input$p3_brush)
  }) #end athlete v medal extra info
  
  #treemap df
  treemap_df <- reactive({
    olympic_df %>%
      filter(season == input$choice3) %>% 
      filter(year == input$choice4) %>% 
      group_by(sport) %>% 
      summarise(events = n_distinct(event))
  }) #end treemap df
  
  #treemap plot
  output$treemap <- renderPlot({
    ggplot(data = treemap_df(), aes(area=events, fill=sport, label=paste(sport, events))) +
      geom_treemap() +
      geom_treemap_text(color = "white",
                        place = "center",
                        size = 20) +
      # scale_fill_viridis(
      #   option = 'D',
      #   discrete = TRUE
      # ) +
      theme(legend.position = "none")
    #scale_fill_brewer(palette = "GnBu")
  }) #end treemap plot
  
  #medal breakdown line df
  count_medal_filter <- reactive({
    medal_df %>%
      filter(
        region == input$country_input2,
        season == input$season_input_medals
      ) %>%
      count(year, medal) %>%
      pivot_wider(names_from = medal, values_from = n)
  }) #end medal lines df
  
  #medal line plot * 3
  output$line_medals <- renderPlot({
    ggplot(count_medal_filter()) +
      geom_line(
        aes(year, Bronze),
        color = 'darkorange4',
        size = 2
      ) +
      geom_line(
        aes(year, Silver),
        color = 'grey44',
        size = 2
      ) +
      geom_line(
        aes(year, Gold),
        color = 'gold2',
        size = 2
      ) +
      labs(y = 'count')
  }) #end medal line plots
  
} #end server


