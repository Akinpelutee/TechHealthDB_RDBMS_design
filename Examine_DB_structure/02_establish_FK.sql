-- Verify the foreign keys were created
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