with stg_orders as (
    select ORDER_KEY, ORDER_PK, user_id from {{ref('stg_orders')}}
),

stg_customers as (
    select 
    id,
    email as customer_key,  -- используем email вместо customer_key
    customer_pk
    FROM {{ ref('stg_customers') }}
)

select  ORDER_KEY, CUSTOMER_KEY, CUSTOMER_PK, ORDER_PK from stg_orders so
JOIN stg_customers sc ON sc.id = so.user_id
