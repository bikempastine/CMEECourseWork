birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

latin_names_comp = [i[0] for i in birds]
print(latin_names_comp)

common_names_comp = [i[1] for i in birds]
print(common_names_comp)

mean_body_comp = [i[2] for i in birds]
print(mean_body_comp)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

latin_names_loop = []
for i in birds: 
    # add the first element of each bird type list to latin_names_loop 
    latin_names_loop.append(i[0])

print(latin_names_loop)


common_names_loop = []
for i in birds: 
    common_names_loop.append(i[1])

print(common_names_loop)


mean_body_loop = []
for i in birds: 
    mean_body_loop.append(i[2])

print(mean_body_loop)


 