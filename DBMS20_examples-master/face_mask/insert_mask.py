import pymysql
import csv
import sys
import os
import pandas as pd

def connect2db():
    connection = pymysql.connect(
                host='localhost', db='dbms_2020',
                user='', passwd='', local_infile=True)
    mycursor = connection.cursor()
    return mycursor, connection

def insert2db(connection, mycursor, file_path):
    dump_sql = '''
        load data local infile '{}'
        into table mask
        character set 'utf8'
        fields terminated by ','
        enclosed by '"'
        lines terminated by '\n'
        ignore 1 lines;
    '''

    try:
        mycursor.execute(dump_sql.format(file_path))
        affect_count = mycursor.rowcount
    except pymysql.InternalError as error:
        code, message = error.args
        print(code, message)
        connection.rollback()
    else:
        print('Success')
        connection.commit()

if __name__ == '__main__':
    dirlist = '../../maskdata-backup/history'
    transfer_path = 'transfer.csv'
    alldir = os.listdir(dirlist)
    # mycursor, connection = connect2db()
    df_total = pd.DataFrame()

    for eachdir in alldir:
        dirname = dirlist + '/' + eachdir
        allfile = sorted(os.listdir(dirname))
        hourlist = [_ for _ in range(6,24,2)]

        #02-09 has many problems, so drop it directly
        if eachdir == '2020-02-09':
            continue

        seconddata = 0
        for cnt, file in enumerate(allfile):
            if len(hourlist) == 0:
                break
            hourtest = int(int(file.split('-')[-1].split('.')[0]) / 10000)
            month = file.split('-')[1]
            day = file.split('-')[2]
            if hourtest in hourlist:
                if seconddata == 0:
                    seconddata = 1
                else:
                    seconddata = 0
                    filename = dirname + '/' + file
                    print(filename)
                    hourlist.remove(hourtest)
                    df = None
                    # 02-10-200039 and 02-10-220039 need to change field name in csv
                    if month == '02' and int(day) < 11:
                        df = pd.read_csv(filename)[['醫事機構代碼', '成人口罩總剩餘數', '兒童口罩剩餘數', '來源資料時間']]
                        df.columns = ['醫事機構代碼', '成人口罩剩餘數', '兒童口罩剩餘數', '來源資料時間']
                    else:
                        df = pd.read_csv(filename)[['醫事機構代碼', '成人口罩剩餘數', '兒童口罩剩餘數', '來源資料時間']]
                    df_total = pd.concat([df_total, df], axis=0, ignore_index=True)
                    
                    # df = pd.read_csv(transfer_path)
                    # insert2db(connection, mycursor, transfer_path)
    df_total.to_csv(transfer_path, index=False)
    # mycursor.close()  ## here all loops done
    # connection.close()  ## close db connection