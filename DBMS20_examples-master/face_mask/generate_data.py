import pandas as pd
import random
import string
import datetime

def generateDateTime():
    dt = datetime.datetime(2020, 2, 2)
    end = datetime.datetime(2020, 2, 29)
    step = datetime.timedelta(days=1)
    result = []

    while dt <= end:
        result.append(dt.strftime('%Y-%m-%d'))
        dt += step
    return result

if __name__ == '__main__':
    dirlist = './institute.csv'
    transfer_path = './record.csv'
    DATA_NUMBER = 10000
    upperEng = string.ascii_uppercase

    # exist = []
    # i = 0
    # while i < DATA_NUMBER:
    #     id = upperEng[random.randint(0, 25)] + str(random.randint(100000000, 298697535))
    #     if id not in exist:
    #         exist.append(id)
    #         i += 1
    df = pd.read_csv(dirlist)
    df = df[df['醫事機構地址'].str.contains('新竹市')]['醫事機構代碼'].reset_index(drop=True)
    days = generateDateTime()

    total_id = []
    total_inst_id = []
    total_get = []
    total = pd.DataFrame()
    
    # Assume period is one week, different with reality
    for i in range(0, len(days), 7):
        random_day = [random.randint(0, 6) for _ in range(DATA_NUMBER)]
        
        exist = []
        cnt = 0
        while cnt < DATA_NUMBER:
            id = upperEng[random.randint(0, 25)] + str(random.randint(DATA_NUMBER, DATA_NUMBER * 1.1))
            if id not in exist:
                exist.append(id)
                cnt += 1
        id_list = exist.copy()

        for j, each_id in enumerate(id_list):
            total_id.append(each_id)
            total_inst_id.append(df[random.randint(0, len(df)-1)])
            date = days[i+random_day[j]] + ' ' + str(random.randint(10, 18)) + ':' + str(random.randint(0, 59)) + ':' + str(random.randint(0,59))
            total_get.append(date)

    total['id'] = total_id
    total['inst_id'] = total_inst_id
    total['get'] = total_get
    total.to_csv(transfer_path, index=False)