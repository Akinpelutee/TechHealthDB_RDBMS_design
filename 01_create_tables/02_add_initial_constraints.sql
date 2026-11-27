--Add table relationships and constraints by lining sales to customers
ALTER TABLE sales
ADD CONSTRAINT fk_sales_customers
FOREIGN KEY (user_id) REFERENCES customers(user_id)
ON DELETE CASCADE
ON UPDATE CASCADE;

--Add table relationships by linking Healthmetrics to customers table
ALTER TABLE healthmetrics
ADD CONSTRAINT fk_healthmetrics_customers
FOREIGN KEY (user_id) REFERENCES customers(user_id)
ON DELETE CASCADE ON UPDATE CASCADE;

--Add table relatonships by linking devices table to customers table
ALTER TABLE devices
ADD CONSTRAINT fk_devices_customers
FOREIGN KEY (user_id) REFERENCES customers(user_id)
ON DELETE CASCADE ON UPDATE CASCADE;
