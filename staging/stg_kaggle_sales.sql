-- One row per order from the ORIGINAL Kaggle file, cleaned.
-- price / quantity from Kaggle are NOT used downstream (bad prices, fractional quantities);
-- real prices come from ref_item and real quantities from raw_order_lines.
select
    cast(order_id as int)                                         as order_id,
    make_date(cast(substr(trim(order_date), 7, 4) as int),
              cast(substr(trim(order_date), 4, 2) as int),
              cast(substr(trim(order_date), 1, 2) as int))        as order_date,   -- source is dd-mm-yyyy
    {{ clean_text('product') }}                                   as product_category,
    cast(price as decimal(10,2))                                  as kaggle_price,
    cast(quantity as decimal(12,2))                               as kaggle_quantity,
    {{ clean_text('purchase_type') }}                             as purchase_type,
    {{ clean_text('payment_method') }}                            as payment_method,
    {{ clean_text('manager') }}                                   as manager_name,
    {{ clean_text('city') }}                                      as city
from {{ ref('raw_kaggle_sales') }}
