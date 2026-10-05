-- The "missing fields" at order level: which channel and which order mode
select
    cast(order_id as int)        as order_id,
    upper(trim(channel_code))    as channel_code,
    upper(trim(order_mode_code)) as order_mode_code
from {{ ref('raw_order_channel_mode') }}
