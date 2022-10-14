#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: variablescope.py
# Arguments: 0
# Date: Oct 2022

i = 1
x = 0
for i in range(10):
    x += 1
print(i)
print(x)

#########################

i =1
x =0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x
a_function(10)
print(i)
print(x)

#########################
i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x

print (a_function(10))

