-- Phase 3: Business Analysis
-- Objective: Analyze sales performance, products,
-- customers, and payment methods.

-- Examining categories of products and their total sale 
-- along with order counts
SELECT 
	category,
	SUM(total_sales) AS total_sale,
	COUNT(*) AS order_count
FROM
	amazon_sales_dataset
GROUP BY 
	category
ORDER BY
	total_sale DESC;

-- Examining which category has the highest average order value
-- Conclusion: Order value: Electronics > fashion > home
SELECT 
	category,
	AVG(total_sales) as avg_order_value
FROM 
	amazon_sales_dataset 
GROUP BY 
	 category
ORDER BY 
	avg_order_value DESC;

-- Examining which products generate the most revenue
SELECT 
	product_id,
	product_name,
	SUM(total_sales) AS total_revenue,
	SUM(quantity) AS total_quantity_sold
FROM
	amazon_sales_dataset
GROUP BY 
	product_id,
	product_name
ORDER BY    
	total_revenue DESC
LIMIT 10;

-- Examining if these products high-revenue because of price or volume
SELECT 
	product_id,
	product_name,
	SUM(total_sales) AS total_revenue,
	SUM(quantity) AS total_quantity_sold,
	SUM(total_sales) / NULLIF(SUM(quantity), 0) AS revenue_per_unit
FROM
	amazon_sales_dataset
GROUP BY 
	product_id,
	product_name
ORDER BY    
	total_revenue DESC
LIMIT 10;

-- Examining which brands generate most revenue
SELECT 
	brand,
	SUM(total_sales) as total_revenue
FROM 
	amazon_sales_dataset
GROUP BY   
	brand
ORDER BY 
	total_revenue DESC
LIMIT 100;

-- Investigating sales volume
SELECT 
	brand,
	SUM(total_sales) as total_revenue,
	SUM(quantity) as total_quantity_sold
FROM 
	amazon_sales_dataset
GROUP BY   
	brand
ORDER BY 
	total_quantity_sold DESC
LIMIT 100;














