-- The "missing fields" at line level: items on each bill, incl. daypacks and add-ons
select
    cast(order_id as int)            as order_id,
    cast(line_no as int)             as line_no,
    upper(trim(item_code))           as item_code,
    cast(parent_line_no as int)      as parent_line_no,   -- set only for add-ons
    cast(quantity as int)            as quantity,
    cast(discount_pct as decimal(4,2)) as discount_pct
from {{ ref('raw_order_lines') }}
