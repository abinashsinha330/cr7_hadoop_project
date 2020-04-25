--create view to get top ten customers sorted by amount of sales in decreasing order


CREATE VIEW IF NOT EXISTS cr7_sales.top_ten_customers_amount_view AS
SELECT c.customerid, c.lastname, c.firstname, s1.total_sales_amount
FROM cr7_sales.customers c
JOIN
(
	SELECT customerid, sum(s.quantity * p.price) AS total_sales_amount
	FROM cr7_sales.sales s
	JOIN cr7_sales.products p
	ON s.productid = p.productid
	GROUP BY customerid
) AS s1
ON c.customerid = s1.customerid 
ORDER BY s1.total_sales_amount DESC limit 10;
