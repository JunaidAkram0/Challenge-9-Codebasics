				-- ad_hoc_request_5 --
select * from dim_products;
select * from fact_events;

With CTE1 as (
Select   tb.product_name,
		SUM(td.quantity_sold_before_promo * td.base_price) as Total_Revenue_BP , 
SUM( 	
		CASE When td.promo_type = '50% OFF' then (td.quantity_sold_after_promo * td.base_price * 0.5)
			When  td.promo_type = '25% OFF' then (td.quantity_sold_after_promo * td.base_price * 0.75)
            When  td.promo_type = '33% OFF' then (td.quantity_sold_after_promo * td.base_price * 0.67)
            When  td.promo_type = 'BOGOF' then (td.quantity_sold_after_promo * td.base_price * 0.5 * 2)
			When  td.promo_type = '500 Cashback' then (td.quantity_sold_after_promo * (td.base_price - 500))
            Else 0
            End) as  Total_Revenue_AP
 from fact_events td
 Join dim_products tb on tb.product_code = td.product_code
 Group by tb.product_name
 ),
 CTE2 as (
 Select * , 
 ((Total_Revenue_AP - Total_Revenue_BP) / (Total_Revenue_BP)) * 100.0 as IR_Percentage
 from CTE1
 )
 Select product_name , IR_Percentage , Rank() over(order by IR_Percentage DESC) as Rank_IR 
 from CTE2
 Limit 5;
 
 



