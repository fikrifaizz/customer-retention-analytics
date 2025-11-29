from ucimlrepo import fetch_ucirepo 
import pandas as pd
import os

def run_extract():
    raw_dir = './data/raw'
    os.makedirs(raw_dir, exist_ok=True)
    
    csv_filename = 'online_retail_raw.csv'
    csv_path = os.path.join(raw_dir, csv_filename)
    
    if os.path.exists(csv_path):
        print(f"File raw sudah tersedia di: {csv_path}")
        print("Melewati proses unduh untuk menghemat waktu.")
        return
    
    print("Mengambil data dari UCI Repo (ID=352)...")
    online_retail = fetch_ucirepo(id=352)
    
    # Mulai dengan features sebagai base dataframe
    df = online_retail.data.features.copy()
    
    if online_retail.data.targets is not None:
        df_targets = online_retail.data.targets
        if not df_targets.empty:
            df = pd.concat([df, df_targets], axis=1)
    
    if online_retail.data.ids is not None:
        df_ids = online_retail.data.ids
        if not df_ids.empty:
            df = pd.concat([df_ids, df], axis=1)
    
    print(f"Berhasil mengunduh {df.shape[0]} baris, {df.shape[1]} kolom")
    print(f"Kolom: {list(df.columns)}")
    
    df.to_csv(csv_path, index=False)
    print(f"Selesai. Data disimpan ke {csv_path}")

    return df