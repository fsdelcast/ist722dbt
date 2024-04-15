WITH fm_orders AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['o.order_id' ]) }} AS order_key,
        o.ship_via as ship_via, 
        replace(to_date(o.order_date)::varchar,'-','')::int as order_date,
        replace(to_date(o.shipped_date)::varchar,'-','')::int as shipped_date,
        DATEDIFF(day, o.order_date, o.shipped_date) AS time_difference  -- Calculating the difference in days between order and shipped date
    FROM
        {{ source('FUDGEMART_V3', 'orders') }} o

)

SELECT
    fo.order_key,
    fo.ship_via,
    fo.order_date as order_date_key,
    fo.shipped_date as shipped_date_key,
    fo.time_difference
FROM
    fm_orders fo
