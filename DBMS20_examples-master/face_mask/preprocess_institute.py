import pymysql
import csv
import sys
import os
import pandas as pd
from datetime import datetime

if __name__ == '__main__':
    file_path = './data.csv'
    transfer_path = './institue_tgos.csv'

    df = pd.read_csv(file_path)[['醫事機構代碼', '醫事機構名稱', '電話', '地址', '終止合約或歇業日期', 'TGOS X', 'TGOS Y']]
    df = df[~df['終止合約或歇業日期'].notna()].reset_index(drop=True)[['醫事機構代碼', '醫事機構名稱', '電話', '地址', 'TGOS X', 'TGOS Y']]
    df.to_csv(transfer_path, index=False)