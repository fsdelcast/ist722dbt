-- get customers information that appears in FM and FF with FF being the most important information
WITH full_cte AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['m.account_email']) }} as customer_account_key,
        m.account_id AS customer_account_ff_id,
        c.customer_id AS customer_account_fm_id,
        m.account_email AS customer_account_email,
        m.account_firstname AS customer_account_firstname,
        m.account_lastname AS customer_account_lastname,
        m.account_address AS customer_account_address,
        z.zip_city AS customer_account_city,
        z.zip_state AS customer_account_state,
        z.zip_code AS customer_account_zip
    FROM 
        {{ source('FUDGEFLIX_V3', 'accounts') }} m
    JOIN 
        {{ source('FUDGEFLIX_V3', 'zipcodes') }} z ON m.account_zipcode = z.zip_code
    LEFT JOIN 
        {{ source('FUDGEMART_V3', 'customers') }} c ON m.account_email = c.customer_email
),

only_FM_CTE AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['c.customer_email']) }} as customer_account_key,
        NULL AS customer_account_ff_id,
        c.customer_id AS customer_account_fm_id,
        c.customer_email AS customer_account_email,
        c.customer_firstname AS customer_account_firstname,
        c.customer_lastname AS customer_account_lastname,
        c.customer_address AS customer_account_address,
        c.customer_city AS customer_account_city,
        c.customer_state AS customer_account_state,
        c.customer_zip AS customer_account_zip
    FROM 
        {{ source('FUDGEFLIX_V3', 'accounts') }} m
    RIGHT JOIN 
        {{ source('FUDGEMART_V3', 'customers') }} c ON m.account_email = c.customer_email
    WHERE m.account_email IS NULL
)

SELECT *
FROM full_cte 
UNION ALL
SELECT *
FROM only_FM_CTE