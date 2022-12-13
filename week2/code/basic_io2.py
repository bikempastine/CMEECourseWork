#############################
# FILE OUTPUT
#############################

"""Writes a .txt file with the numbers 0 to 99, each on a new line"""

list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n')

f.close()