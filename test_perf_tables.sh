#!/bin/bash

echo ""

start1=$SECONDS
impala-shell -q "select count(*) from cr7_sales_raw.customers"
impala-shell -q "select count(*) from cr7_sales_raw.sales"
impala-shell -q "select count(*) from cr7_sales_raw.employees"
impala-shell -q "select count(*) from cr7_sales_raw.products"
dur1=$(($SECONDS - start1))

echo "Time taken to count number of records in external tables is $dur1 seconds"
echo ""

start2=$SECONDS
impala-shell -q "select count(*) from cr7_sales.customers"
impala-shell -q "select count(*) from cr7_sales.sales"
impala-shell -q "select count(*) from cr7_sales.employees"
impala-shell -q "select count(*) from cr7_sales.products"
dur2=$(($SECONDS - start2))

echo "Time taken to count number of records in managed tables in parquet format is $dur2 seconds"
echo ""

start3=$SECONDS
impala-shell -q "select count(*) from cr7_sales.product_sales_partition"
dur3=$(($SECONDS - start3))

echo "Time taken to count number of records in managed product and sales table in parquet format partitioned by year and month is $dur3 seconds"
echo ""

start4=$SECONDS
impala-shell -q "select count(*) from cr7_sales.product_region_sales_partition"
dur4=$(($SECONDS - start4))

echo "Time taken to count number of records in managed product and sales table in parquet format partitioned by region, year and month is $dur4 seconds"
echo ""
