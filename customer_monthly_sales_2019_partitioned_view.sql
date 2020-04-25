--create view returning monthly sales in 2019 for each customer using partitioned product and sales Impala Paruqet table



CREATE VIEW IF NOT EXISTS cr7_sales.customer_monthly_sales_2019_partitioned_view AS
SELECT c.customerid, c.lastname, c.firstname, t1.year, t1.month, t1.total_amount
FROM
(
	SELECT t.customerid, t.month, t.year, sum(t.amount) AS total_amount
    	FROM
    	(
        	SELECT ps.customerid, ps.month, ps.year, ps.amount
        	FROM cr7_sales.product_sales_partition ps
        	WHERE ps.year = 2019
    	) AS t
    	GROUP BY t.customerid, t.month, t.year
) AS t1
JOIN cr7_sales.customers c
ON c.customerid = t1.customerid;
