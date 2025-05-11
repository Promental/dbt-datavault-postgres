{{
    config(
        materialized='table'
    )
}}

WITH completed_orders AS (
    SELECT
        lco.customer_pk,
        COUNT(*) as completed_orders_count
    FROM {{ ref('link_customer_order') }} lco
    JOIN {{ ref('sat_order') }} so ON so.order_pk = lco.order_pk
    WHERE so.status = 'completed'
    GROUP BY lco.customer_pk
),

customer_info AS (
    SELECT DISTINCT ON (c.customer_pk)
        c.customer_pk,
        c.first_name,
        c.last_name,
        c.email,
        COALESCE(co.completed_orders_count, 0) as completed_orders_count
    FROM {{ ref('sat_customer') }} c
    LEFT JOIN completed_orders co ON co.customer_pk = c.customer_pk
    ORDER BY c.customer_pk, c.effective_from DESC
)

SELECT 
    first_name,
    last_name,
    email,
    completed_orders_count
FROM customer_info
ORDER BY completed_orders_count DESC, email