{{
    config(
        materialized='view'
    )
}}
with 

source as (

    select * from {{ source('staging', 'events') }}

),

stg_events as (

    select
        id,
        match_id,
        duration,
        foul_committed_card,
        foul_committed_penalty,
        interception_outcome,
        minute,
        pass_goal_assist,
        pass_recipient,
        pass_technique,
        pass_type,
        period,
        play_pattern,
        player,
        player_id,
        position,
        possession,
        possession_team,
        possession_team_id,
        related_events,
        team,
        type,
        shot_outcome,
        shot_statsbomb_xg,
        shot_technique,
        shot_type,
        foul_committed_type,
        duel_outcome
    from source

)

select * from stg_events
