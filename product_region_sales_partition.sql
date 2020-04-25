--create Impala Parquet sales and region materialized table partitioned by region, year and sales



CREATE TABLE IF NOT EXISTS cr7_sales.product_region_sales_partition (
orderid int,
salespersonid int,
customerid int,
productid int,
productname varchar,
price decimal(38,4),
quantity int,
amount decimal(38,4),
orderdate TIMESTAMP
)
PARTITIONED BY (region varchar, year int, month int)
COMMENT 'Impala Parquet sales and region materialized table partitioned by region, year and month'
STORED AS Parquet;

INSERT INTO cr7_sales.product_region_sales_partition PARTITION(region, year, month)
SELECT ps.orderid, ps.salespersonid, ps.customerid, ps.productid, ps.productname, ps.price, ps.quantity, ps.amount, ps.orderdate, e.region, ps.year, ps.month
FROM cr7_sales.product_sales_partition ps
JOIN cr7_sales.employees e
ON ps.salespersonid = e.employeeid;

invalidate metadata;
compute stats cr7_sales.product_region_sales_partition;
