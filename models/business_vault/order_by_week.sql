{{
    config(
        materialized='table'
    )
}}

WITH orders_with_dates AS (
    SELECT
        o.order_date,
        o.status,
        DATE_TRUNC('week', o.order_date::date) as week_start
    FROM {{ ref('sat_order') }} o
),

weekly_orders AS (
    SELECT
        week_start,
        status,
        COUNT(*) as order_count
    FROM orders_with_dates
    GROUP BY week_start, status
)

SELECT 
    week_start,
    status,
    order_count,
    SUM(order_count) OVER (PARTITION BY status ORDER BY week_start) as cumulative_count
FROM weekly_orders
ORDER BY week_start, status