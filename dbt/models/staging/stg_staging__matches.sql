{{
    config(
        materialized='view'
    )
}}
with 

source as (

    select * from {{ source('staging', 'matches') }}

),

stg_matches as (

    select
        match_id,
        match_date,
        kick_off,
        competition,
        season,
        home_team,
        away_team,
        home_score,
        away_score,
        home_managers,
        away_managers,
        competition_stage,
        stadium,
        referee

    from source

)

select * from stg_matches
