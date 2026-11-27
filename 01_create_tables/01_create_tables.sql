--Create Customers Table
CREATE TABLE customers(
	user_id VARCHAR(10) PRIMARY KEY,
	age INT NOT NULL CHECK(age BETWEEN 0 AND 120),
	gender CHAR(1) NOT NULL CHECK(gender IN('M', 'F')),
	city VARCHAR(100) NOT NULL,
	state VARCHAR(50),
	country VARCHAR(50) NOT NULL,
	occupation VARCHAR(100),
	income_bracket VARCHAR(20),
	registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
	subscription_type VARCHAR(50) NOT NULL CHECK(subscription_type IN('Basic','Premium','Enterprise'))
);

--Create the Sales Table
CREATE TABLE sales(
	sales_id VARCHAR(10) PRIMARY KEY,
	user_id VARCHAR(10) NOT NULL,
	sale_date DATE NOT NULL DEFAULT CURRENT_DATE,
	product_id VARCHAR(20) NOT NULL,
	product_name VARCHAR(100) NOT NULL,
	product_category VARCHAR(100) NOT NULL CHECK(product_category IN('Device','Accessory','Subscription')),
	unit_price DECIMAL(10,2) NOT NULL CHECK(unit_price >= 0),
	quantity INT NOT NULL CHECK(quantity > 0),
	discount_applied DECIMAL(5,2) CHECK(discount_applied BETWEEN 0 AND 100),
	total_amount DECIMAL(10,2) NOT NULL CHECK(total_amount > 0),
	payment_method VARCHAR(50) NOT NULL CHECK(payment_method IN('Credit Card','PayPal','Bank Transfer')),
	subscription_plan VARCHAR(50),
    sales_channel VARCHAR(50) NOT NULL CHECK (sales_channel IN ('Online', 'Retail', 'Direct Sales')),
    region VARCHAR(50) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL
);

-- Create the HealthMetrics table
CREATE TABLE healthmetrics (
    record_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    month_date DATE NOT NULL,
    avg_heart_rate INT NOT NULL CHECK (avg_heart_rate BETWEEN 30 AND 200),
    avg_resting_heart_rate INT NOT NULL CHECK (avg_resting_heart_rate BETWEEN 30 AND 100),
    avg_daily_steps INT NOT NULL CHECK (avg_daily_steps >= 0),
    avg_sleep_hours DECIMAL(3,1) NOT NULL CHECK (avg_sleep_hours BETWEEN 0 AND 24),
    avg_deep_sleep_hours DECIMAL(3,1) NOT NULL CHECK (avg_deep_sleep_hours BETWEEN 0 AND 12),
    avg_daily_calories INT NOT NULL CHECK (avg_daily_calories >= 0),
    avg_exercise_minutes INT NOT NULL CHECK (avg_exercise_minutes >= 0),
    avg_stress_level DECIMAL(3,1) CHECK (avg_stress_level BETWEEN 0 AND 10),
    avg_blood_oxygen DECIMAL(4,1) NOT NULL CHECK (avg_blood_oxygen BETWEEN 80 AND 100),
    total_active_days INT NOT NULL CHECK (total_active_days BETWEEN 0 AND 31),
    workout_frequency INT NOT NULL CHECK (workout_frequency BETWEEN 0 AND 7),
    achievement_rate DECIMAL(3,2) CHECK (achievement_rate BETWEEN 0 AND 1)
);

-- Create the Devices table
CREATE TABLE devices (
    device_id VARCHAR(10) PRIMARY KEY,
    user_id VARCHAR(10) NOT NULL,
    device_type VARCHAR(100) NOT NULL,
    purchase_date DATE NOT NULL DEFAULT CURRENT_DATE,
    last_sync_date DATE NOT NULL,
    firmware_version VARCHAR(10) NOT NULL,
    battery_life_days DECIMAL(3,1) NOT NULL CHECK (battery_life_days >= 0),
    sync_frequency_daily INT NOT NULL CHECK (sync_frequency_daily >= 0),
    active_hours_daily DECIMAL(3,1) NOT NULL CHECK (active_hours_daily BETWEEN 0 AND 24),
    total_steps_recorded BIGINT NOT NULL CHECK (total_steps_recorded >= 0),
    total_workouts_recorded INT NOT NULL CHECK (total_workouts_recorded >= 0),
    sleep_tracking_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    heart_rate_monitoring_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    gps_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    notification_enabled BOOLEAN NOT NULL DEFAULT FALSE,
    device_status VARCHAR(50) NOT NULL CHECK (device_status IN ('Active', 'Inactive', 'Retired'))
);


--Let's create a product table because the sales table has a product_id and product_name but no product table to reference. This will help in maintaining data integrity and avoid redundancy.
CREATE TABLE products (
    product_id VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50) NOT NULL CHECK (product_category IN ('Device', 'Accessory', 'Subscription')),
    base_price DECIMAL(10,2) NOT NULL CHECK (base_price >= 0),
    is_subscription BOOLEAN NOT NULL DEFAULT FALSE
);