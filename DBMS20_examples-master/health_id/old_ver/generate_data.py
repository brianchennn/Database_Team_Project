import csv
import random
import string

## Preparing places list
places_list = []
with open('places.csv', 'r') as f:
    rows = csv.reader(f)
    next(rows)
    for row in rows:
        places_list.append(row)
num_places_list = len(places_list)-1

## Preparing arrived time list
time_list = set()
with open('time.csv', 'r') as f:
    rows = csv.reader(f)
    next(rows)
    for row in rows:
        if len(row) == 0:
            continue
        time_list.add(row[0])
time_list = list(time_list)
num_time_list = len(time_list)-1


## (id_card, Province/State, Country/Region, time)
upperEng = string.ascii_uppercase
with open('fake_data.csv', 'w') as f:
    writer = csv.writer(f)
    writer.writerow(['id_card', 'Province/State', 'Country/Region', 'time'])
    for _ in range(1000):
        id = upperEng[random.randint(0, 25)] + str(random.randint(100000000, 298697535))
        state, country = places_list[random.randint(0, num_places_list)]
        time = time_list[random.randint(0, num_time_list)]
        writer.writerow([id, state, country, time])