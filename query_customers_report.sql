CREATE OR REPLACE VIEW g_customer_report AS
WITH base_query AS (
    SELECT 
        f.order_number,
        f.product_key,
        f.order_date,
        f.sales,   
        f.quantity,
        c.customer_key,
        c.customer_number,
        (c.first_name || ' ' || c.last_name) AS customer_name,
        EXTRACT(YEAR FROM AGE(c.birth_date))::INT AS age
    FROM g_fact_sales f
    LEFT JOIN g_dim_customers c 
        ON f.customer_key = c.customer_key
    WHERE f.order_date IS NOT NULL
),
customer_aggregation AS (
    SELECT 
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales) AS total_sales,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        ( DATE_PART('year', AGE(MAX(order_date), MIN(order_date))) * 12 
          + DATE_PART('month', AGE(MAX(order_date), MIN(order_date))) ) AS time_spam
    FROM base_query
    GROUP BY customer_key, customer_number, customer_name, age
)
SELECT 
    customer_key,
    customer_number,
    customer_name,
    CASE 
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        ELSE '60 & Above'
    END AS age_group,
    CASE 
        WHEN time_spam >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN time_spam >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS cust_segmentation,
    last_order_date,
    ( DATE_PART('year', AGE(CURRENT_DATE, last_order_date)) * 12 
      + DATE_PART('month', AGE(CURRENT_DATE, last_order_date)) ) AS recency,
    total_orders,
    total_sales,
    total_quantity,
    total_products,
    time_spam,
    CASE 
    WHEN total_orders = 0 THEN 0
    ELSE ROUND((total_sales::numeric / total_orders), 2)
END AS avg_order_value,

CASE 
    WHEN time_spam = 0 THEN total_sales
    ELSE ROUND((total_sales::numeric / NULLIF(time_spam, 0))::numeric, 2)
END AS avg_monthly_value
FROM customer_aggregation;

SELECT * FROM g_customer_report LIMIT 20;
