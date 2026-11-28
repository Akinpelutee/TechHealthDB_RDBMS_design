-- 1. Check the column details, default, and check constraint for product_category in sales
SELECT
    c.table_name AS table_name,
    c.column_name AS column_name,
    c.data_type AS data_type,
    c.character_maximum_length AS max_length,
    c.is_nullable AS is_nullable,
    c.column_default AS default_value,
    cc.check_clause AS check_constraint
FROM
    information_schema.columns AS c
LEFT JOIN
    information_schema.constraint_column_usage AS ccu
    ON c.table_schema = ccu.table_schema
    AND c.table_name = ccu.table_name
    AND c.column_name = ccu.column_name
LEFT JOIN
    information_schema.table_constraints AS tc
    ON ccu.constraint_schema = tc.constraint_schema
    AND ccu.constraint_name = tc.constraint_name
    AND tc.constraint_type = 'CHECK'
LEFT JOIN
    information_schema.check_constraints AS cc
    ON tc.constraint_schema = cc.constraint_schema
    AND tc.constraint_name = cc.constraint_name
WHERE
    c.table_schema = 'public'
    AND c.table_name = 'sales'
    AND c.column_name = 'product_category';

-- 2. Examine distinct values in product_category to check for multi-valued strings/lists
SELECT DISTINCT product_category
FROM sales;

-- 3. Check for primary keys across all tables in the public schema
SELECT
    tc.table_name AS table_name,
    kcu.column_name AS column_name,
    TRUE AS is_primary_key
FROM
    information_schema.table_constraints AS tc
INNER JOIN
    information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE
    tc.table_schema = 'public'
    AND tc.constraint_type = 'PRIMARY KEY'
ORDER BY
    tc.table_name,
    kcu.ordinal_position;