SELECT
    tc.table_name,
    tc.constraint_name,
    tc.constraint_type,
    kcu.column_name,
    ccu.table_name AS referenced_table,
    ccu.column_name AS referenced_column,
    cc.check_clause
FROM
    information_schema.table_constraints AS tc
LEFT JOIN
    information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
LEFT JOIN
    information_schema.constraint_column_usage AS ccu
    ON tc.constraint_name = ccu.constraint_name
    AND tc.table_schema = ccu.table_schema
    AND tc.constraint_type = 'FOREIGN KEY'
LEFT JOIN
    information_schema.check_constraints AS cc
    ON tc.constraint_name = cc.constraint_name
    AND tc.constraint_schema = cc.constraint_schema
WHERE
    tc.table_schema = 'public'
    AND tc.table_name IN ('customers', 'devices', 'geolocation', 'healthmetrics', 'products', 'sales')
ORDER BY
    tc.table_name,
    tc.constraint_type,
    tc.constraint_name;