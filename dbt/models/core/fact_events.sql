{{ config(materialized="table") }}

with
    events_data as (select * from {{ ref("stg_staging__events") }}),
    matches_data as (select * from {{ ref("stg_staging__matches") }})
select
    concat(m.season, ' ', m.competition) as competition,
    m.match_id,
    home_team,
    away_team,
    home_score,
    away_score,
    home_managers,
    away_managers,
    competition_stage,
    stadium,
    referee,
    duration,
    minute,
    foul_committed_card,
    foul_committed_penalty,
    foul_committed_type,
    pass_goal_assist,
    pass_recipient,
    pass_technique,
    pass_type,
    period,
    play_pattern,
    player,
    player_id,
    position,
    team,
    type,
    shot_outcome,
    shot_type,
    shot_technique,
    shot_statsbomb_xg,
    duel_outcome
from matches_data m
join events_data e on m.match_id = e.match_id
where period <> 5