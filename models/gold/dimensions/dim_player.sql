{{
    config(
        materialized = 'table',
        schema = 'silver'
    )
}}
with cte1 as(
    select
    batsman_id,
    batsman_name,
    batsman_dob,
    batsman_nationality,
    batting_hand,
    batsman_role,
    batsman_email,
    batsman_phone,
    batsman_icc_ranking,
    contract_id,
    contract_grade,
    annual_retainer_usd,
    contract_status
from  {{ ref('stg_matchdata')}}),
cte2 as (
    select
    bowler_id,
    bowler_name,
    bowler_nationality,
    bowling_style,
    bowler_icc_ranking
    from {{ ref('stg_matchdata') }}
)
select
    cte1.batsman_id as player_id,
    coalesce(cte1.batsman_name, cte2.bowler_name) as player_name,
    coalesce(cte1.batsman_nationality, cte2.bowler_nationality) as nationality,
    coalesce(cte1.batting_hand, cte2.bowling_style) as style,
    cte1.batsman_dob as player_dob,
    cte1.batsman_role as player_role,
    cte1.batsman_email as player_email,
    cte1.batsman_phone as player_phone,
    coalesce(cte1.batsman_icc_ranking, cte2.bowler_icc_ranking) as player_icc_ranking,
    cte1.contract_id as player_contract,
    cte1.contract_grade as player_contract_grade,
    cte1.annual_retainer_usd as player_annual_usd,
    cte1.contract_status as player_contract_status

from cte1
full outer join cte2
on cte1.batsman_id = cte2.bowler_id;


