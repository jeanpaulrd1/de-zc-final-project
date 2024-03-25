{{
    config(
        materialized='table',
        partition_by={
           "field": "match_id",
           "data_type": "int64",
           "range": {
                "start": 3857254,
                "end": 3869685,
                "interval": 20
        }
    }
    )
}} 

WITH home_team_shout_outcome AS(
SELECT
    match_id
    ,home_team
    ,team as player_team
    ,Saved as saved_shot
    ,Blocked as blocked_shot
    ,`Off T` as off_target_shot 
    ,Goal as goal_shot
    ,Post as post_shot
    ,Wayward as wayward_shot
    ,`Saved Off Target` as saved_off_target_shot
    ,`Saved to Post` as saved_to_post_target
FROM (SELECT shot_outcome,team,match_id,home_team FROM {{ ref('fact_events') }}) 
PIVOT ( 
    count(*) FOR shot_outcome IN ('Saved','Blocked','Off T','Goal','Post','Wayward','Saved Off Target','Saved to Post'))
    WHERE team = home_team
 ),
 away_team_shout_outcome AS(
SELECT
    match_id
    ,away_team
    ,team as player_team
    ,Saved as saved_shot
    ,Blocked as blocked_shot
    ,`Off T` as off_target_shot 
    ,Goal as goal_shot
    ,Post as post_shot
    ,Wayward as wayward_shot
    ,`Saved Off Target` as saved_off_target_shot
    ,`Saved to Post` as saved_to_post_target
FROM (SELECT shot_outcome,team,match_id,away_team FROM {{ ref('fact_events') }}) 
PIVOT ( 
    count(*) FOR shot_outcome IN ('Saved','Blocked','Off T','Goal','Post','Wayward','Saved Off Target','Saved to Post'))
    WHERE team = away_team
 ),
 home_team_fouls AS(
SELECT 
    match_id
    ,team as player_team
    ,home_team
    ,`Foul Committed` as foul_committed
FROM (SELECT type,match_id, team,home_team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR type IN ('Foul Committed'))
WHERE team = home_team
 ),
  away_team_fouls AS(
SELECT 
    match_id
    ,team as player_team
    ,away_team
    ,`Foul Committed` as foul_committed
FROM (SELECT type,match_id, team,away_team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR type IN ('Foul Committed'))
WHERE team = away_team
 ),
home_team_cards AS(
SELECT 
         match_id
        ,team as player_team
        ,home_team
        ,`Red Card` as red_card
        ,`Second Yellow` as second_yellow_card
        ,`Yellow Card` as yellow_card
FROM (SELECT foul_committed_card, match_id, team,home_team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR foul_committed_card IN ('Red Card','Second Yellow','Yellow Card'))
WHERE team = home_team
),
away_team_cards AS(
SELECT 
         match_id
        ,team as player_team
        ,away_team
        ,`Red Card` as red_card
        ,`Second Yellow` as second_yellow_card
        ,`Yellow Card` as yellow_card
FROM (SELECT foul_committed_card, match_id, team,away_team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR foul_committed_card IN ('Red Card','Second Yellow','Yellow Card'))
WHERE team = away_team
)
SELECT 
   hto.match_id
   ,hto.player_team as home_team
   ,ato.player_team as away_team
   ,hto.saved_shot as saved_shots_home_team
   ,hto.blocked_shot as blocked_shots_home_team
   ,hto.off_target_shot as off_target_shots_home_team
   ,hto.goal_shot as goal_shots_home_team
   ,hto.post_shot as post_shots_home_team
   ,hto.wayward_shot as wayward_shots_home_team
   ,hto.saved_off_target_shot as saved_off_target_shots_home_team
   ,hto.saved_to_post_target as saved_to_post_target_home_team
   ,ato.saved_shot as saved_shots_away_team
   ,ato.blocked_shot as blocked_shots_away_team
   ,ato.off_target_shot as off_target_shots_away_team
   ,ato.goal_shot as goal_shots_away_team
   ,ato.post_shot as post_shots_away_team
   ,ato.wayward_shot as wayward_shots_away_team
   ,ato.saved_off_target_shot as saved_off_target_shots_away_team
   ,ato.saved_to_post_target as saved_to_post_target_away_team
   ,htf.foul_committed as foul_committed_home_team
   ,atf.foul_committed as foul_committed_away_team
   ,htc.red_card as red_cards_home_team
   ,htc.second_yellow_card as second_yellow_cards_home_team
   ,htc.yellow_card as yellow_cards_home_team
   ,atc.red_card as red_cards_away_team
   ,atc.second_yellow_card as second_yellow_cards_away_team
   ,atc.yellow_card as yellow_cards_away_team
FROM home_team_shout_outcome hto
JOIN away_team_shout_outcome ato on hto.match_id = ato.match_id
JOIN home_team_fouls htf on htf.match_id = ato.match_id 
JOIN away_team_fouls atf on atf.match_id = ato.match_id 
JOIN home_team_cards htc on htc.match_id = ato.match_id 
JOIN away_team_cards atc on atc.match_id = ato.match_id 