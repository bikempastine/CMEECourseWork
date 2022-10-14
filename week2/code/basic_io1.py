###################
## FILE INPUT
###################

#open file to read
f = open('../sandbox/test.txt', 'r')

for line in f:
    print(line)

f.close()

###skip blank lines
f = open('../sandbox/test.txt', 'r')

for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()