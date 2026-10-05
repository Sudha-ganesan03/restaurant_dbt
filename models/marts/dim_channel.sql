select row_number() over (order by channel_code) as channel_key,
       channel_code, channel_name, channel_group, channel_owner
from {{ ref('ref_channel') }}
