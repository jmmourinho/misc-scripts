#!/bin/bash
# csv aux + stat

# get number of lines
NUMLINES= $(wc -l med.txt | cut -d" " -f 1)

LINEBEFORE= $($NUMLINES -1)

# substitute delimiter 
cat $1 | tr ";" "," | head -n 1
