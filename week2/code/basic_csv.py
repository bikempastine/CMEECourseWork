"""Writes a file with the species and body mass data from the file testcsv.csv"""

import csv

with open('../data/testcsv.csv', 'r') as f:
#read file
    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("The species is", row[0])


#write file: species name and body mass columns
with open('../data/testcsv.csv','r') as f:
    with open('../data/bodymass.csv', 'w') as g:
        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])

