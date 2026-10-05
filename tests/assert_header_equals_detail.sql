-- Singular test: returns rows ONLY if a bill's net amount differs from the sum of its lines. 0 rows = pass.
select h.cheque_key, h.net_amount as header_net, sum(d.net_amount) as detail_net
from {{ ref('fact_cheque') }} h
join {{ ref('fact_cheque_detail') }} d on d.cheque_key = h.cheque_key
group by h.cheque_key, h.net_amount
having h.net_amount <> sum(d.net_amount)
