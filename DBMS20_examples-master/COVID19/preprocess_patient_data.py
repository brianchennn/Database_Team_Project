import csv

with open('patient_data.csv', 'r') as fr, open('new_patient_data.csv', 'w') as fw:
    rows = csv.reader(fr)
    writer = csv.writer(fw)
    writer.writerow(next(rows))
    for row in rows:
        if row[0] == '':
            continue

        row[2] = row[2].strip()
        if row[2] == '':
            row[2] = 'N/A'
        
        row[8] = row[8].split('-')[-1].strip()
        row[8] = '-'.join(row[8].split('.')[::-1])


        row[10] = row[10].split('-')[-1].strip()
        row[10] = '-'.join(row[10].split('.')[::-1])

        try:
            a = int(row[1])
        except:
            row[1] = -1

        writer.writerow(row)