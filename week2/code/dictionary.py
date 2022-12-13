"""Populates a dictionary using a loop and list comprehensions"""

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
#

#### Loop #### 

taxa_set = set() #make an empty set
for i in taxa: #for each tuple in taxa
        taxa_set.add(i[1]) #add the second member of the tuple to the set

taxa_dic = {} #make an empty dictionary

for x in taxa_set: #for each member of the taxa_set
    taxa_dic[x] = set() #populate the dictionary with keys of each member of taxa_set corresponding to an empty set 
    for i in taxa: #for each member of taxa
        if i[1] == x: #if the second element of each tuple in taxa is the same as the current member of taxa_set in the loop
            taxa_dic[x].add(i[0]) # add the species as the variable 

print(taxa_dic)

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### List Comprehension #### 

taxa_dic_comp = {x[1]:set([y[0] for y in taxa if x[1] == y[1]]) for x in taxa} 
print(taxa_dic_comp)


