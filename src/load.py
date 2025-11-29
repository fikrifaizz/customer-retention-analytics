import pandas as pd
import os

def run_load(df, filename):
    processed_dir = './data/processed'
    os.makedirs(processed_dir, exist_ok=True)
    output_path = os.path.join(processed_dir, filename)
    df.to_csv(output_path, index=False)
    print(f"Lokasi File berada di : {os.path.abspath(output_path)}")