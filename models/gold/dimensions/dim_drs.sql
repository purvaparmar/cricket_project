
{{ 
    config
    (materialized='table', schema='GOLD') 
}}

WITH cte AS (
    SELECT
    drs_review_id,
    drs_reviewed_by,
    drs_original_decision,
    drs_outcome
    from {{ ref('stg_matchdata') }}
    WHERE drs_review_id IS NOT NULL
    QUALIFY ROW_NUMBER() OVER (
        PARTITION BY drs_review_id
        ORDER BY drs_review_id
    ) = 1
)
SELECT
    md5(drs_review_id) as drs_key,
    drs_review_id,
    drs_reviewed_by,
    drs_original_decision,
    drs_outcome
FROM cte;

