#############################
# FILE OUTPUT
#############################

list_to_save = range(100)

f = open('../sandbox/testout.txt','w')
for i in list_to_save:
    f.write(str(i) + '\n')

f.close()