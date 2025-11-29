from extract import run_extract
from transform import run_transform
from load import run_load
import pandas as pd

if __name__ == "__main__":
    # Extract
    data = run_extract()
    
    # Transform
    data_raw = pd.read_csv("./data/raw/online_retail_raw.csv", encoding="ISO-8859-1")
    data_clean = run_transform(data_raw)
    
    # Load
    run_load(data_clean, "clean_data.csv")
