#!/usr/bin/env python3
#Debugging
"""Demonstrates how to find bugs and improve error messages"""

def buggyfunc(x):
    """Return different error messages based on the error encountered"""
    y = x 
    for i in range(x):
        try:
            y = y-1
            z = x/y
        except ZeroDivisionError:
            print(f"The results of dividing a number by zero is undefined")
        except:
            print(f"This didn't work; {x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }; {z = };")
    return(z)

buggyfunc(20)
