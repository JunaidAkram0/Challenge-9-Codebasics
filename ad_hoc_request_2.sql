select * from dim_campaigns;
select * from dim_products;
Select * from dim_stores;
select * from fact_events;

-- ad_hoc_request_2 --
select 	
		count(store_id) as 'Total Store' , 
		city 
        from dim_stores
Group by city
Order by count(store_id) desc;