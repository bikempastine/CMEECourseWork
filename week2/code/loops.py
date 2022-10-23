#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: Some examples of loops in python
# Arguments: 0
# Date: Oct 2022

#For loops

for i in range(5):
    print(i)

my_list = [0,2,"geronimo!",3.0,True,False]
for k in my_list:
    print(k)


total = 0
summands = [0, 1, 11, 111, 1111]

for s in summands:
    total = total + s
    print(total)


# While loop
z = 0
while z < 100:
    z = z + 1
    print(z)


