select row_number() over (order by item_code) as item_key,
       item_code, item_name, category,
       item_type,                       -- Single Item / Daypack / Add-On
       cast(unit_price as decimal(10,2)) as unit_price,
       veg_nonveg
from {{ ref('ref_item') }}
