--create new database storing processed data
--create managed tables in parquet format having processed data

CREATE DATABASE IF NOT EXISTS cr7_sales
COMMENT 'Database to store managed tables in Parquet format after analysis of raw data';

CREATE TABLE IF NOT EXISTS cr7_sales.customers
COMMENT 'Managed Parquet table - customers'
STORED AS Parquet
AS
SELECT DISTINCT * from cr7_sales_raw.customers;

CREATE TABLE IF NOT EXISTS cr7_sales.employees
COMMENT 'Managed Parquet table - employees'
STORED AS Parquet
AS
SELECT DISTINCT * from cr7_sales_raw.employees;

CREATE TABLE IF NOT EXISTS cr7_sales.products
COMMENT 'Managed Parquet table - products'
STORED AS Parquet
AS
SELECT DISTINCT * from cr7_sales_raw.products;

CREATE TABLE IF NOT EXISTS cr7_sales.sales
COMMENT 'Managed Parquet table - sales'
STORED AS Parquet
AS
SELECT * from cr7_sales_raw.sales;



invalidate metadata;
compute stats cr7_sales.sales;
compute stats cr7_sales.employees;
compute stats cr7_sales.customers;
compute stats cr7_sales.products;
