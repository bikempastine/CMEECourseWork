"""Vectorization versus Loops computation time"""

import numpy as np

def loop_product(a,b):
    """entrywise multiplication using a loop"""
    N = len(a)
    c = np.zeros(N)
    for i in range(N):
        c[i] = a[i] * b[i]
    return c

def vect_product (a,b):
    """entrywise multiplication using a vectorised function"""
    return np.multiply(a,b)

## run these functions
import timeit

array_lengths = [1, 100, 10000, 1000000, 10000000]
t_loop = []
t_vect = []

for N in array_lengths:
    """randomly generate our 1D arrays of length N"""
    print(f"\nSet {N=}")
    a = np.random.rand(N)
    b = np.random.rand(N)

    """Time loop_product 3 times and save the mean execution time"""
    timer = timeit.repeat('loop_product(a,b)', globals=globals().copy(), number=3)
    t_loop.append(100 * np.mean(timer))
    print(f"Loop method took {t_loop[-1]} ms on average")

    """Time vect_product 3 times and save the mean execution time"""
    timer = timeit.repeat('vect_product(a,b)', globals=globals().copy(), number=3)
    t_vect.append(100 * np.mean(timer))
    print(f"Vectorized method took {t_vect[-1]} ms on average")


##plot the results
import matplotlib.pylab as p

p.figure()
p.plot(array_lengths, t_loop, label="loop method")
p.plot(array_lengths, t_vect, label="vect method")
p.xlabel("Array length")
p.ylabel("Execution time (ms)")
p.legend()
p.show()


##When to vectorize
N = 1000000000

a = np.random.rand(N)
b = np.random.rand(N)
c = vect_product(a, b)

# if no error, remove a, b, c from memory.
del a
del b
del c