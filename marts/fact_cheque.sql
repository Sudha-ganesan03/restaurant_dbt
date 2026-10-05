-- GRAIN: one row per bill (Header)
with orders as (select * from {{ ref('stg_kaggle_sales') }}),
cm as (select * from {{ ref('stg_order_channel_mode') }}),
totals as (
    select order_id,
           count(*)             as line_count,
           sum(quantity)        as total_quantity,
           sum(gross_amount)    as gross_amount,
           sum(discount_amount) as discount_amount
    from {{ ref('int_order_lines_priced') }}
    group by order_id
)
select
    row_number() over (order by o.order_id)                              as cheque_key,
    o.order_id                                                           as cheque_no,
    year(o.order_date) * 10000 + month(o.order_date) * 100 + day(o.order_date) as date_key,
    loc.location_key,
    ch.channel_key,
    om.order_mode_key,
    pay.payment_key,
    t.line_count,
    t.total_quantity,
    t.gross_amount,
    t.discount_amount,
    t.gross_amount - t.discount_amount                                   as net_amount,
    round((t.gross_amount - t.discount_amount) * {{ var('tax_rate') }}, 2) as tax_amount,
    (t.gross_amount - t.discount_amount)
      + round((t.gross_amount - t.discount_amount) * {{ var('tax_rate') }}, 2) as total_amount
from orders o
left join cm                          on cm.order_id = o.order_id
left join totals t                    on t.order_id = o.order_id
left join {{ ref('dim_location') }}   loc on loc.city = o.city
left join {{ ref('dim_channel') }}    ch  on ch.channel_code = cm.channel_code
left join {{ ref('dim_order_mode') }} om  on om.order_mode_code = cm.order_mode_code
left join {{ ref('dim_payment') }}    pay on pay.payment_method = o.payment_method
