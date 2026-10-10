{{
    config(
        materialized = 'table',
        schema = 'Gold'
    )
}}
with cte as (select
match_id,
match_date,
match_format,
tournament_name,
season,
match_stage,
toss_decision,
batting_team_id,
batting_team_name,
bowling_team_id,
bowling_team_name
from {{ ref('stg_matchdata') }}
where match_id IS NOT NULL
QUALIFY ROW_NUMBER() OVER (
        PARTITION BY match_id
        ORDER BY match_id
    ) = 1
)
select 
md5(match_id) as match_key,
match_id,
match_date,
match_format,
tournament_name,
season,
match_stage,
toss_decision,
batting_team_id,
batting_team_name,
bowling_team_id,
bowling_team_name
from cte;