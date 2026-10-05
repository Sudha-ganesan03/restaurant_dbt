-- GRAIN: one row per item line on a bill (Detail). Includes daypacks and add-ons.
select
    row_number() over (order by l.order_id, l.line_no) as cheque_detail_key,
    h.cheque_key,
    l.line_no,
    h.date_key,
    h.location_key,
    l.item_key,
    l.parent_line_no,                                         -- add-on -> line it belongs to
    case when l.item_type = 'Add-On'  then 'Y' else 'N' end   as is_addon,
    case when l.item_type = 'Daypack' then 'Y' else 'N' end   as is_daypack,
    l.quantity,
    l.unit_price,
    l.gross_amount,
    l.discount_amount,
    l.gross_amount - l.discount_amount                        as net_amount
from {{ ref('int_order_lines_priced') }} l
left join {{ ref('fact_cheque') }} h on h.cheque_no = l.order_id
