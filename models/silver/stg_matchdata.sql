{{
    config(
        materialized = 'table',
        schema = 'Silver'
    )
}}
with cte as(
    select * from {{ source('bronze','MATCH_DATA') }}
)
select
        TRIM(delivery_id) as delivery_id,
        TRY_TO_TIMESTAMP_NTZ(NULLIF(delivery_timestamp,'')) as delivery_timestamp,
        NULLIF(innings_no,'') as innings_no,
        NULLIF(over_no,'') as over_no,
        NULLIF(ball_in_over,'') as ball_in_over,
        NULLIF(runs_off_bat,'') as runs_off_bat,
        NULLIF(extra_type,'') as extra_type,
        NULLIF(extra_runs,'') as extra_runs,
        NULLIF(total_runs,'') as total_runs,
        CASE WHEN is_wicket IN ('True','yes','1','Y') THEN TRUE WHEN is_wicket IN('0','no','False','OUT') then FALSE END AS is_wicket,
        TRY_TO_DECIMAL(NULLIF(ball_speed_kmph,'')) as ball_speed_kmph,
        NULLIF(non_striker_id,'') as non_striker_id,
        NULLIF(shot_type,'') as shot_type,
        NULLIF(shot_region,'') as shot_region,
        NULLIF(match_id,'') as match_id,
        TRY_TO_DATE(match_date) as match_date,
        NULLIF(match_format,'') as match_format,
        NULLIF(tournament_name,'') as tournament_name,
        NULLIF(season,'') as season,
        NULLIF(match_stage,'') as match_stage,
        NULLIF(toss_decision,'') as toss_decision,
        UPPER(NULLIF(venue_id,'')) as venue_id,
        INITCAP(NULLIF(venue_name,'')) as venue_name,
        TRIM(NULLIF(venue_city,'')) as venue_city,
        NULLIF(venue_country, '') as venue_country,
        UPPER(NULLIF(batting_team_id,'')) as batting_team_id,
        NULLIF(batting_team_name,'') as batting_team_name,
        UPPER(NULLIF(bowling_team_id,'')) AS bowling_team_id,
        TRIM(INITCAP(NULLIF(bowling_team_name,''))) AS bowling_team_name,
        UPPER(NULLIF(batsman_id,'')) AS batsman_id,
        INITCAP(TRIM(NULLIF(batsman_name,''))) as batsman_name,
        TRY_TO_DATE(NULLIF(batsman_dob,'')) AS batsman_dob,
        NULLIF(batsman_nationality,'') AS batsman_nationality,
        NULLIF(batting_hand,'') AS batting_hand,
        NULLIF(batsman_role,'') AS batsman_role,
        CASE WHEN LOWER(batsman_email) LIKE '%@%' THEN LOWER(batsman_email) ELSE 'INVALID EMAIL' END AS batsman_email,
        CASE WHEN LEN(batsman_phone) > 10 THEN 'INVALID NUMBER' ELSE batsman_phone END AS batsman_phone,
        NULLIF(batsman_icc_rating,'') AS batsman_icc_rating,
        UPPER(NULLIF(bowler_id,'')) AS bowler_id,
        NULLIF(bowler_name,'') AS bowler_name,
        NULLIF(bowler_nationality,'') AS bowler_nationality,
        NULLIF(bowling_style,'') AS bowling_style,
        NULLIF(bowler_icc_rating,'') AS bowler_icc_rating,
        NULLIF(contract_id,'') AS contract_id,
        NULLIF(contract_grade,'') AS contract_grade,
        TRY_TO_DECIMAL(NULLIF(annual_retainer_usd,'')) AS annual_retainer_usd,
        NULLIF(contract_status,'') AS contract_status,
        NULLIF(drs_review_id,'') AS drs_review_id,
        NULLIF(drs_reviewed_by,'') AS drs_reviewed_by,
        NULLIF(drs_original_decision,'') AS drs_original_decision,
        NULLIF(drs_outcome,'') AS drs_outcome

        from cte;