"""Profiles LV1 and LV2"""

#comparing the t
from  cProfile import Profile #profiling
import pstats #unpacking
from io import StringIO #a C thing
import LV1
import LV2

pr = Profile() #load in this profile class thing

##LV1
pr.enable() #turn on profiling
LV1.main([], plot=True) #turn off plotting and do the LV1
pr.disable() #turn it off

s = StringIO() #this C thing from before
ps = pstats.Stats(pr, stream=s) #put the results into the s string
ps.print_stats(0).sort_stats('calls') #???

print("LV1:")
print(f"{s.getvalue()}\n") #print the value from before 

##LV2
pr.enable() #turn on profiling
LV2.main([], plot = True) #turn off plotting and do the LV1
pr.disable() #turn it off

s2 = StringIO() #this C thing from before
ps2 = pstats.Stats(pr, stream=s2) #put the results into the s string
ps2.print_stats(0).sort_stats('calls') #???

print("LV2:")
print(f"{s2.getvalue()}\n") #print the value from before 