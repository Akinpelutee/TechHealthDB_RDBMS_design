SELECT
    table_name,
    ordinal_position AS col_order,
    column_name,
    data_type,
    COALESCE(character_maximum_length, numeric_precision) AS length_or_precision,
    is_nullable
FROM
    information_schema.columns
WHERE
    table_schema = 'public'
    AND table_name IN ('customers', 'devices', 'geolocation', 'healthmetrics', 'products', 'sales')
ORDER BY
    table_name,
    ordinal_position;