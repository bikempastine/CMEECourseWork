#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: oaks.py
# Arguments: 0
# Date: Oct 2022
"""Finds oaks from a list of species using list comprehensions and loops"""

taxa = ['Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',]

#finds just the oak trees from a list of species

def is_an_oak(name):
    """Find all names that starts with quercus"""
    return name.lower().startswith('quercus')

##Using for Loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

##Using list comprehensions
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##Get names in UPPER CASE using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)



