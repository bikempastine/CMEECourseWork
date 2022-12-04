#!/bin/sh
texcount Writeup_Pastine.tex | grep "Words in text" | awk '{print $4}' > wordcount.txt