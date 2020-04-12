import csv

with open('accumulate_data.csv', 'r') as fr, open('new_accumulate_data.csv', 'w') as fw:
    rows = csv.reader(fr)
    writer = csv.writer(fw)
    writer.writerow(next(rows))
    for row in rows:
        split_tokens = row[2].split(' ')[0].split('T')[0].split('/')
        if len(split_tokens) != 1:
            if len(split_tokens[2]) == 4:   ## 1/22/2020 case
                row[2] = f'{split_tokens[2]}-{split_tokens[0]}-{split_tokens[1]}'
            elif len(split_tokens[2]) == 2: ## 1/23/20 case
                row[2] = f'20{split_tokens[2]}-{split_tokens[0]}-{split_tokens[1]}'
            else:
                print('ERROR!')
                exit(1)
        else:   ## 2020-02-01 case
            row[2] = split_tokens[0]

        writer.writerow(row)