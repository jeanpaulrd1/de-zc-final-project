# Fifa World Cup Qatar 2022 Analysis⚽🥇
<!--<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/ece80d35-1db3-4591-9920-ccc62f4606f6" width="30%" align="center"/>
</p>-->

## Overview
This project was developed as part of [Data Engineering Zoomcamp 2024](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main), aiming to build an end-to-end datapipeline.
To do that, I chose the 2022 FIFA World Cup open data provided by [Stats Bomb](https://statsbomb.com/news/statsbomb-release-free-2022-world-cup-data/), which includes detailed events from 64 matches.
## About dataset
Stats Bomb provides [competitions](https://github.com/statsbomb/open-data/blob/master/data/competitions.json), [matches](https://github.com/statsbomb/open-data/tree/master/data/matches), [lineups](https://github.com/statsbomb/open-data/tree/master/data/lineups) and [events](https://github.com/statsbomb/open-data/tree/master/data/events) data. 
- Competitions: Gets a list of available competitions.Check [here](https://github.com/statsbomb/open-data/blob/master/doc/Open%20Data%20Competitions%20v2.0.0.pdf) a detailed description of each field. 
- Lineups: Gets lineup of each match. Check [here](https://github.com/statsbomb/open-data/blob/master/doc/Open%20Data%20Lineups%20v2.0.0.pdf) a detailed description of each field. 
- Match: Gets general data (teams, referee, score, stadium and so on) of each match. Check [here](https://github.com/statsbomb/open-data/blob/master/doc/Open%20Data%20Matches%20v3.0.0.pdf) a detailed description of each field. 
- Events: Gets detailed events data of each match. Check [here](https://github.com/statsbomb/open-data/blob/master/doc/Open%20Data%20Events%20v4.0.0.pdf) a detailed description of each field.

I just used competitions, matches and events data for this project. 
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/d54aae73-a9c8-4cd9-9d70-a246ceb76422" width="30%" align="center"/>
</p>

## Problem description
Basically, main purpose of this project is try to understand what happened in World Cup Qatar 2022 matches trough data. 
1. Why did Messi win the World Cup Ballon d'Or?
2. Why did Morocco and Croatia have a great performance in the World Cup based on their defense?
3. What is the position with the most stoppage injuries?

## Project architecture
Stats Bomb make available a [Python library](https://github.com/statsbomb/statsbombpy), to access data more easily. So that, I used data pulled from there as source for this project.

First the competitions data is obtained, then the matches data and used to filter the world cup match events.
Once we have the data, it's loaded as is into Google Cloud storage bucket and also applied some cleansing and transformation process before to be loaded into BigQuery tables.
Looking for a way to orchestrate all this, a Mage data pipeline was developed that includes all the steps for each table mentioned above (competitions, matches and events).

With the data loaded into BigQuery tables a DBT pipeline was developed, there I just used events and matches data, creating views in staging layer for each of them. Then, both were merged into fact_events table
and based on this, two aggregated tables were created dm_events_per_match and dm_events_per_player. Which were used in the dashboard developed in Looker.

It is important to mention that a Terraform script was used to programmatically create GCP resources (BigQuery datasets and GCS bucket) and Mage was run from the Docker image.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/d3a76531-7c8e-456c-aa20-3c172e45abad" width="80%" align="center"/>
</p>

## Dashboard
If you want to check the dashboard, [click here](https://lookerstudio.google.com/s/kyxZIS-S-OM).

Here we have 5 tiles:
- Direct influence on goals per player: The aim is to know the importance of a player for his team based on his influence on the goals scored.
- Events per match: A quick summary of events by match.
- Injury Stoppage per player: Looking for player with hightest injury stoppage or "wasting times" number.
- Defensive actions per player: A quick summary of defensive actions per player including Interceptions, Clearance, Pressure and Ball recovery
- Fouls and card per player: Looking for most dirtiest players during Fifa World Cup Qatar 2022.
  
![image](https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/6afc967e-1c80-48b0-af0d-47027d220501)

## Reproduce project

If you want to reproduce the project, you can find all the steps [here](https://github.com/jeanpaulrd1/de-zc-final-project/blob/main/reproduce.md)

## Conclusion
Just to answer previously asked questions
1. Why did Messi win the World Cup Ballon d'Or?
   The panel shows us Messi's direct influence on goals and assists throughout the World Cup, in reality he has the same amount as Mbappé, but he won the cup and that gives him an advantage.
2. Why did Morocco and Croatia have a great performance in the World Cup based on their defense?
   If we take a look Defensive actions and fould and cards tiles, we can notice that most of the players there are from Croatia and Morocoo, so it gives you an idea of what a great defensive performance both teams had during the World Cup and that led them to got 3rd   
   and 4th place respectively.
3. What is the position with the most stoppage injuries?
   We can notice that the most common position in the stoppage injuries tile is goalkeeper, it gives you an idea that it is a common time wasting strategy by the goalkeepers.
