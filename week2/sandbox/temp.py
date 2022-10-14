
from sqlite3 import complete_statement


%cpaste
x = 11

for i in range(x) :
    if i > 3:
        print(i)


for i in range(10):
    print(i)


a = range(10)

for i in range(1,6):
    print(i)

for i in range(2,10,2):
    print(i)

#Iterator vs Iterable

my_iterable = [1,2,3]
type(my_iterable)

my_iterator = iter(my_iterable)
type(my_iterator)
next(my_iterator)
next(my_iterable) #list object is not an iterator

