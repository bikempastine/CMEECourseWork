# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

high_rainfall_comp = [i for i in rainfall if i[1] > 100]
print(high_rainfall_comp)

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

low_rainfall_comp = [i for i in rainfall if i[1] < 50]
print(low_rainfall_comp)

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

#Loop for list of months with rainfall greater than 100mm
high_rainfall_loop = []
for i in rainfall:
    if i[1] > 100 :
        high_rainfall_loop.append(i)

print(high_rainfall_loop)

#Loop for list of months with rainfall less than 50mm
low_rainfall_loop = []
for i in rainfall:
    if i[1] < 50 :
        low_rainfall_loop.append(i)

print(low_rainfall_loop)


