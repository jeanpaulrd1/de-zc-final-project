with 

source as (

    select * from {{ source('staging', 'competitions') }}

),

renamed as (

    select
        competition_id,
        season_id,
        country_name,
        competition_name,
        competition_gender,
        competition_international,
        season_name

    from source

)

select * from renamed
