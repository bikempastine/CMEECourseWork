"""Profiling my_squares and my_join, two different types of"""

def my_squares(iters):
    """Find the squares of an ouput iteratively"""
    out = []
    for i in range(iters):
        out.append(i ** 2)
    return out

def my_join(iters, string):
    """Join the string of an input the number of times specified"""
    out = ''
    for i in range(iters):
        out += string.join(", ")
    return out

def run_my_funcs(x,y):
    """Run functions my_join and my_squares"""
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")