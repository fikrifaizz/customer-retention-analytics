import pandas as pd

def run_transform(df):

    # Drop Null
    initial_row = len(df)
    df_clean = df.dropna(subset=['CustomerID']).copy()
    print(f"Jumlah Baris sebelum Drop Missing ID : {initial_row}")
    print(f"Jumlah Baris setelah Drop Missing ID : {len(df_clean)}")
    
    # Drop Duplicates
    row_after_missing = len(df_clean)
    df_clean = df_clean.drop_duplicates()
    print(f"Jumlah Baris sebelum Drop duplikat : {row_after_missing}")
    print(f"Jumlah Baris setelah Drop duplikat : {len(df_clean)}")

    # Cancelled Transactions (InvoiceNo starts with 'C')
    df_clean['InvoiceNo'] = df_clean['InvoiceNo'].astype(str)
    df_clean = df_clean[~df_clean['InvoiceNo'].str.startswith('C')]

    # Filter Nilai Positif
    df_clean = df_clean[(df_clean['Quantity'] > 0) & (df_clean['UnitPrice'] > 0)]

    # Fix Data Types
    df_clean['InvoiceDate'] = pd.to_datetime(df_clean['InvoiceDate'])
    df_clean['CustomerID'] = df_clean['CustomerID'].astype(int)

    # Menambah kolom TotalSales (Untuk analisis Monetary)
    df_clean['TotalSales'] = df_clean['Quantity'] * df_clean['UnitPrice']

    final_rows = len(df_clean)
    print(f"Data Sebelum Dibersihkan : {initial_row}")
    print(f"Data Setelah Dibersihkan : {final_rows}")

    return df_clean
