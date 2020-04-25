#!/bin/bash

start1=$SECONDS
impala-shell -q "select * from cr7_sales.customer_monthly_sales_2019_view"
dur1=$(( SECONDS - start1 ))
echo "View using non-partitioned data to return customer monthly sales in 2019 takes $dur1 seconds"

echo ""

start2=$SECONDS
impala-shell -q "select * from cr7_sales.top_ten_customers_amount_view"
dur2=$(( SECONDS - start2 ))
echo "Non-partitioned view to return top ten customers with largest sales in decreasing order takes $dur2 seconds"

echo ""

start3=$SECONDS
impala-shell -q "select * from cr7_sales.customer_monthly_sales_2019_partitioned_view"
dur3=$(( SECONDS - start3 ))
echo "View using partitioned data to return customer monthly sales in 2019 takes $dur3 seconds"

echo ""
