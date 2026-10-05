-- Prices every bill line using the item master. Shared by both fact tables.
with lines as (select * from {{ ref('stg_order_lines') }}),
items as (select item_code, item_key, item_type, unit_price from {{ ref('dim_item') }})
select
    l.order_id,
    l.line_no,
    l.parent_line_no,
    i.item_key,
    i.item_type,
    l.quantity,
    i.unit_price,
    round(l.quantity * i.unit_price, 2)                                   as gross_amount,
    round(round(l.quantity * i.unit_price, 2) * l.discount_pct, 2)        as discount_amount
from lines l
left join items i on i.item_code = l.item_code
