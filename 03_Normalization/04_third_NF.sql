-- ALTER TABLE geolocation
-- ALTER COLUMN state DROP NOT NULL;


-- Step 1: Insert any distinct city/state/country combinations from customers
-- that are not already in geolocation
INSERT INTO geolocation (city, state, country)
SELECT DISTINCT c.city, c.state, c.country
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM geolocation AS g
    WHERE g.city = c.city
      AND g.country = c.country
      AND g.state IS NOT DISTINCT FROM c.state
);

-- Step 2: Verify geolocation rows
SELECT *
FROM geolocation
ORDER BY geo_id;

-- Step 3: Add a UNIQUE constraint on (city, state, country) to prevent duplicate locations
-- (In PostgreSQL, NULLS NOT DISTINCT treats multiple NULL states as identical)
ALTER TABLE geolocation
ADD CONSTRAINT uq_geolocation_location
UNIQUE NULLS NOT DISTINCT (city, state, country);

-- Step 4: Add geo_id column to customers
ALTER TABLE customers
ADD COLUMN geo_id INT;

-- Step 5: Populate customers.geo_id from geolocation
UPDATE customers AS c
SET geo_id = g.geo_id
FROM geolocation AS g
WHERE c.city = g.city
  AND c.country = g.country
  AND c.state IS NOT DISTINCT FROM g.state;

-- Step 6: Verify geo_id is populated
SELECT *
FROM customers
ORDER BY geo_id;

-- Step 7: Add foreign key from customers.geo_id to geolocation.geo_id
ALTER TABLE customers
ADD CONSTRAINT fk_customers_geolocation
FOREIGN KEY (geo_id) REFERENCES geolocation(geo_id);

-- Step 8: Drop the now-redundant location columns from customers
ALTER TABLE customers
DROP COLUMN IF EXISTS city,
DROP COLUMN IF EXISTS state,
DROP COLUMN IF EXISTS country;

-- Step 9: Verify the updated customers rows
SELECT *
FROM customers
LIMIT 10;

-- Step 10: Test with a JOIN to verify the relationship
SELECT
    c.user_id,
    c.age,
    c.gender,
    c.occupation,
    c.income_bracket,
    c.subscription_type,
    c.registration_date,
    c.geo_id,
    g.city,
    g.state,
    g.country
FROM customers AS c
INNER JOIN geolocation AS g
    ON c.geo_id = g.geo_id
ORDER BY c.geo_id;