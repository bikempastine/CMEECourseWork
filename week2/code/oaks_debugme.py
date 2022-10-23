#!/usr/bin/env python3

"""This script checks for oaks in a csv file 'TestOaksData.csv'."""

__appname__ = 'oaks_debugme.py'
__author__ = 'Bikem Pastine (bp222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "No license needed"


#imports
import csv
import sys
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 

    >>> is_an_oak('Fagus sylvatica')
    False

    >>> is_an_oak('Quercus petraea')
    True

    >>> is_an_oak('QUERCUS PETRAEA')
    True

    >>> is_an_oak('QuercusPetraea')
    False

    >>> is_an_oak('Quercuss Petraea')
    False

    >>> is_an_oak('qiercus petraea')
    False

    >>> is_an_oak('Quercus-abcd')
    False

    """
    
    return name.lower().startswith('quercus ') #include the space between genus and species to only accept quercus

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0] + ' '): #modify the input for the function to include a space sudo-sepperating the genus and species names
            #breakpoint()
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()