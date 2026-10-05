select row_number() over (order by payment_code) as payment_key,
       payment_code, payment_method, payment_type
from {{ ref('ref_payment') }}
