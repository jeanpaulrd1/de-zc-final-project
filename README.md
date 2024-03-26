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
Stats Bomb make available a Python library [statsbombpy](https://github.com/statsbomb/statsbombpy), to access data more easily. So that, I used data is pulled from there as source for this project.

First the competitions data is obtained, then the matches data and used to filter the world cup match events.
Once we have the data, it's loaded as is into Google Cloud storage bucket and also applied some cleansing and transformation process before to be loaded into BigQuery tables.
Looking for a way to orchestrate all this, a Mage data pipeline was developed that includes all the steps for each table mentioned above (competitions, matches and events).

With the data loaded into BigQuery tables a DBT pipeline was developed, there I just used events and matches data, creating views in staging layer for each of them. Then, both were merged into fact_events table
and based on this, two aggregated tables were created dm_events_per_match and dm_events_per_player. Which were used in the dashboard developed in Looker.

It is important to mention that a Terraform script was used to programmatically create GCP resources (BigQuery datasets and GCS bucket) and Mage was run from the Docker image.
<p align="center">
  <img src="https://github.com/jeanpaulrd1/de-zc-final-project/assets/19482586/d3a76531-7c8e-456c-aa20-3c172e45abad" width="80%" align="center"/>
</p>
