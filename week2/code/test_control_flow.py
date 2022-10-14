#!/usr/bin/env python3

## docstrings ##
"""This program demonstrats the use of control statements."""

__appname__ = '[control_flow.py]'
__author__ = 'Bikem Pastine (bp222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "No license needed"

## imports ##
import doctest
import sys 
#module is made to interface with the operating system

## constants ##

## functions ##
def even_or_odd(x=0):
    """Find whether a number 'x' is even or odd
    >>> even_or_odd(10)
    '10 is even'
    
    >>> even_or_odd(5)
    '5 is odd'
    

    ###recieving an error due to modular behaviour
    # >>> even_or_odd(6.5)
    # '6.5 is even'
    
    >>> even_or_odd(-2)
    '-2 is even'
    """

    #define function to test
    if x % 2 ==0:
        return f"{x} is even"
    return f"{x} is odd"


# def main(argv):
#     """Main entry point of the program """
#     print(even_or_odd(22))
#     print(even_or_odd(33))
#     return 0

# if __name__ == "__main__":
#     """Makes sure the 'main' function is called from command line"""
#     status = main(sys.argv)

doctest.testmod()


