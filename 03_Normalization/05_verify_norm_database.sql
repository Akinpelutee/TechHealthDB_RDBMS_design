-- Test 1: Verify all foreign key relationships
SELECT
    tc.constraint_name AS foreign_key_name,
    tc.table_name AS table_name,
    kcu.column_name AS column_name,
    ccu.table_name AS referenced_table_name,
    ccu.column_name AS referenced_column_name
FROM
    information_schema.table_constraints AS tc
INNER JOIN
    information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
INNER JOIN
    information_schema.constraint_column_usage AS ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
WHERE
    tc.constraint_type = 'FOREIGN KEY'
    AND tc.table_schema = 'public'
ORDER BY
    tc.table_name,
    ccu.table_name;

-- Test 2: Join normalized tables (customers, geolocation, sales, products)
SELECT
    c.user_id,
    c.subscription_type,
    g.city,
    g.state,
    g.country,
    s.sale_id,
    s.sale_date,
    p.product_name,
    p.product_category,
    s.unit_price,
    s.quantity,
    s.total_amount
FROM
    customers AS c
INNER JOIN
    geolocation AS g ON c.geo_id = g.geo_id
INNER JOIN
    sales AS s ON c.user_id = s.user_id
INNER JOIN
    products AS p ON s.product_id = p.product_id
WHERE
    s.sale_date > DATE '2022-01-01'
ORDER BY
    s.sale_date DESC;