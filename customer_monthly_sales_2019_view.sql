-- create view to return monthly sales in 2019 of each customer



CREATE VIEW IF NOT EXISTS cr7_sales.customer_monthly_sales_2019_view AS
SELECT c.customerid, c.lastname, c.firstname, t1.year, t1.month, t1.total_amount 
FROM
(
	select t.customerid, month(t.datesale) AS month, year(t.datesale) AS year, sum(t.amount) AS total_amount 
   	FROM
    	(
        	SELECT s.customerid, s.datesale, s.quantity * p.price AS amount
        	FROM cr7_sales.sales s
        	JOIN cr7_sales.products p
        	ON s.productid = p.productid
    	) AS t
    	WHERE year(t.datesale) = 2019
    	GROUP BY t.customerid, month(t.datesale), year(t.datesale)
) 	AS t1
JOIN cr7_sales.customers c 
ON c.customerid = t1.customerid;
