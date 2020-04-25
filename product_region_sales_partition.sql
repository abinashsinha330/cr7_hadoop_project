CREATE TABLE IF NOT EXISTS cr7_sales.product_region_sales_partition
PARTITIONED BY (region, year, month)
STORED AS Parquet 
AS select ps.OrderID, ps.SalesPersonID, ps.customerid, p.productid, ps.productname, ps.price, ps.quantity, ps.amount, ps.orderdate, e.region, ps.year, ps.month
from cr7_sales.product_sales_partition ps
--join cr7_sales.sales s on (ps.productid = s.productid)
join cr7_sales.employees e on (ps.salespersonid = e.employeeid);

invalidate metadata;
compute stats cr7_sales.product_region_sales_partition;
