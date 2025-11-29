# Customer Segmentation & Retention Strategy (End-to-End Data Project)

![Python](https://img.shields.io/badge/Python-3.11%2B-blue)
![SQL](https://img.shields.io/badge/PostgreSQL-Data%20Warehouse-336791)
![Machine Learning](https://img.shields.io/badge/Sklearn-KMeans%20Clustering-orange)
![Dashboard](https://img.shields.io/badge/Google%20Sheets-Interactive%20Dashboard-green)

## Executive Summary
Proyek ini bertujuan untuk mengatasi masalah Churn Rate yang tinggi pada bisnis retail online dengan mengubah strategi pemasaran dari Generic (Mass) menjadi Targeted (Segmented).

Menggunakan dataset transaksi retail UK (500.000+ baris data), saya membangun pipeline ETL otomatis, melakukan analisis Cohort untuk mengukur retensi, dan menerapkan Unsupervised Machine Learning (K-Means) untuk mengelompokkan pelanggan secara statistik.

**Key Results:**
* Identifikasi **3 Persona Pelanggan Utama**: Champions (VIP), Potential Loyalist, dan Hibernating.
* Validasi statistik menunjukkan segmen Champions memiliki rata-rata belanja **5.6x lebih tinggi** dibanding segmen lain (P-Value < 0.05).
* Menemukan **Critical Drop-off sebesar 63%** pada bulan pertama setelah akuisisi user baru (berdasarkan Cohort Analysis).

---

## Project Architecture

Solusi ini dibangun dengan pendekatan Hybrid (Python + SQL + Sheets) untuk meniru lingkungan kerja industri data science yang skalabel.

Alur data dimulai dari dataset mentah UCI yang diproses menggunakan Python (ETL) untuk pembersihan. Data bersih disimpan ke PostgreSQL sebagai Data Warehouse. Analisis bisnis (RFM & Cohort) dilakukan menggunakan SQL, dilanjutkan dengan validasi statistik dan clustering di Python, sebelum hasil akhirnya divisualisasikan menjadi dashboard interaktif di Google Sheets.

---

## Technical Approach & Math Logic

### 1. Data Engineering (ETL)
* **Modular Scripting:** Menggunakan skrip terpisah (extract.py, transform.py, load.py) untuk menjaga prinsip Separation of Concerns.
* **Caching Mechanism:** Mengunduh data sekali dari UCI Repo, lalu menyimpannya secara lokal (raw csv) untuk efisiensi komputasi.
* **Data Wrangling:** Membersihkan 135.000+ baris tanpa Customer ID dan memfilter transaksi retur (Invoice diawali kode 'C') untuk menjaga integritas data penjualan.

### 2. SQL Analytics
* **RFM Analysis:** Menghitung Recency, Frequency, Monetary menggunakan Window Functions (NTILE) untuk scoring awal.
* **Cohort Analysis:** Menggunakan teknik Self-Join dan kalkulasi selisih bulan (DATE_TRUNC) untuk membangun Heatmap Retensi Pelanggan.

### 3. Machine Learning (Clustering)
* **Preprocessing:** Menangani Skewed Data (distribusi condong) pada kolom Monetary dengan **Log Transformation** agar algoritma K-Means bekerja optimal.
* **Modeling:** Menggunakan algoritma **K-Means Clustering**.
* **Validation:**
    * **Elbow Method & Silhouette Score:** Menentukan jumlah cluster optimal (K=3) berdasarkan kohesi dan separasi data.
    * **Hypothesis Testing (T-Test):** Membuktikan bahwa perbedaan rata-rata belanja antar cluster adalah Signifikan (P-Value < 0.05) dan bukan kebetulan statistik.

---

## Business Insights & Dashboard

Hasil analisis disajikan dalam bentuk Strategic Dashboard di Google Sheets untuk memberikan gambaran makro kepada pemangku kepentingan (stakeholders).

**Dashboard Highlights:**
* **Key Performance Indicators (Scorecards):** Menampilkan metrik utama bisnis seperti Total Revenue, Total Active Customers, dan Average Revenue Per User (ARPU).
* **Customer Distribution (Donut Chart):** Memvisualisasikan proporsi jumlah pelanggan antar segmen.
* **Revenue Contribution (Bar Chart):** Menunjukkan dominasi kontribusi pendapatan dari segmen Champions (Pareto Principle).

**Segment Profiles:**

| Cluster Name | Karakteristik | Rekomendasi Strategi |
| :--- | :--- | :--- |
| **Champions (VIP)** | Baru beli (Recency rendah), Frekuensi tinggi, Monetary sangat besar ($7k+) | Program Loyalty Eksklusif, Early Access Produk Baru. |
| **Potential Loyalist** | Nilai belanja lumayan, namun frekuensi transaksi masih sedang | Cross-selling & Bundling untuk meningkatkan nilai keranjang (Basket Size). |
| **Lost** | Sudah lama tidak belanja (>5 bulan) | Win-back Campaign agresif (Diskon besar atau Email Reminder). |

---

## Repository Structure

```text
customer-retention-analytics/
├── data/
│   ├── raw/                 # File CSV mentah (Input)
│   └── processed/           # Data bersih siap olah (Output ETL)
├── notebooks/
│   ├── data_assessment.ipynb    # EDA & Diagnosis Data
│   └── customer_segmentation.ipynb # K-Means Modeling & Statistical Test
├── src/
│   ├── main.py
│   ├── extract.py           # Skrip unduh data dari UCI
│   ├── transform.py         # Logika pembersihan data (Wrangling)
│   └── load.py              # Skrip penyimpanan data
├── sql/
│   ├── schema_setup.sql   # DDL untuk PostgreSQL
│   ├── eda.sql   # EDA & Diagnosis Data
│   ├── rfm_analysis.sql   # Query Segmentasi RFM
│   └── cohort_analysis.sql # Query Retensi Kohort
└── README.md                # Dokumentasi Proyek
```

## How to Run 

**1. Clone Repository**

```bash
git clone https://github.com/fikrifaizz/customer-retention-analytics.git
```

**2. Install Dependencies**

```bash
pip install -r requirements.txt
```

**3. Run ETL Pipeline**

```bash
python src/extract.py   # Download data
python src/main.py # Clean & Process data
```

**4. Database Setup**

- Buat database retail_db di PostgreSQL.

- Jalankan query di sql/schema_setup.sql.

- Import file data/processed/clean_data.csv.

**5. Run Analysis**

- Buka notebooks/customer_segmentation.ipynb untuk menjalankan proses Clustering dan Validasi Statistik.

**Author**

Fikri Faiz Zulfadhli | Mathematics Graduate | Aspiring Data Analyst