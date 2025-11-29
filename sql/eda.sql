-- 1. Tren Penjualan Harian (Daily Revenue Trend)
SELECT
    DATE_TRUNC('day', invoice_date)::date as transaction_date,
    COUNT(DISTINCT invoice_no) as total_transactions,
    SUM(total_sales) as daily_revenue
FROM
    clean_transactions
GROUP BY
    1
ORDER BY
    1;

-- 2. Top 10 Produk Terlaris (Best Sellers)
SELECT
    description,
    SUM(quantity) as total_quantity_sold,
    SUM(total_sales) as total_revenue
FROM
    clean_transactions
GROUP BY
    1
ORDER BY
    3 DESC
LIMIT
    10;

-- 3. Performa Penjualan per Negara
SELECT
    country,
    COUNT(DISTINCT customer_id) as total_customers,
    SUM(total_sales) as total_revenue,
    ROUND(
        (
            SUM(total_sales) / (
                SELECT
                    SUM(total_sales)
                FROM
                    clean_transactions
            ) * 100
        ),
        2
    ) as revenue_percentage
FROM
    clean_transactions
GROUP BY
    1
ORDER BY
    3 DESC;

-- 4. Jam Sibuk (Peak Hours Analysis)
SELECT
    EXTRACT(
        HOUR
        FROM
            invoice_date
    ) as hour_of_day,
    COUNT(DISTINCT invoice_no) as total_transactions,
    SUM(total_sales) as total_revenue
FROM
    clean_transactions
GROUP BY
    1
ORDER BY
    1;

-- 5. Rata-rata Nilai Keranjang Belanja (AOV)
WITH
    invoice_summary AS (
        SELECT
            invoice_no,
            SUM(total_sales) as invoice_value
        FROM
            clean_transactions
        GROUP BY
            1
    )
SELECT
    AVG(invoice_value) as average_order_value,
    MIN(invoice_value) as min_purchase,
    MAX(invoice_value) as max_purchase
FROM
    invoice_summary;