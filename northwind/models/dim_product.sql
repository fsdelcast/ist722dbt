with stg_product as (
    select * from {{source('northwind','Products')}}
),
stg_supplier as (
    select * from {{source('northwind','Suppliers')}}
),
stg_categories as (
    select * from {{source('northwind','Categories')}}
)
select 
    {{ dbt_utils.generate_surrogate_key(['p.ProductId']) }} as productkey,
    p.ProductId, p.productname,s.supplierid,c.categoryname,c.description
from stg_product p
    left join stg_supplier s on p.Supplierid = s.Supplierid
    left join stg_categories c on p.Categoryid = c.Categoryid