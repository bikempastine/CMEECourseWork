#!/usr/bin/env python3

## docstrings ##
"""This program combines functions and the 'if' conditional in python to demonstrate their usage."""

__appname__ = 'cfexcersises1.py'
__author__ = 'Bikem Pastine (bp222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "No license needed"

## imports ##
import sys
#module is made to interface with the operating system

def foo_1(x):
    """Returns the square root of x"""
    return x ** 0.5

def foo_2(x,y):
    """Returns the larger number between two imput values"""
    if x>y:
        return x
    return y

def foo_3(x,y,z):
    """Returns the three inputs with the largest value on the right, and the two smaller numbers to the left in any order """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return[x, y, z]

def foo_4(x):
    """Returns the factorial of x, caluculated using a 'for' loop"""
    result = 1
    for i in range(1, x+1):
        result = result * i
    return result

def foo_5(x):
    """Returns the factorial of x, calculated using a recursive function"""
    if x == 1:
        return 1
    return x * foo_5(x-1)

def foo_6(x):
    """Returns the factorial of x, calculated using a 'while' loop."""
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    """Main entry point of the program """
    print(foo_1(9))
    print(foo_2(10,6))
    print(foo_3(3,2,1))
    print(foo_4(6))
    print(foo_5(5))
    print(foo_6(4))
    return 0

if __name__ == "__main__":
    """Makes sure the 'main' function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)