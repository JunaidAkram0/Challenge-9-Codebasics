
                   -- ad-hoc-request 1 --
                   
describe fact_events;
select 
		Distinct
        td.product_code as 'Product Code',
		td.promo_type 	 as 'Promo Type', 
        tb.product_name as 'Product name',
		td.base_price as 'Base Price'
	
from fact_events td
Join dim_products tb on tb.product_code = td.product_code
where promo_type = 'BOGOF' and base_price > "500" ;
