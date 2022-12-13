#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: cfexcercises2.py
# Arguments: 0
# Date: Oct 2022

"""Prints 'hello' a number of times to ilustrate elseif statements"""
##########################
def hello_1(x):
    """Prints hello for each value in x that is devisable by 3"""
    for j in range(x):
        if j % 3 ==0:
            print('hello')
    print(' ')

hello_1(12)

#########################
def hello_2(x):
    """Prints hello for each value in x that is devisable by 4 and 5 leaving a remainder of 3"""
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print('')

hello_2(12)

##########################
def hello_3(x, y):
    """Print hello as many times as the difference between x and y"""
    for i in range(x,y):
        print('hello')
    print('')

hello_3(3,17)

#########################
def hello_5(x):
    """Print hello 7 times when x is 31 and once when its 18"""
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

#WHILE loop with BREAK
def hello_6(x,y):
    """Print hello with string inputed, inside while loop"""
    while x: #while x is true
        print('hello' + str(y))
        y += 1
        if y == 6:
            break
    print(' ')

hello_6(True, 0)