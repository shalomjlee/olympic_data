# Olympic Athlete Data Analysis
**_Created by [Maria Dong](https://github.com/mariajdong), [Jess Izumi](https://github.com/jess-izuu), & [Shalom Lee](https://github.com/shalomjlee)._**

An [R Shiny dashboard](https://rstudio.github.io/shinydashboard/) that analyzes Olympic athlete data from 1896 to 2016. Attributes analyzed include age, sex, team, year/season of games, medals, and more.

<br>

![screenshot1](/images/screenshot1.png)
_Figure 1: A screenshot of the dashboard landing page._

## Background
The [Olympic Games](https://en.wikipedia.org/wiki/Olympic_Games) are the most prominent and celebrated series of international sporting events, in which athletes around the world compete. We wanted to further explore data around these athletes, dating back to 1896, when the first modern Olympics was held.

## Getting Started
*To view the dashboard, you must download the Open Source Edition of [R Studio](https://www.rstudio.com/products/rstudio/), available for free [here](https://www.rstudio.com/products/rstudio/).*

1. Download the repo in your preferred manner.
2. Open `olympic_dash.R` in R Studio.
3. Click `Run App` at the top right-hand corner of the file display.

![screenshot2](/images/screenshot2.png)

4. Once the dashboard window opens, maximize the window for optimal viewing.

## Resources, Libraries, & Tools
**Data Sources**
* [Kaggle](https://www.kaggle.com/mysarahmadbhat/120-years-of-olympic-history) for Olympic athlete data
* [Getty Images](https://www.gettyimages.com/) for landing page pictures
* [Google Fonts](https://fonts.google.com/) for custom fonts

**Libraries**
* [R Shiny](https://shiny.rstudio.com/) and [Shiny Dashboard](https://rstudio.github.io/shinydashboard/) to build an interactive web application in a dashboard format
* [Tidyverse](https://www.tidyverse.org/) for data manipulation and cleaning
* [Treemapify](https://cran.r-project.org/web/packages/treemapify/vignettes/introduction-to-treemapify.html) for treemap plotting
* [Fresh](https://github.com/dreamRs/fresh) for dashboard formatting

**Tools & languages**: R, HTML, CSS, [R Studio](https://www.rstudio.com/products/rstudio/)

## Features
After launching the dashboard, you should see a homepage featuring pictures and fun facts about the Olympics and its history.

<br>

The next tab, titled *Athlete Demographics by Team*, explores athlete demographic variables by country selected.

![country_input](/images/t2input.png)
_Figure 2: An interactive dropdown menu that changes all graphics on the tab._

![age_hist](/images/t2v2.png)
_Figure 3: An example of a visualization on this tab. More interactivity may be offered for specific visualizations, as with the radio buttons pictured in the top right._

<br>

Finally, the last tab, titled *Events, Medals, & Trends*, delves more into Olympic medals and events. First, the user needs to select an Olympic year and season.

![medal_input](/images/t3input.png)
_Figure 4: A slider and radio buttons for user input._ 

The visuals will respond if applicable, and may offer more interactivity, as before.

![medal_scatter](/images/t3v1.png)
_Figure 5: An example of a visualization on this tab. A scatter plot and trendline visualizing correlation between number of athletes and medals won for a specific year's Olympic Games. Users can draw a box around points of interest in the plot, and additional information about those points will populate in the box to the right._

## Analyses & Discussion

## Future Considerations