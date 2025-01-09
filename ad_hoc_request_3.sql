-- Ad_hoc_request_3 --

select 
		ta.campaign_name,
		ROUND(SUM(td.quantity_sold_before_promo * td.base_price)/1000000 ,2) as "Total Revenue Before Promo in Millions"	
,ROUND(SUM( 
		Case  
		when td.promo_type = '50% OFF' then (td.quantity_sold_after_promo * td.base_price * 0.5  )
        when td.promo_type = '25% OFF' then (td.quantity_sold_after_promo  *  td.base_price * 0.75) 
        when td.promo_type = '33% OFF' then (td.quantity_sold_after_promo  * td.base_price * 0.67 )
        when td.promo_type = 'BOGOF' then (td.quantity_sold_after_promo  * td.base_price * 0.5)
        when td.promo_type = '500 Cashback' then (td.quantity_sold_after_promo  * (td.base_price - 500))
        Else 0
	 END)/1000000 ,2) as "Total Sale After Promo in Millions" 
from fact_events td
join dim_campaigns ta on ta.campaign_id = td.campaign_id
Group by ta.campaign_name
Order by ta.campaign_name;