#!/bin/bash
# Author: Bikem bp222@ic.ac.uk
# Script: Substitute the tabs in strings for commas
# Arguments: none?
# Date: Oct 2022

# Substitute the tabs for commas
echo 'Enter string with tabs to be converted to commas'
read a
echo $a | tr [:space:] ","
echo
