-- 1. Check if products already has duplicate product_id values (must return 0 rows)
SELECT product_id, COUNT(*) AS cnt
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- 2. Find CHECK constraints on sales (look for the one on product_category)
SELECT
    tc.constraint_name,
    cc.check_clause
FROM
    information_schema.table_constraints AS tc
INNER JOIN
    information_schema.check_constraints AS cc
    ON tc.constraint_name = cc.constraint_name
    AND tc.constraint_schema = cc.constraint_schema
WHERE
    tc.table_schema = 'public'
    AND tc.table_name = 'sales';

-- 3. Drop the CHECK constraint blocking column removal (replace <constraint_name> from Step 2)
-- ALTER TABLE sales
-- DROP CONSTRAINT IF EXISTS "((product_category)::text = ANY ((ARRAY['Device'::character varying, 'Accessory'::character varying, 'Subscription'::character varying])::text[]))";

-- 4. Remove redundant product_name and product_category columns from sales
ALTER TABLE sales
DROP COLUMN IF EXISTS product_name,
DROP COLUMN IF EXISTS product_category;

-- 5. Add UNIQUE constraint on product_id in products (if not already unique)
ALTER TABLE products
ADD CONSTRAINT uq_products_product_id UNIQUE (product_id);

-- 6. Link sales.product_id to products.product_id via foreign key
ALTER TABLE sales
ADD CONSTRAINT fk_sales_products
FOREIGN KEY (product_id) REFERENCES products(product_id);

-- 7. Verify updated sales columns and test the JOIN with products
SELECT *
FROM sales
LIMIT 10;

SELECT
    s.sales_id,
    s.user_id,
    s.sale_date,
    s.product_id,
    p.product_name,
    p.product_category,
    s.unit_price,
    s.quantity,
    s.total_amount
FROM
    sales AS s
INNER JOIN
    products AS p ON s.product_id = p.product_id
ORDER BY
    s.sale_date DESC;