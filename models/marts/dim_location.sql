select row_number() over (order by location_code) as location_key,
       location_code, store_name, city, country, region, manager_name
from {{ ref('ref_location') }}
