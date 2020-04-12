import pymysql
import csv
import sys
import os
import pandas as pd
from datetime import datetime

if __name__ == '__main__':
    file_path = './TCDCTravelAlert.csv'
    transfer_path = './TravelAlert.csv'

    df = pd.read_csv(file_path)[['areaDesc_EN', 'severity_level', 'instruction']]
    for i in range(len(df)):
        if df['areaDesc_EN'][i] == 'Hong Kong SAR':
            df['areaDesc_EN'][i] = 'Hong Kong'
        elif df['areaDesc_EN'][i] == 'China':
            df['areaDesc_EN'][i] = 'Mainland China'
        elif df['areaDesc_EN'][i] == 'Korea(South Korea)':
            df['areaDesc_EN'][i] = 'South Korea'
        elif df['areaDesc_EN'][i] == 'Macau SAR':
            df['areaDesc_EN'][i] = 'Macau'
    df.to_csv(transfer_path, index=False)