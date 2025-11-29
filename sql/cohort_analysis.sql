-- ANALISIS RETENSI KOHORT
-- Tujuan: Melihat seberapa setia user dari waktu ke waktu
WITH
    user_cohort AS (
        -- Langkah 1: Tentukan bulan pertama join setiap user
        SELECT
            customer_id,
            MIN(DATE_TRUNC('month', invoice_date))::date as cohort_month
        FROM
            clean_transactions
        GROUP BY
            customer_id
    ),
    transaction_month AS (
        -- Langkah 2: Gabungkan transaksi dengan info cohort user
        SELECT
            t.customer_id,
            uc.cohort_month,
            DATE_TRUNC('month', t.invoice_date)::date as invoice_month
        FROM
            clean_transactions t
            JOIN user_cohort uc ON t.customer_id = uc.customer_id
    ),
    cohort_logic AS (
        -- Langkah 3: Hitung selisih bulan (Cohort Index)
        SELECT
            cohort_month,
            invoice_month,
            -- Rumus Matematika: (Tahun Beda * 12) + Bulan Beda
            (
                EXTRACT(
                    YEAR
                    FROM
                        age (invoice_month, cohort_month)
                ) * 12 + EXTRACT(
                    MONTH
                    FROM
                        age (invoice_month, cohort_month)
                )
            ) as cohort_index,
            COUNT(DISTINCT customer_id) as total_users
        FROM
            transaction_month
        GROUP BY
            1,
            2
    )
    -- Output Final: Tabel Retensi
SELECT
    cohort_month,
    cohort_index, -- 0, 1, 2, 3... bulan setelah join
    total_users
FROM
    cohort_logic
ORDER BY
    cohort_month,
    cohort_index;