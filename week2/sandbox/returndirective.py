#!/usr/bin/env python3
# Author: Bikem bp222@ic.ac.uk
# Script: Importance of the return directive
# Arguments: 0
# Date: Oct 2022

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to', some_list)

my_list = [1,2,3]

print("before, my_list", my_list)

modify_list_1(my_list)

print('after, my_list = ', my_list)

################################
def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)

print('after, my_list =', my_list)

##############################
def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4)
    print('changed to', some_list)

my_list = [1,2,3]

modify_list_3(my_list)

print('after, my_list =', my_list)