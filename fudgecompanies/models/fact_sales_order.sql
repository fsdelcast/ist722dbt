with fudgeflix as ( 
SELECT
    od.ab_id order_key,
    'FudgeFlix ' product_plan_company,
    od.ab_plan_id product_plan_key,
    od.ab_account_id customer_account_key,
    replace(to_date(od.ab_date)::varchar,'-','')::int as date_key,
    1 as quantity,
    od.ab_billed_amount product_retail_price,
    1 * od.ab_billed_amount AS sold_amount
FROM {{ source('FUDGEFLIX_V3', 'account_billing') }} od),
--fudgeflix_v3..ff_account_billing od),

fudgemart as (
    SELECT 
    od.order_id order_key,
    'FudgeMart' product_plan_company,
    od.product_id product_plan_key,
    o.customer_id customer_account_key,
    replace(to_date(o.order_date)::varchar,'-','')::int as date_key,
    od.order_qty quantity,
    p.product_retail_price,
    od.order_qty * p.product_retail_price AS sold_amount
FROM {{ source('FUDGEMART_V3', 'order_details') }} od
JOIN {{ source('FUDGEMART_V3', 'orders') }} o ON od.order_id = o.order_id
JOIN {{ source('FUDGEMART_V3', 'products') }} p ON od.product_id=p.product_id
)

SELECT 
    ff.order_key,
    {{ dbt_utils.generate_surrogate_key(['ff.product_plan_company', 'ff.product_plan_key']) }} AS product_plan_key,
    {{ dbt_utils.generate_surrogate_key(['ff.product_plan_company', 'ff.customer_account_key']) }} AS customer_account_key,
    ff.date_key, ff.quantity, ff.product_retail_price, ff.sold_amount 
FROM fudgeflix ff 
UNION
SELECT 
    fm.order_key,
    {{ dbt_utils.generate_surrogate_key(['fm.product_plan_company', 'fm.product_plan_key']) }} AS product_plan_key,
    {{ dbt_utils.generate_surrogate_key(['fm.product_plan_company', 'fm.customer_account_key']) }} AS customer_account_key,
    fm.date_key, fm.quantity, fm.product_retail_price, fm.sold_amount 
FROM fudgemart fm