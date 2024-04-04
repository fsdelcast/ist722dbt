with f_sales_order as (
    select * from {{ ref('fact_sales_order') }}
),
d_customer as (
    select * from {{ ref('dim_customer_account') }}
),
d_product as (
    select * from {{ ref('dim_products_plans') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)

select f.*, 
    d_customer.customer_account_ff_id, d_customer.customer_account_fm_id, d_customer.customer_account_email, 
    CONCAT(d_customer.customer_account_firstname, ' ', d_customer.customer_account_lastname) as full_name,
    d_customer.customer_account_city, d_customer.customer_account_state,
    d_date.year, d_date.month, d_date.quarter, d_date.quartername, d_date.monthname,
    d_product.product_plan_id, d_product.product_plan_department, d_product.product_plan_name,
    d_product.product_plan_active, d_product.product_plan_vendor_id, d_product.product_plan_vendor_name,d_product.product_plan_vendor_phone
from f_sales_order as f
left join d_customer on f.customer_account_key = d_customer.customer_account_key
left join d_date on f.date_key = d_date.datekey
left join d_product on f.product_plan_key = d_product.product_plan_key
