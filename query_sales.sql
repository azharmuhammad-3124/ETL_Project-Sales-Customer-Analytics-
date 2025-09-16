---1. Create staging table---

DROP TABLE IF EXISTS g_fact_sales_staging;

CREATE TABLE g_fact_sales_staging (
    order_number TEXT,
    customer_key TEXT,
    product_key TEXT,
    order_date TEXT,
    shipping_date TEXT,
    due_date TEXT,
    sales TEXT,
    quantity TEXT,
    price TEXT
);

---2. Import CSV into staging table---

COPY g_fact_sales_staging
FROM 'E:/FTDS/Notes/zoom_project/g_fact_sales.csv'
DELIMITER ',' CSV HEADER ENCODING 'LATIN1';

---3. Create clean table---

DROP TABLE IF EXISTS g_fact_sales;

CREATE TABLE g_fact_sales (
    order_number VARCHAR(50),
    customer_key INT,
    product_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales NUMERIC,
    quantity INT,
    price NUMERIC
);

---4. Insert into clean table---

INSERT INTO g_fact_sales
SELECT
    order_number,
    customer_key::INT,
    product_key::INT,
    NULLIF(order_date, '')::DATE,
    NULLIF(shipping_date, '')::DATE,
    NULLIF(due_date, '')::DATE,
    NULLIF(sales, '')::NUMERIC,
    NULLIF(quantity, '')::INT,
    NULLIF(price, '')::NUMERIC
FROM g_fact_sales_staging;

---5.Verify---

SELECT COUNT(*) FROM g_fact_sales;
SELECT * FROM g_fact_sales LIMIT 10;

