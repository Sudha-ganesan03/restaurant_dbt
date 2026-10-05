with spine as (
    select cast(date_day as date) as full_date
    from (
        {{ dbt_utils.date_spine(
            datepart="day",
            start_date="cast('2022-11-01' as date)",
            end_date="cast('2023-01-01' as date)") }}
    ) s
),
named as (
    select full_date,
           date_format(full_date, 'EEEE') as day_name,      -- Databricks syntax
           date_format(full_date, 'MMMM') as month_name
    from spine
)
select
    year(full_date) * 10000 + month(full_date) * 100 + day(full_date) as date_key,
    full_date,
    day(full_date)        as day_of_month,
    day_name,
    weekofyear(full_date) as week_of_year,
    month(full_date)      as month,
    month_name,
    quarter(full_date)    as quarter,
    year(full_date)       as year,
    case when day_name in ('Saturday', 'Sunday') then 'Y' else 'N' end as is_weekend
from named
