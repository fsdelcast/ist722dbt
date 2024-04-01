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

select *
    from f_sales_order as f
    left join d_customer on f.customer_account_key = d_customer.customer_account_key
    left join d_date on f.date_key = d_date.datekey
    left join d_product on f.product_plan_key = d_product.product_plan_key
