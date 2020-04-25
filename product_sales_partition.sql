--create Impala Parquet product and sales materialized table partitioned by year and month



CREATE TABLE IF NOT EXISTS cr7_sales.product_sales_partition (
orderid int, 
salespersonid int, 
customerid int, 
productid int, 
productname varchar, 
price decimal(38,4), 
quantity int, 
amount decimal(38,4),
day int 
) 
PARTITIONED BY (year int, month int)
COMMENT 'Impala Parquet product and sales materialized table partitioned by year and month'
STORED AS Parquet;

INSERT INTO cr7_sales.product_sales_partition PARTITION(year, month)
SELECT s.orderid, s.salespersonid, s.customerid, p.productid, p.name, p.price, s.quantity, s.quantity * p.price, day(s.datesale) AS day, year(s.datesale) AS year, month(s.datesale) AS month
FROM cr7_sales.products p
JOIN cr7_sales.sales s
ON p.productid = s.productid;

invalidate metadata;
compute stats cr7_sales.product_sales_partition;
