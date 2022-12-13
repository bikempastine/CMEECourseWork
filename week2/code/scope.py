#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: variable scope
# Arguments: 0
# Date: Oct 2022

"""Understanding variable scope in functions"""

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
    """Add 1 to x for each itteration over y"""
    x = 0
    for i in range(y):
        x += 1
    return x
a_function(10)
print(i)
print(x)

print (a_function(10))

###########################
##### Global Variables ####
###########################

_a_global = 10
if _a_global >= 5:
    _b_global = _a_global + 5

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():
    """Add 5 to _a_global when it is larger than 4 to demonstrate global vs local variables"""
    _a_global = 4

    if _a_global >= 4:
        _b_global = _a_global + 5

    _a_local = 3

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

a_function()

print("After calling the function, outside the function, the value of _a_ global is", _a_global)
print("After calling the function, outside the function, the value of _b_ global is", _b_global)
##error because _a_local does not exist ouside the function
# print("After calling the function, outside the function, the value of _a_ local is", _a_local)

###################################
_a_global = 10

def a_function():
    """Demonstrates global versus local variables"""
    _a_local = 4
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global) 

a_function()

print("Outside the function, the value of _a_global is", _a_global)

###################################
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
    """Changing local and global varibales within functions"""
    global _a_global
    _a_global = 5
    _a_local = 4

    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)

a_function()

print("After calling a_function, outside the function, the value of _a_global is", _a_global)
    
def a_function():
    """function where the variable is defined inside and within another internal function"""
    _a_global = 10

    def _a_function2():
        """changes the variable _a_global"""
        global _a_global
        _a_global =2
    
    print("Before calling a_function2, value of _a_global is", _a_global)
    
    _a_function2()

    print("After calling a_function2, value of _a_global is", _a_global)
     
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)

#############################

_a_global = 10

def a_function():
    """function calling another function"""

    def _a_function2():
        """function changing the value of _a_global"""
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()

    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)
