#!/usr/bin/env python3

"""This script tests two DNA sequences of different lengths for alignment. It returns the alignment with the highest similarity between the strings as a .txt file."""

__appname__ = 'align_seqs.py'
__author__ = 'Bikem Pastine (bp222@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "No license needed"


#importing
import csv
import sys


# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """This function computes a score by returning the number of matches from a startpoint chosen by the user. 
    The imputs are two strings (s1,s2), the lenghts of the strings (l1, l2), and the startpoint. """
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                #import ipdb; ipdb.set_trace()
                #print('i is', i)
                #print(matched)
                score = score + 1
                #print('score is:', score)
            else:
                matched = matched + "-"
                # print('i is', i)
                # print(matched)
                # print('score is:', score)

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")
    
    return score


def main(argv):
    """Takes the default imput .csv (align_seqs_DNA.csv) and outputs the alignement of the two strings with the highest number of matches as a .txt file."""
    # open the csv and extract the contents (DNA strings)
    with open('../data/align_seqs_DNA.csv', 'r') as f:
        csvread = csv.reader(f)
        for line in csvread:
            DNA = line
    
    # Two example sequences to match
    seq1 = str(DNA[0])
    seq2 = str(DNA[1])
    print("The two sequences to match are:", seq1, "and", seq2)

    # Get the length of the sequences
    l1 = len(seq1)
    l2 = len(seq2)

    # Assign the longer sequence s1, and the shorter to s2
    # l1 is length of the longest, l2 that of the shortest
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths

    # Find the best match (highest score) for the two sequences
    my_best_align = None
    my_best_score = -1

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)

    # Output the results as a text file in the results folder
    with open('../results/align_seqs_out.txt', 'w') as f:
        f.write(my_best_align + '\n' + s1 + '\n' + "Best score: " + str(my_best_score))
    
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)