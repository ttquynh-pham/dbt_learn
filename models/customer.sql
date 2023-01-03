{{
    config(
        materialized='table'
    )
}}

with customer_orders as (
    select
        user_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(id) as number_of_orders

    from jaffle_shop.orders

    group by 1
)

select
    customers.id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    coalesce(customer_orders.number_of_orders, 0) as number_of_orders

from jaffle_shop.customers as customers

left join customer_orders on customers.id = customer_orders.user_id