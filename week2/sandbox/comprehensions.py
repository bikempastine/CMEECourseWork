#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: learning about comprehensions in python
# Arguments: 0
# Date: Oct 2022

x = [i for i in range(10)]
print(x)

#same as
x= []
for i in range(10):
    x.append(i)
print(x)

x = [i.lower() for i in ["LIST", "COMPREHENSIONS", "ARE", "COOL"]]
print(x)
#same as
x = ["LIST", "COMPREHENSIONS", "ARE", "COOL"]
for i in range(len(x)):
    x[i] = x[i].lower()
print(x)

matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = [n for row in matrix for n in row]
print(flattened_matrix)
#same as
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = []
for row in matrix:
    for n in row:
        flattened_matrix.append(n)
print(flattened_matrix)

words = (["These", "are", "some", "words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])
print(first_letters)
#same as
words = (["These", "are", "some", "words"])
first_letters = {w[0] for w in words}
print(first_letters)