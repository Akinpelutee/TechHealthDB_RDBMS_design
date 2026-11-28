-- 1. Check existing CHECK and UNIQUE constraints in the public schema
SELECT
    tc.table_name AS table_name,
    tc.constraint_name AS constraint_name,
    tc.constraint_type AS constraint_type,
    COALESCE(cc.check_clause, kcu.column_name) AS constraint_definition
FROM
    information_schema.table_constraints AS tc
LEFT JOIN
    information_schema.check_constraints AS cc
    ON tc.constraint_name = cc.constraint_name
    AND tc.constraint_schema = cc.constraint_schema
LEFT JOIN
    information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE
    tc.table_schema = 'public'
    AND tc.constraint_type IN ('CHECK', 'UNIQUE')
ORDER BY
    tc.table_name,
    tc.constraint_name;

-- Also check column DEFAULT values
SELECT
    table_name,
    column_name,
    column_default
FROM
    information_schema.columns
WHERE
    table_schema = 'public'
    AND column_default IS NOT NULL
ORDER BY
    table_name,
    ordinal_position;

-- 2. Add a DEFAULT value for firmware_version on devices
ALTER TABLE devices
ALTER COLUMN firmware_version SET DEFAULT 'v3.1.0';

-- 3. Add UNIQUE constraints for user_id and device_id
-- (Note: both are already PRIMARY KEYs, so uniqueness is already enforced)
ALTER TABLE customers
ADD CONSTRAINT uq_customers_userid UNIQUE (user_id);

ALTER TABLE devices
ADD CONSTRAINT uq_devices_deviceid UNIQUE (device_id);

-- 4. Verify constraints and defaults after changes
SELECT
    tc.table_name AS table_name,
    tc.constraint_name AS constraint_name,
    tc.constraint_type AS constraint_type,
    COALESCE(cc.check_clause, kcu.column_name) AS constraint_definition
FROM
    information_schema.table_constraints AS tc
LEFT JOIN
    information_schema.check_constraints AS cc
    ON tc.constraint_name = cc.constraint_name
    AND tc.constraint_schema = cc.constraint_schema
LEFT JOIN
    information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
    AND tc.table_schema = kcu.table_schema
WHERE
    tc.table_schema = 'public'
    AND tc.constraint_type IN ('CHECK', 'UNIQUE')
ORDER BY
    tc.table_name,
    tc.constraint_name;

SELECT
    table_name,
    column_name,
    column_default
FROM
    information_schema.columns
WHERE
    table_schema = 'public'
    AND column_default IS NOT NULL
ORDER BY
    table_name,
    ordinal_position;