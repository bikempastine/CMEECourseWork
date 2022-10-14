#!/bin/sh
# NAME: Bikem
# SCRIPT: variablestest.sh
# DESC: Learning about variables
# ARG: none
# DATE: Oct 2022

# Special variables
echo "This script was called with $# parameters"
echo "The script's name is $0"
echo "The arguments are $@"
echo "The first argument is $1"
echo "The second argument is $2"

# Assigned Variables
MY_VAR='some string'
echo 'the current value of the variable is' $MY_VAR
echo
echo 'Please enter a new string'
read MY_VAR
echo
echo 'the current value of the variable is' $MY_VAR
echo

# Assigned Variables (Reading multiple vales from user imput)
echo 'Enter two numbers seperated by spaces'
read a b
echo
echo 'you entered' $a 'and' $b 
echo 'Their sum is:'

# Command substitution
MY_SUM=$(expr $a + $b)
echo $MY_SUM
#end
