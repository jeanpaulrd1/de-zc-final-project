{{
    config(
        materialized='table',
        partition_by={
           "field": "player_id",
           "data_type": "int64",
           "range": {
                "start": 2941,
                "end": 348757,
                "interval": 50
        }
    }
    )
}}

WITH shout_outcome_per_player AS(
SELECT
    player
    ,player_id
    ,team as player_team
    ,Saved as saved_shot
    ,Blocked as blocked_shot
    ,`Off T` as off_target_shot 
    ,Goal as goal_shot
    ,Post as post_shot
    ,Wayward as wayward_shot
    ,`Saved Off Target` as saved_off_target_shot
    ,`Saved to Post` as saved_to_post_target
FROM (SELECT shot_outcome, player, player_id, team FROM {{ ref('fact_events') }}) 
PIVOT ( 
    count(*) FOR shot_outcome IN ('Saved','Blocked','Off T','Goal','Post','Wayward','Saved Off Target','Saved to Post'))
 ),
event_type_per_player AS(
SELECT 
    player
    ,player_id
    ,Duel as duel
    ,Pressure as pressure
    ,`Foul Won` as foul_won
    ,`Ball Recovery` as ball_recovery
    , Interception as interception
    ,Pass as pass
    ,Clearance as clearance
    ,`Foul Committed` as foul_committed
    ,`Injury Stoppage` as injury_stoppage
    ,`Dribble` as dribble
FROM (SELECT type, player, player_id, team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR type IN ('Duel','Pressure','Foul Won','Ball Recovery','Interception','Pass','Clearance','Foul Committed','Injury Stoppage','Dribble'))
 ),
duel_outcome_per_player AS(
SELECT 
        player
        ,player_id
        ,`Success Out` as succes_out_duel
        ,`Lost in Play` as lost_in_play_duel
        ,`Success In Play` as succes_in_play_duel
        ,`Won` as won_duel
        ,`Lost Out` as lost_out_duel
FROM (SELECT duel_outcome, player, player_id, team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR duel_outcome IN ('Success Out','Lost In Play','Success In Play','Won','Lost Out'))
),
card_per_player AS(
SELECT 
        player
        ,player_id
        ,`Red Card` as red_card
        ,`Second Yellow` as second_yellow_card
        ,`Yellow Card` as yellow_card
FROM (SELECT foul_committed_card, player, player_id, team FROM {{ ref('fact_events') }}) 
PIVOT ( 
count(*) FOR foul_committed_card IN ('Red Card','Second Yellow','Yellow Card'))
),
player_positions AS(
SELECT 
        player_id
        ,MAX(position) as position
FROM {{ ref('fact_events') }}
GROUP BY player_id
)
SELECT 
    so.player_id
    ,so.player
    ,so.player_team
    ,so.saved_shot
    ,so.blocked_shot
    ,so.off_target_shot
    ,so.goal_shot
    ,so.post_shot
    ,so.wayward_shot
    ,so.saved_off_target_shot
    ,so.saved_to_post_target
    ,et.duel
    ,et.pressure
    ,et.foul_won
    ,et.ball_recovery
    ,et.interception
    ,et.pass
    ,et.clearance
    ,et.foul_committed
    ,et.injury_stoppage
    ,et.dribble
    ,dp.succes_out_duel
    ,dp.lost_in_play_duel
    ,dp.succes_in_play_duel
    ,dp.won_duel
    ,dp.lost_out_duel
    ,cp.yellow_card
    ,cp.second_yellow_card
    ,cp.red_card
    ,pp.position
FROM shout_outcome_per_player so
JOIN event_type_per_player et on so.player_id = et.player_id
JOIN duel_outcome_per_player dp on so.player_id = dp.player_id
JOIN card_per_player cp on cp.player_id = so.player_id
JOIN player_positions pp on et.player_id = pp.player_id