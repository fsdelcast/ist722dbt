WITH fact_reviews AS (
    SELECT
        at.at_id AS at_id,
        at.at_account_id AS account_key,
        at.at_title_id AS title_id,
        --at.at_queue_date AS queue_date,  
        replace(to_date(at.at_queue_date)::varchar,'-','')::int as queue_date,
        replace(to_date(at.at_shipped_date)::varchar,'-','')::int as shipped_date,
        replace(to_date(at.at_returned_date)::varchar,'-','')::int as returned_date,
        --at.at_shipped_date AS shipped_date,
        --at.at_returned_date AS returned_date,
        at.at_rating AS at_rating
    FROM
        --fudgeflix_v3.dbo.ff_account_titles at -- Replace with your actual table and schema
        {{ source('FUDGEFLIX_V3', 'account_titles') }} at
)
SELECT
    {{ dbt_utils.generate_surrogate_key(['fr.at_id']) }} AS review_key,
    {{ dbt_utils.generate_surrogate_key(['fr.account_key']) }} AS account_key,
    {{ dbt_utils.generate_surrogate_key(['fr.title_id']) }} AS title_key,
    fr.queue_date as queue_date_key, 
    fr.shipped_date as shipped_date_key,
    fr.returned_date as returned_date_key,
    fr.at_rating
FROM fact_reviews fr
