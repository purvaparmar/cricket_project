{{
    config(
        materialized = 'table',
        schema = 'Gold'
    )
}}
with cte as (
    select
        venue_id,
        venue_name,
        venue_city,
        venue_country
from {{ ref('stg_matchdata') }}
where venue_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (
        PARTITION BY venue_id
        ORDER BY venue_id
    ) = 1

)

select
        md5(venue_id) as venue_key,
        venue_id,
        venue_name,
        venue_city,
        venue_country
from cte;