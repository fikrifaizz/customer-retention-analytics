DROP TABLE IF EXISTS clean_transactions;

CREATE TABLE clean_transactions (
    invoice_no VARCHAR(20),
    stock_code VARCHAR(20),
    description TEXT,
    quantity INTEGER,
    invoice_date TIMESTAMP,
    unit_price NUMERIC(10, 2),
    customer_id INTEGER,
    country VARCHAR(50),
    total_sales NUMERIC(15, 2)
);