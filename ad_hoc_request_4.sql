-- ad_hoc_request_4 --
select * from dim_campaigns;
select * from dim_products;
select * from dim_stores;
select * from fact_events;

with CTE1 as (
select * , 
      (if(promo_type = 'BOGOF' , 
        quantity_sold_after_promo * 2 , quantity_sold_after_promo)) 
        as Total_quantity_after
from fact_events
Join dim_campaigns using(campaign_id)
Join dim_products Using (product_code)
Where campaign_name = "Diwali"
),
cte2 as 
			( select campaign_name , category, 
 ((SUM(Total_quantity_after) - sum(quantity_sold_before_promo)) / sum(quantity_sold_before_promo) ) * 100.0
as `ISU%` from CTE1 
group by category  , category
)
select campaign_name,category, `ISU%`,  rank() over(order by `ISU%` DESC) as `ISU%_Rank`
from cte2