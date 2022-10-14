#!/usr/bin/env python3

## docstrings ##
"""This program demonstrats the basics of writing programs in phython."""

__appname__ = '[boilerplate.py]'
__author__ = 'Bikem Pastine (bp222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "No license needed"

## imports ##
import sys 

#module is made to interface with the operating system

## constants ##

## functions ##
def main(argv):
    """Main entry point of the program """
    print('This is a boilerplate')
    return 0

if __name__ == "__main__":
    """Makes sure the 'main' function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)


