-- Total rows: 10,000
SELECT 
	COUNT(*)
FROM 
	amazon_sales_dataset;

-- Unique orders: 10,000
SELECT 
	COUNT(DISTINCT order_id)
FROM 
	amazon_sales_dataset;

-- Unique customers: 6,016
SELECT 
	COUNT(DISTINCT customer_id)
FROM 
	amazon_sales_dataset;

-- Unique order status: 'Delivered'
SELECT DISTINCT 
	order_status
FROM
	amazon_sales_dataset;
	
-- Unique payment methods: UPI, NetBanking, COD, Card
SELECT DISTINCT
	payment_method
FROM 
	amazon_sales_dataset;

-- Unique product categories: Electronics, Home, Fashion
SELECT DISTINCT
	category
FROM
	amazon_sales_dataset;

-- Order Date range: 2026-01-01 to 2026-02-10
SELECT
	min(order_date),
	max(order_date)
FROM
	amazon_sales_dataset;

-- Delivery date range: 2026-01-01 to 2026-02-10
SELECT
	min(delivery_date),
	max(delivery_date)
FROM
	amazon_sales_dataset;

SELECT
	COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
	COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
	COUNT(*) FILTER (WHERE customer_name IS NULL) AS missing_customer_name,
	COUNT(*) FILTER (WHERE ship_date IS NULL) AS missing_ship_date,
	COUNT(*) FILTER (WHERE delivery_date IS NULL) AS missing_delivery_date,
	COUNT(*) FILTER (WHERE order_status IS NULL) AS missing_order_status,
	COUNT(*) FILTER (WHERE country is NULL) AS missing_country,
	COUNT(*) FILTER (WHERE state is NULL) AS missing_state,
	COUNT(*) FILTER (WHERE city is NULL) AS missing_city,
	COUNT(*) FILTER (WHERE product_id is NULL) AS missing_product_id,
	COUNT(*) FILTER (WHERE product_name IS NULL) AS missing_product_name,
	COUNT(*) FILTER (WHERE category IS NULL) AS missing_category,
	COUNT(*) FILTER (WHERE sub_category IS NULL) AS missing_sub_category,
	COUNT(*) FILTER (WHERE brand IS NULL) AS missing_brand,
	COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
	COUNT(*) FILTER (WHERE unit_price IS NULL) AS missing_unit_price,
	COUNT(*) FILTER (WHERE discount IS NULL) AS missing_discount,
	COUNT(*) FILTER (WHERE shipping_cost IS NULL) AS missing_shipping_cost,
	COUNT(*) FILTER (WHERE total_sales IS NULL) AS missing_total_sales,
	COUNT(*) FILTER (WHERE payment_method IS NULL) AS missing_payment_method
FROM 
	amazon_sales_dataset;

-- Order and delivery date conflict check: 4911
SELECT 
	COUNT(*)
FROM
	amazon_sales_dataset
WHERE
	order_date > delivery_date;
	
-- Checking actual values
SELECT 
	order_id,
	order_date,
	ship_date,
	delivery_date
FROM
	amazon_sales_dataset
WHERE 
	order_date > delivery_date;
	
-- Order and shipping date conflict check: 4915
SELECT
	COUNT(*)
FROM 
	amazon_sales_dataset
WHERE
	ship_date < order_date;

-- Shipping and delivery date conflict check: 4,882
SELECT  
	COUNT(*)
FROM 
	amazon_sales_dataset 
WHERE 
	delivery_date < ship_date;

-- Order, ship and delivery date with no conflicts: 1,752
SELECT 
	COUNT(*)
FROM
	amazon_sales_dataset
WHERE 
	order_date <= ship_date and 
    ship_date <= delivery_date;

-- Invalid numerical values: 0 across all
SELECT  
	COUNT (product_id)  FILTER (WHERE product_id not LIKE 'P___') AS incorrect_product_id,
	COUNT (quantity) FILTER (WHERE quantity <= 0) AS invaid_quantity,
	COUNT (discount) FILTER (WHERE discount < 0) AS invalid_discount,
	COUNT (unit_price) FILTER (WHERE unit_price <= 0) AS invalid_unit_price,
	COUNT (shipping_cost) FILTER (WHERE shipping_cost <= 0) AS invalid_shipping_cost,
	COUNT  (total_sales) FILTER (WHERE total_sales <= 0) AS invalid_total_sales
from 
	amazon_sales_dataset;

-- total sales  validity: 1708
SELECT 
	COUNT(*)
FROM 
	amazon_sales_dataset
WHERE  
	ROUND((
	((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2) 
	= ROUND(total_sales::numeric, 2);
	
-- Checking specific invalid orders
WITH filtered_data AS 
(
SELECT 
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	(ROUND((((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2)) AS expected_total_sale
FROM 
	amazon_sales_dataset
WHERE  
	ROUND((
	((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2) 
	<> ROUND(total_sales::numeric, 2)
LIMIT 20	
)
SELECT
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	expected_total_sale,
	total_sales - expected_total_sale as difference
FROM
	filtered_data;

-- Checking invalid order difference #2
-- Total rows: 10,000
SELECT 
	COUNT(*)
FROM 
	amazon_sales_dataset;

-- Unique orders: 10,000
SELECT 
	COUNT(DISTINCT order_id)
FROM 
	amazon_sales_dataset;

-- Unique customers: 6,016
SELECT 
	COUNT(DISTINCT customer_id)
FROM 
	amazon_sales_dataset;

-- Unique order status: 'Delivered'
SELECT DISTINCT 
	order_status
FROM
	amazon_sales_dataset;
	
-- Unique payment methods: UPI, NetBanking, COD, Card
SELECT DISTINCT
	payment_method
FROM 
	amazon_sales_dataset;

-- Unique product categories: Electronics, Home, Fashion
SELECT DISTINCT
	category
FROM
	amazon_sales_dataset;

-- Order Date range: 2026-01-01 to 2026-02-10
SELECT
	min(order_date),
	max(order_date)
FROM
	amazon_sales_dataset;

-- Delivery date range: 2026-01-01 to 2026-02-10
SELECT
	min(delivery_date),
	max(delivery_date)
FROM
	amazon_sales_dataset;

SELECT
	COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
	COUNT(*) FILTER (WHERE order_date IS NULL) AS missing_order_date,
	COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
	COUNT(*) FILTER (WHERE customer_name IS NULL) AS missing_customer_name,
	COUNT(*) FILTER (WHERE ship_date IS NULL) AS missing_ship_date,
	COUNT(*) FILTER (WHERE delivery_date IS NULL) AS missing_delivery_date,
	COUNT(*) FILTER (WHERE order_status IS NULL) AS missing_order_status,
	COUNT(*) FILTER (WHERE country is NULL) AS missing_country,
	COUNT(*) FILTER (WHERE state is NULL) AS missing_state,
	COUNT(*) FILTER (WHERE city is NULL) AS missing_city,
	COUNT(*) FILTER (WHERE product_id is NULL) AS missing_product_id,
	COUNT(*) FILTER (WHERE product_name IS NULL) AS missing_product_name,
	COUNT(*) FILTER (WHERE category IS NULL) AS missing_category,
	COUNT(*) FILTER (WHERE sub_category IS NULL) AS missing_sub_category,
	COUNT(*) FILTER (WHERE brand IS NULL) AS missing_brand,
	COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
	COUNT(*) FILTER (WHERE unit_price IS NULL) AS missing_unit_price,
	COUNT(*) FILTER (WHERE discount IS NULL) AS missing_discount,
	COUNT(*) FILTER (WHERE shipping_cost IS NULL) AS missing_shipping_cost,
	COUNT(*) FILTER (WHERE total_sales IS NULL) AS missing_total_sales,
	COUNT(*) FILTER (WHERE payment_method IS NULL) AS missing_payment_method
FROM 
	amazon_sales_dataset;

-- Order and delivery date conflict check: 4911
SELECT 
	COUNT(*)
FROM
	amazon_sales_dataset
WHERE
	order_date > delivery_date;
	
-- Checking actual values
SELECT 
	order_id,
	order_date,
	ship_date,
	delivery_date
FROM
	amazon_sales_dataset
WHERE 
	order_date > delivery_date;
	
-- Order and shipping date conflict check: 4915
SELECT
	COUNT(*)
FROM 
	amazon_sales_dataset
WHERE
	ship_date < order_date;

-- Shipping and delivery date conflict check: 4,882
SELECT  
	COUNT(*)
FROM 
	amazon_sales_dataset 
WHERE 
	delivery_date < ship_date;

-- Order, ship and delivery date with no conflicts: 1,752
SELECT 
	COUNT(*)
FROM
	amazon_sales_dataset
WHERE 
	order_date <= ship_date and 
    ship_date <= delivery_date;

-- Invalid numerical values: 0 across all
SELECT  
	COUNT (product_id)  FILTER (WHERE product_id not LIKE 'P___') AS incorrect_product_id,
	COUNT (quantity) FILTER (WHERE quantity <= 0) AS invaid_quantity,
	COUNT (discount) FILTER (WHERE discount < 0) AS invalid_discount,
	COUNT (unit_price) FILTER (WHERE unit_price <= 0) AS invalid_unit_price,
	COUNT (shipping_cost) FILTER (WHERE shipping_cost <= 0) AS invalid_shipping_cost,
	COUNT  (total_sales) FILTER (WHERE total_sales <= 0) AS invalid_total_sales
from 
	amazon_sales_dataset;

-- total sales  validity: 1708
SELECT 
	COUNT(*)
FROM 
	amazon_sales_dataset
WHERE  
	ROUND((
	((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2) 
	= ROUND(total_sales::numeric, 2);
	
-- Checking specific invalid orders
WITH filtered_data AS 
(
SELECT 
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	(ROUND((((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2)) AS expected_total_sale
FROM 
	amazon_sales_dataset
WHERE  
	ROUND((
	((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2) 
	<> ROUND(total_sales::numeric, 2)
LIMIT 20	
)
SELECT
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	expected_total_sale,
	ROUND(total_sales::numeric,2) - expected_total_sale as difference
FROM
	filtered_data;

-- isolating one row for operational inspection
SELECT
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	(ROUND ((((unit_price*quantity)*(1-discount)) + shipping_cost)::numeric, 2)) AS expected_total_sale,
	(Round(total_sales::numeric,2) - (ROUND ((((unit_price*quantity)*(1-discount)) + shipping_cost)::numeric, 2))) as difference
FROM
	amazon_sales_dataset
WHERE
	order_id = 'A10002';

-- more checking
SELECT
	column_name,
	data_type
FROM
	information_schema.columns
WHERE
	table_name = 'amazon_sales_dataset'
	and column_name = 'total_sales';

-- checking operation error by isolating one row (reworked)
SELECT
    order_id,
    total_sales,
    ROUND(total_sales::numeric, 2) AS rounded_actual,
    unit_price,
    quantity,
    discount,
    shipping_cost,
    ROUND(
        (((unit_price * quantity) * (1 - discount)) + shipping_cost)::text::numeric,
        2
    ) AS rounded_expected,
    ROUND(total_sales::text::numeric, 2)
    -
    ROUND(
        (((unit_price * quantity) * (1 - discount)) + shipping_cost)::text::numeric,
        2
    ) AS difference
FROM amazon_sales_dataset
WHERE order_id = 'A10002';


-- corrected query + counting how many total_sales are invalid: 37
WITH filtered_data AS 
(
SELECT 
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	(ROUND((((unit_price*quantity)* (1 - discount)) + shipping_cost)::text::numeric, 2)) AS expected_total_sale
FROM 
	amazon_sales_dataset
WHERE  
	ROUND((
	((unit_price*quantity)* (1 - discount)) + shipping_cost)::numeric, 2) 
	<> ROUND(total_sales::text::numeric, 2)
)
SELECT
	COUNT(*)
FROM
	filtered_data
WHERE
	ABS (
		ROUND(total_sales::text::numeric,2) - expected_total_sale
		) > 0.01;


-- Inspecting invalid total_sale values: 0.37% discrepancy rate
WITH filtered_data AS 
(
SELECT 
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	(ROUND((((unit_price*quantity)* (1 - discount)) + shipping_cost)::text::numeric, 2)) AS expected_total_sale
FROM 
	amazon_sales_dataset
WHERE  
	ROUND((
	((unit_price*quantity)* (1 - discount)) + shipping_cost)::text::numeric, 2) 
	<> ROUND(total_sales::text::numeric, 2)
)
SELECT
	order_id,
	quantity,
	discount,
	unit_price,
	shipping_cost,
	total_sales,
	expected_total_sale,
	(ROUND(total_sales::text::numeric,2) - expected_total_sale) AS difference
FROM
	filtered_data
WHERE
	ABS (
		ROUND(total_sales::text::numeric,2) - expected_total_sale
		) > 0.01;

