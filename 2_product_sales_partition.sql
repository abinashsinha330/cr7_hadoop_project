CREATE TABLE IF NOT EXISTS cr7_sales.product_sales_partition 
PARTITIONED BY (year, month)
STORED AS Parquet 
AS select s.orderid, s.salespersonid, s.customerid, p.productid, p.name as productname, 
	p.price, s.quantity, s.quantity * p.price as amount, 
	s.datesale as orderdate, date_part('year', s.datesale) as year, 
	date_part('month', s.datesale) as month
from cr7_sales.products p
join cr7_sales.sales s on p.productid = s.productid;
--group by s.orderid, s.salespersonid, s.customerid, p.productid, productname,
--	p.price, s.quantity, s.datesale, year, month;

invalidate metadata;
compute stats cr7_sales.product_sales_partition ;
