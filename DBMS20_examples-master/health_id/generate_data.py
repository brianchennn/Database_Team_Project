import csv
import string
import random
import time

def random_date(prop, start="2020-2-1", end="2020-3-20", format='%Y-%m-%d'):
    stime = time.mktime(time.strptime(start, format))
    etime = time.mktime(time.strptime(end, format))

    ptime = stime + prop * (etime - stime)
    return time.strftime(format, time.localtime(ptime))

N = 700000

## Prepare airport iata data
iata_list = []
with open('airports.csv', 'r') as f:
    rows = csv.reader(f)
    next(rows)
    for row in rows:
        iata_list.append(row[0])
iata_len = len(iata_list)
upperEng = string.ascii_uppercase

## Generate every airports' flight_no
iata_flight_mapping = dict() ## key: iata, value: list of flight_no
for airport in iata_list:
    number = random.randint(2, 5)
    iata_flight_mapping[airport] = []
    for _ in range(number):
        iata_flight_mapping[airport].append(
            upperEng[random.randint(0, 25)] + \
            upperEng[random.randint(0, 25)] + \
            str(random.randint(13, 486)))

## Generate data
with open('user.csv', 'w') as f_user, open('inbound.csv', 'w') as f_inbound:
    writer_user, writer_inbound = csv.writer(f_user), csv.writer(f_inbound)
    writer_user.writerow(['ID', 'PID'])
    writer_inbound.writerow(['PID', 'IATA_code', 'flight_no', 'date'])
    for _ in range(N):
        id = upperEng[random.randint(0, 25)] + str(random.randint(100000000, 298697535))
        pid = upperEng[random.randint(0, 25)] + upperEng[random.randint(0, 25)]\
            + str(random.randint(10000000, 99765438))

        ## writer fake user data
        writer_user.writerow([id, pid])

        iata_code = iata_list[random.randint(0, iata_len-1)]
        flight_no = iata_flight_mapping[iata_code][\
                        random.randint(0, len(iata_flight_mapping[iata_code])-1)]
        date = random_date(random.random())

        ## writer fake inbound data
        writer_inbound.writerow([pid, iata_code, flight_no, date])