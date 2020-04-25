--create Impala database from raw data
--create Impala external tables from raw data


CREATE DATABASE IF NOT EXISTS cr7_sales_raw
COMMENT 'Impala database containing external tables using raw data';

CREATE EXTERNAL TABLE IF NOT EXISTS cr7_sales_raw.customers (
customerid int,
firstname varchar,
middleinitial varchar,
lastname varchar
)
COMMENT 'Impala external table - customers'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/salesdb/customers/'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS cr7_sales_raw.employees (
employeeid int,
firstname varchar,
middleinitial varchar,
lastname varchar,
region varchar
)
COMMENT 'Impala external table - employees'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/salesdb/employees/'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS cr7_sales_raw.products (
productid int,
name varchar,
price decimal(38,4)
)
COMMENT 'Impala external table - products'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/salesdb/products/'
TBLPROPERTIES ("skip.header.line.count"="1");

CREATE EXTERNAL TABLE IF NOT EXISTS cr7_sales_raw.sales (
orderid int,
salespersonid int,
customerid int,
productid int,
quantity int,
datesale TIMESTAMP
)
COMMENT 'Impala external table - sales'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '|'
STORED AS TEXTFILE
LOCATION '/salesdb/sales/'
TBLPROPERTIES ("skip.header.line.count"="1");

invalidate metadata;
compute stats cr7_sales_raw.customers;
compute stats cr7_sales_raw.employees;
compute stats cr7_sales_raw.products;
compute stats cr7_sales_raw.sales;
