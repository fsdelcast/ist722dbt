-- fudgemart
WITH A as (
SELECT 
    'FudgeMart' as product_plan_company,
    m.product_id as product_plan_id,
    m.product_department as product_plan_department,
    m.product_name as product_plan_name,
    m.product_retail_price as product_plan_retail_price,
    m.product_is_active as product_plan_active,
    v.vendor_id as product_plan_vendor_id,
    v.vendor_name as product_plan_vendor_name,
    v.vendor_phone as product_plan_vendor_phone,
    v.vendor_website as product_plan_vendor_website
FROM 
    {{ source('FUDGEMART_V3', 'products') }} m
JOIN 
    {{ source('FUDGEMART_V3', 'vendors') }} v ON m.product_vendor_id = v.vendor_id
),
B AS (
-- fudgeflix
SELECT 
    'FudgeFlix' as product_plan_company,
    m.plan_id as product_plan_id,
    NULL as product_plan_department,  -- No department information available for FudgeFlix plans
    m.plan_name as product_plan_name,
    m.plan_price as product_plan_retail_price,
    m.plan_current as product_plan_active,
    NULL as product_plan_vendor_id,  -- No vendor information available for FudgeFlix plans
    NULL as product_plan_vendor_name,
    NULL as product_plan_vendor_phone,
    NULL as product_plan_vendor_website
FROM 
    {{ source('FUDGEFLIX_V3', 'plans') }} m
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['a.product_plan_company', 'a.product_plan_id']) }} AS product_plan_key,
     * FROM A a
UNION ALL 
SELECT 
        {{ dbt_utils.generate_surrogate_key(['b.product_plan_company', 'b.product_plan_id']) }} AS product_plan_key,
* FROM B b
