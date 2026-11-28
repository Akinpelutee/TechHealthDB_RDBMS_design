-- 1. Examine the sales table for potential normalization issues
SELECT *
FROM sales
LIMIT 10;

-- 2. Examine the customers table for potential 3NF violations
SELECT *
FROM customers
LIMIT 10;

-- 3. Check for repeated product details in the sales table
SELECT
    product_id,
    product_name,
    product_category,
    COUNT(*) AS occurrence_count
FROM
    sales
GROUP BY
    product_id,
    product_name,
    product_category
ORDER BY
    occurrence_count DESC;

-- 4. Check for repeated location details in the customers table
SELECT
    city,
    state,
    country,
    COUNT(*) AS customer_count
FROM
    customers
GROUP BY
    city,
    state,
    country
ORDER BY
    customer_count DESC;