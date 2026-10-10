{{ 
    config(
        materialized='table', 
        schema='GOLD'
        ) 
}}

WITH dates AS (
    SELECT DISTINCT delivery_timestamp AS finaldate
    FROM {{ ref('stg_matchdata') }}
    WHERE delivery_timestamp IS NOT NULL
)
SELECT
    TO_NUMBER(TO_CHAR(finaldate, 'YYYYMMDD')) AS DATE_KEY,
    finaldate AS FULL_DATE,
    YEAR(finaldate) AS YEAR,
    QUARTER(finaldate) AS QUARTER,
    MONTH(finaldate) AS MONTH,
    MONTHNAME(finaldate) AS MONTH_NAME,
    DAY(finaldate) AS DAY_OF_MONTH,
    DAYOFWEEKISO(finaldate) AS DAY_OF_WEEK,
    DAYNAME(finaldate) AS DAY_NAME,
    IFF(DAYOFWEEKISO(finaldate) IN (6, 7), TRUE, FALSE) AS IS_WEEKEND
FROM dates
