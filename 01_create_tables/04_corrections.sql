-- Drop the wrong one (0 to 20)
ALTER TABLE customers 
DROP CONSTRAINT customers_age_check;

-- Add the correct one (0 to 120)
ALTER TABLE customers 
ADD CONSTRAINT customers_age_check 
CHECK (age BETWEEN 0 AND 120);

ALTER TABLE sales
DROP CONSTRAINT sales_payment_method_check;

ALTER TABLE sales
ADD CONSTRAINT sales_payment_method_check
CHECK (payment_method IN ('Credit Card', 'PayPal', 'Bank Transfer'));

