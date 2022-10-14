#!/usr/bin/env pyhton3
#Filename: using_name.py

if __name__ == '__main__' :
    print('this program is being run by itself')
else:
    print('I am being imported from another module')

print("This module's name is: " + __name__)
