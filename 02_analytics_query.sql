QUERY 1 - REVENUE BY CATEGORY
SELECT 
    p.category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    SUM(oi.item_total) AS total_revenue,
    ROUND(AVG(oi.item_total), 2) AS avg_order_value,
    ROUND((SUM(oi.item_total) / 
        (SELECT SUM(item_total) FROM order_items)) * 100, 2) AS revenue_percentage
FROM order_items oi
INNER JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

QUERY 2 - TOP 10 CUSTOMERS BY REVENUE
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.item_total) AS total_spent,
    ROUND(AVG(oi.item_total), 2) AS avg_order_value,
    MAX(o.order_date) AS last_purchase_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city
ORDER BY total_spent DESC
LIMIT 10;

QUERY 3 - MONTHLY SALES TREND
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS unique_customers,
    SUM(oi.item_total) AS monthly_revenue,
    ROUND(AVG(oi.item_total), 2) AS avg_order_value
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY month ASC;

QUERY 4 - MONTH-OVER-MONTH GROWTH
WITH monthly_revenue AS (
    SELECT 
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(oi.item_total) AS revenue
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
)
SELECT 
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue,
    ROUND(
        ((revenue - LAG(revenue) OVER (ORDER BY month)) / 
         LAG(revenue) OVER (ORDER BY month) * 100), 2
    ) AS growth_percentage
FROM monthly_revenue
ORDER BY month;

QUERY 5 - BEST SELLING PRODUCTS
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.item_total) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS times_purchased,
    ROUND(AVG(oi.quantity), 2) AS avg_quantity_per_order
FROM products p
INNER JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price
ORDER BY total_revenue DESC
LIMIT 10;

QUERY 6 - CUSTOMER SEGMENTATION
WITH customer_metrics AS (
    SELECT 
        c.customer_id,
        c.customer_name,
        c.city,
        COUNT(DISTINCT o.order_id) AS frequency,
        MAX(o.order_date) AS recency,
        DATEDIFF('2024-07-15', MAX(o.order_date)) AS days_since_last_order,
        SUM(oi.item_total) AS monetary_value
    FROM customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name, c.city
)
SELECT 
    customer_id,
    customer_name,
    city,
    frequency,
    days_since_last_order,
    monetary_value,
    CASE 
        WHEN monetary_value >= 50000 AND days_since_last_order <= 30 THEN 'VIP - High Value'
        WHEN monetary_value >= 30000 AND days_since_last_order <= 60 THEN 'Premium'
        WHEN monetary_value >= 10000 THEN 'Regular'
        ELSE 'At Risk'
    END AS customer_segment
FROM customer_metrics
ORDER BY monetary_value DESC;

QUERY 7 - PRODUCT PERFORMANCE RANKING
SELECT 
    p.product_name,
    p.category,
    p.price,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.item_total) AS revenue,
    RANK() OVER (ORDER BY SUM(oi.item_total) DESC) AS revenue_rank,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS category_rank,
    PERCENT_RANK() OVER (ORDER BY SUM(oi.item_total) DESC) * 100 AS percentile_rank
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price
ORDER BY revenue DESC;

QUERY 8 - ORDER VALUE DISTRIBUTION
WITH order_totals AS (
    SELECT 
        o.order_id,
        o.customer_id,
        SUM(oi.item_total) AS order_value
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id, o.customer_id
),
distribution AS (
    SELECT 
        CASE 
            WHEN order_value < 5000 THEN '< 5K'
            WHEN order_value < 10000 THEN '5K - 10K'
            WHEN order_value < 50000 THEN '10K - 50K'
            ELSE '> 50K'
        END AS order_value_range,
        order_value
    FROM order_totals
)
SELECT 
    order_value_range,
    COUNT(*) AS number_of_orders,
    ROUND(AVG(order_value), 2) AS avg_value,
    MIN(order_value) AS min_value,
    MAX(order_value) AS max_value
FROM distribution
GROUP BY order_value_range
ORDER BY MIN(order_value) ASC;

QUERY 9 - CITY WISE SALES
SELECT 
    c.city,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.item_total) AS total_revenue,
    ROUND(AVG(oi.item_total), 2) AS avg_order_value,
    ROUND(SUM(oi.item_total) / COUNT(DISTINCT c.customer_id), 2) AS revenue_per_customer
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.city
ORDER BY total_revenue DESC;

QUERY 10 - CUMMULATIVE REVENUE OVER TIME
WITH daily_revenue AS (
    SELECT 
        o.order_date,
        SUM(oi.item_total) AS daily_revenue
    FROM orders o
    INNER JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT 
    order_date,
    daily_revenue,
    SUM(daily_revenue) OVER (ORDER BY order_date) AS cumulative_revenue,
    ROUND(
        SUM(daily_revenue) OVER (ORDER BY order_date) / 
        (SELECT SUM(daily_revenue) FROM daily_revenue) * 100, 2
    ) AS percentage_of_total
FROM daily_revenue
ORDER BY order_date;
