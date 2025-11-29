-- ANALISIS SEGMENTASI RFM
-- Tujuan: Memberikan skor 1-5 untuk setiap customer berdasarkan perilaku belanja
WITH
    rfm_metrics AS (
        SELECT
            customer_id,
            -- Recency: Selisih hari dari tanggal 2011-12-10
            EXTRACT(
                DAY
                FROM
                    '2011-12-10'::timestamp - MAX(invoice_date)
            ) as recency_days,
            -- Frequency: Jumlah transaksi unik (bukan jumlah barang!)
            COUNT(DISTINCT invoice_no) as frequency_count,
            -- Monetary: Total belanja
            SUM(total_sales) as monetary_value
        FROM
            clean_transactions
        GROUP BY
            customer_id
    ),
    rfm_scores AS (
        SELECT
            *,
            -- Membagi data menjadi 5 grup (1=Terburuk, 5=Terbaik)
            -- Note: Untuk Recency, makin KECIL angkanya makin BAGUS (Skor 5)
            NTILE(5) OVER (
                ORDER BY
                    recency_days DESC
            ) as r_score,
            NTILE(5) OVER (
                ORDER BY
                    frequency_count ASC
            ) as f_score,
            NTILE(5) OVER (
                ORDER BY
                    monetary_value ASC
            ) as m_score
        FROM
            rfm_metrics
    )
    -- Output Final: Gabungkan Skor (misal: "555" adalah user Juara)
SELECT
    customer_id,
    recency_days,
    frequency_count,
    monetary_value,
    r_score,
    f_score,
    m_score,
    CAST(r_score AS VARCHAR) || CAST(f_score AS VARCHAR) || CAST(m_score AS VARCHAR) as rfm_segment
FROM
    rfm_scores
ORDER BY
    monetary_value DESC;