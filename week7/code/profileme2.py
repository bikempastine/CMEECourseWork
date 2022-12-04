"""Profiling my_squares and my_join, two different types of functions using less timeconsuming methods than profileme.py"""

def my_squares(iters):
    """Find the squares of an ouput by list comprehension"""
    out = [i ** 2 for i in range(iters)]
    return out


# use numpy array method
# import numpy as np
# def my_squares(iters):
#     """Find the squares of an ouput by numpy"""
#     out = np.arange(iters)
#     out = np.square(out)
#     return out

def my_join(iters, string):
    """Join the string of an input the number of times specified without string_join"""
    out = ''
    for i in range(iters):
        out += ", " + string
    return out

def run_my_funcs(x,y):
    """Run functions my_join and my_squares"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")




