select row_number() over (order by order_mode_code) as order_mode_key,
       order_mode_code, order_mode_name, service_type
from {{ ref('ref_order_mode') }}
