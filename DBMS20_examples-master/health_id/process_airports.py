import csv

with open('raw_airport.csv') as f, open('second_airport.csv', 'w') as f_w:
    rows = csv.reader(f)
    writer = csv.writer(f_w)
    iata_set = set()
    for row in rows:
        iata = row[0].split('(')[-1].split(')')[0].split(' ')[0]
        iata_set.add(iata)
    
    writer.writerow(['IATA_code', 'city', 'country'])
    for iata in iata_set:
        writer.writerow([iata,'',''])