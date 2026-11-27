-- Step 1: Examine the structure of the tables in the public schema
SELECT
    c.table_name AS table_name,
    c.column_name AS column_name,
    c.data_type AS data_type,
    COALESCE(c.character_maximum_length, c.numeric_precision) AS max_length_or_precision,
    c.is_nullable AS is_nullable
FROM
    information_schema.columns c
INNER JOIN
    information_schema.tables t
    ON c.table_schema = t.table_schema
    AND c.table_name = t.table_name
WHERE
    c.table_schema = 'public'
    AND t.table_type = 'BASE TABLE'
ORDER BY
    c.table_name,
    c.ordinal_position;

-- Step 2: Check for existing primary keys and indexes
SELECT
    t.relname AS table_name,
    i.relname AS index_name,
    am.amname AS index_type,
    a.attname AS column_name,
    idx.indisprimary AS is_primary_key
FROM
    pg_index idx
INNER JOIN
    pg_class t ON t.oid = idx.indrelid
INNER JOIN
    pg_class i ON i.oid = idx.indexrelid
INNER JOIN
    pg_am am ON am.oid = i.relam
INNER JOIN
    pg_namespace n ON n.oid = t.relnamespace
INNER JOIN
    pg_attribute a ON a.attrelid = t.oid AND a.attnum = ANY(idx.indkey)
WHERE
    n.nspname = 'public'
    AND a.attnum > 0
ORDER BY
    t.relname,
    i.relname,
    a.attnum;

-- Step 3: Sample data from tables to understand content
SELECT * FROM customers LIMIT 5;
SELECT * FROM devices LIMIT 5;
SELECT * FROM sales LIMIT 5;
SELECT * FROM healthmetrics LIMIT 5;