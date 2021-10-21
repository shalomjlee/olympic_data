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

#customize theme
custom_theme <- create_theme(
  adminlte_color(
    light_blue = "#43848B"
  ),
  
  adminlte_sidebar(
    dark_bg = "#536061",
    dark_hover_bg = "#404849"
  ),
  
  adminlte_global(
    content_bg = "#E7E7E7"
  )
)
#begin page build
ui <- dashboardPage(
  
  dashboardHeader(title = "Olympian Analysis"),
  
  #begin sidebar
  dashboardSidebar(
    sidebarMenu(
      id = 'sidebar',
      menuItem("Home", tabName = "t1"),
      menuItem("Athlete Demographics by Team", tabName = "t2"),
      menuItem("Events, Medals, & Trends", tabName = "t3")
      )
  ), #end sidebar
  
  #begin body
  dashboardBody(
    #import fonts
    HTML('<link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Bitter:wght@700&family=Georama:wght@400&display=swap" rel="stylesheet">'
    ),
    
    #use custom theme
    use_theme(custom_theme),
    
    #add css attributes
    tags$style(
      HTML('
      p, * {
        font-family: "Georama", sans-serif;
      }
      
      .skin-blue .main-header .logo,
      h1, h2, h3, h4 {
        font-family: "Bitter", serif;
      }
      
      .picrow {
        display: flex;
        align-items: center;
        padding: 20px;
      }
      
      .Ltext {
        text-align: right;
      }
      
      ')
    ),
  
    #begin tab items
    tabItems(
      
      #first tab: landing
      tabItem(
        tabName = 't1',
        
        #page
        fluidPage(
          
          #title row
          fluidRow(
            
            column(
              width = 12,
              h1('Olympic Athlete Data Analysis'),
              h4('Created by Maria Dong, Jess Izumi, & Shalom Lee'),
              h4(em('Members of Talent Path WRC')),
              br(),
              h3('Welcome to our dashboard!'),
              p('Here, we analyze Olympic athlete data from 1896 to 2016.
                Attributes analyzed include age, sex, team, year/season of games, medals, and more.'),
              HTML('<p>Olympic data was retrieved from <a href="https://www.kaggle.com/mysarahmadbhat/120-years-of-olympic-history">Kaggle</a>.</p>'),
              br(),
              p('Get started by selecting one of the tabs on the left,
                or explore the gallery of pictures below to learn more about the history of the Olympics.'),
              HTML('<p>Photos were provided by <a href="https://www.gettyimages.com/">Getty Images</a>.</p>'),
            )
          ), #end title row
          
          br(),
          
          #L pic row
          fluidRow(
            class = 'picrow',
            
            column(
              width = 7,
              img(
                src = 'https://media.gettyimages.com/photos/empty-seats-are-seen-as-the-olympic-flame-burns-after-the-lighting-of-picture-id1234130838?s=2048x2048',
                width = '100%'
              )
            ),
            
            column(
              class = 'Rtext',
              width = 5,
              h4('The Tokyo 2020 Summer Olympic Games'),
              p('were actually held in Summer of 2021 due to the COVID-19 pandemic.
                Pictured is the Olympic Flame lit for the Olympic Opening Ceremony,
                with visibly empty seats in the stadium.'),
              # p('Though COVID precautions were taken at the games,
              #   the highly contagious Delta variant was responsible for the majority of new COVID cases at the time,
              #   and vaccinations had not been widely available yet.
              #   Protests had persisted for months before the games etc. etc.'),
              p('The Olympic Flame is a symbol derived from ancient Greece, 
                first introduced to the modern Olympic Games in 1928.
                Months before the games, the Olympic Flame is lit in Olympia, Greece,
                which initiates the Olympic torch relay, leading to the lighting of the Olympic cauldron
                at the opening ceremony. The flame is kept burning until the closing ceremony.')
            )
          ), #end L pic row
          
          #R pic row
          fluidRow(
            class = 'picrow',
            
            column(
              class = 'Ltext',
              width = 5,
              h4('Olympic Medals'),
              p('are awarded in gold, silver, and bronze.
                This tradition was introduced at the 1904 Olympics.'),
              p('Gold is awarded to the first place athlete/team,
                silver to the second,
                and bronze to the third.'),
              p('Currently, the United States holds the record for total medals won in Olympic history.')
            ),
            
            column(
              width = 7,
              img(
                src = 'https://media.gettyimages.com/photos/medallions-picture-id115866765?s=2048x2048',
                width = '100%'
              )
            )
          ), #end R pic row
          
          #L pic row
          fluidRow(
            class = 'picrow',
            
            column(
              width = 7,
              img(
                src = 'https://media.gettyimages.com/photos/tommie-smith-and-john-carlos-gold-and-bronze-medalists-in-the-run-at-picture-id514865956?s=2048x2048',
                width = '100%'
              )
            ),
            
            column(
              class = 'Rtext',
              width = 5,
              h4('Two USA Medalists at the 1968 Olympic 200m Run'),
              p('salute on the podium with fists in the air,
                standing in protest against unfair treatment of blacks in the United States.
                Tommie Smith and John Carlos won the gold and bronze medals, respectively.')
            )
          ), #end L pic row
          
          #R pic row
          fluidRow(
            class = 'picrow',
            
            column(
              class = 'Ltext',
              width = 5,
              h4('The Rio 2016 Summer Olympic Closing Ceremony'),
              p('at Rio de Janeiro, Brazil, was a spectacle,
                much like all other recent opening and closing ceremonies.
                Every host city always aims to surpass its predecessor,
                which has resulted in more and more bombastic and grandiose celebrations.')
            ),
            
            column(
              width = 7,
              img(
                src = 'https://media.gettyimages.com/photos/this-picture-shows-an-overview-of-fireworks-during-the-closing-of-picture-id593260754?s=2048x2048',
                width = '100%'
              )
            )
          ), #end R pic row
          
          #L pic row
          fluidRow(
            class = 'picrow',
            
            column(
              width = 7,
              img(
                src = 'https://media.gettyimages.com/photos/shaun-white-of-the-united-states-competes-during-the-snowboard-mens-picture-id917608650?s=2048x2048',
                width = '100%'
              )
            ),
            
            column(
              class = 'Rtext',
              width = 5,
              h4('Shaun White of Team USA'),
              p("competes at the PyeongChang 2018 Winter Olympics
                for the Men's Halfpipe event, where he was awarded gold."),
              p('Initially, the Olympics were only held in the summer;
                the first winter games were held in 1924.')
            )
          ), #end L pic row
          
          #R pic row
          fluidRow(
            class = 'picrow',
            
            column(
              class = 'Ltext',
              width = 5,
              h4("Women's Archery at the 1908 London Olympics"),
              p("features very different attire from that of today's athletes.
                Women were first allowed to participate in the Olympics in 1900.")
            ),
            
            column(
              width = 7,
              img(
                src = 'https://media.gettyimages.com/photos/15th-july-1908-women-archers-participating-in-the-national-round-at-picture-id3303724?s=2048x2048',
                width = '100%'
              )
            )
          ), #end R pic row
          
        ) #end page
      ), #end first tab
      
      #second tab
      tabItem(
        tabName = 't2',
        
        #page
        fluidPage(
          
          #description row
          fluidRow(
            column(
              width = 12,
              h2('Athlete Demographics'),
              p('What does the average Olympic athlete look like?
              How have Olympic team demographics changed over time?
              Start exploring athlete demographic data by selecting a country from the dropdown menu below.')
            )
          ),
          
          #row of input options
          fluidRow(
            #first choice: dropdown menu
            column(
              width = 4,
              selectInput(
                inputId = 'country_input',
                label = 'Choose a Country:',
                selected ='USA',
                choices = sort(unique(athlete_df$NOC))
              ),  
            ),
            #blank column
            column(width = 8)
          ), #end input options
          
          br(), 
          tags$hr(style="border-color: black;"),
          
          fluidRow(
            column(
              width = 12,
              h3('Height vs. Weight Linear Regressions'),
              p('On the selected Olympic team,
                what is the trend between the heights and weights of the athletes?
                Does this trend differ among medalists?
                View the scatter plots and trendlines below, colored by athlete gender.')
            )
          ),
          
          #row for viz
          fluidRow(
            column(
              width = 6,
              plotOutput('scatter_all')
            ),
            column(
              width = 6,
              plotOutput('scatter_medal')
            )
          ), #end viz row
          
          br(), 
          tags$hr(style="border-color: black;"),
          
          #row of title & input options
          fluidRow(
            #title column
            column(
              width = 8,
              h3('Distribution of Age by Gender')
            ),
            #input: year radio buttons
            column(
              width = 4,
              radioButtons(
                inputId = 'time_input',
                label = 'Choose a Period of Time:',
                choices = c('before 1990', '1990 and after')
              )
            )
          ), #end input options
          
          br(),
          
          fluidRow(
            column(
              width = 12,
              p("How are athletes' ages distributed?
                The stacked bar histogram below depicts overall age distribution for the selected team,
                and divides into male and female athletes.
                Compare distribution for athletes competing before and after 1990 via the radio buttons.")
            )
          ),
          
          #row for viz
          fluidRow(
            column(
              width = 12,
              plotOutput('hist_age')
            )
          ), #end viz row
          
          br(), 
          tags$hr(style="border-color: black;"),
          
          fluidRow(
            #title column
            column(
              width = 8,
              h3('Number of Athletes Over Time'),
              
            ),
            #input: season radio buttons
            column(
              width = 4,
              radioButtons(
                inputId = 'season_input',
                label = 'Choose a Season:',
                choices = sort(unique(athlete_df$season))
              )
            ) #end input options
          ),
          
          fluidRow(
            column(
              width = 12,
              p('How has the total number of Olympic athletes changed for different countries and seasons?
                The line charts on the right facet the left chart into counts of female and male athletes.
                Change the season via the radio buttons above.')
            )
          ),
          
          #row for viz
          fluidRow(
            column(
              width = 6,
              plotOutput('line_all')
            ),
            column(
              width = 6,
              plotOutput('line_facet')
            )
          ) #end viz row
        ) #end page
      ), #end second tab
      
      
      #third tab
      tabItem(
        tabName = "t3",
        fluidPage(
          
          fluidRow(
            column(
              width = 12,
              h2('Events, Medals, and Trends'),
              p('Here, we explore which teams have earned more (or less) medals over the history of the Olympics,
                and how the Olympic games have evolved substantially over the years.
                Start by selecting a year and season from the options below.'),
              tags$i('The year and season must match to an existing Olympic game.'),
            )
          ),
          
          br(),
          
          fluidRow(
            column( width = 5,
                    box(width = 12,
                        sliderInput(inputId = "choice4",
                                    label = "Choose a Year:",
                                    min = 1896,
                                    max = 2016,
                                    value = 2016,
                                    sep = "",
                                    step = 2))
            ),
            column(width = 1),
            column( width = 4,
                    radioButtons(inputId = "choice3",
                                 label = "Choose a Season:",
                                 choices = sort(unique(olympic_df$season)))
            ),
            column(width = 2)
          ), #end row
          
          tags$hr(style="border-color: black;"),
          
          fluidRow(
            column(
              width = 12,
              h3('Number of Athletes vs. Number of Medals Won'),
              p('If a country has more total athletes, is that country more likely to win more medals?
                The positive correlation between the two variables is likely, as shown in the scatter plot below.')
            )
          ),
          
          fluidRow(
            column(width = 8,
                   plotOutput("scatter_ath", height = 500,
                              #click = "p3_click"),
                              brush = "p3_brush"
                   )
            ),
            column(width = 4,
                   h4("Additional Information"),
                   p('Draw a box around points in the scatter plot to view more details.'),
                   verbatimTextOutput("brush_info"))
          ), #end row
          
          br(),
          tags$hr(style="border-color: black;"),
          
          #treemap title & desc
          fluidRow(
            column(
              width = 12,
              h3('Olympic Events for Selected Year/Season'),
              p("What did events look like for this year's Olympic games?
                View the event category and quantity of events in the treemap below.")
            )
          ), #end treemap title row
          
          #treemap plot
          fluidRow(
            column(
              width = 12,
              plotOutput("treemap", height = 500)
            )
          ), #end treemap plot row
          
          br(), 
          tags$hr(style="border-color: black;"),
          
          fluidRow(
            column(
              width = 12,
              h3('Count of Medals per Country Over Time'),
              p("How has each country's overall medal record fared?
                Select a country and season to view the breakdown of their medals earned.")
            )
          ),
          
          #row for viz 1 - medals per country over time
          fluidRow(
            column(
              width = 3,
              selectInput(
                inputId = 'country_input2',
                label = 'Choose a Country:',
                selected = 'USA',
                choices = sort(unique(medal_df$NOC))
              ),
              radioButtons(
                inputId = "season_input_medals",
                label = "Choose a Season:",
                choices = unique(olympic_df$season))
            ),
            column(
              width = 9,
              plotOutput('line_medals')
            )
          ) #end viz row
          
        ) #end page  
      ) #close third tab
    ) #end tab items
  ) #end body
) #end page


#begin server build
server <- function(input, output, session){
  
  #========== BEGIN CODE FOR TAB 2 ==========
  #ht/wt scatter for all
  country_filter_all <- reactive({
    athlete_df %>%
      filter(NOC == input$country_input)
  }) #end ht/wt df
  
  #ht/wt scatter for medalists
  country_filter_m <- reactive({
    athlete_df %>%
      filter(
        NOC == input$country_input,
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
          NOC == input$country_input,
          year < 1990
        )
    } else if (input$time_input == '1990 and after'){
      athlete_df %>%
        filter(
          NOC == input$country_input,
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
        NOC == input$country_input,
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
        NOC == input$country_input,
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
      labs(x="Number of athletes", y="Number of Medals Won") +
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
        NOC == input$country_input2,
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
  }) #medal line plots
  
} #end server


#run app
shinyApp(ui,server)


