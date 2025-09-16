---1. Create staging table---

DROP TABLE IF EXISTS g_dim_customers_staging;

CREATE TABLE g_dim_customers_staging (
    customer_key TEXT,
    customer_id TEXT,
    customer_number TEXT,
    first_name TEXT,
    last_name TEXT,
    country TEXT,
    gender TEXT,
    marital_status TEXT,
    birth_date TEXT,
    create_date TEXT
);

---2. Import CSV into staging table---

COPY g_dim_customers_staging
FROM 'E:/FTDS/Notes/zoom_project/g_dim_customers.csv'
DELIMITER ',' CSV HEADER ENCODING 'LATIN1';

---3. Create clean table---

DROP TABLE IF EXISTS g_dim_customers;

CREATE TABLE g_dim_customers (
    customer_key INT,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    country VARCHAR(100),
    gender VARCHAR(20),
    marital_status VARCHAR(20),
    birth_date DATE,
    create_date DATE
);

---4. Insert into clean table---

INSERT INTO g_dim_customers
SELECT
    customer_key::INT,
    customer_id::INT,
    customer_number,
    first_name,
    last_name,
    country,
    gender,
    marital_status,
    NULLIF(birth_date, '')::DATE,
    NULLIF(create_date, '')::DATE
FROM g_dim_customers_staging;

--5. Verify---

SELECT COUNT(*) FROM g_dim_customers;
SELECT * FROM g_dim_customers LIMIT 10;