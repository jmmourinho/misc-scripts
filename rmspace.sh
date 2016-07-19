#!/bin/bash
#
# remove espacos do nome do ficheiro ficheiro
#
# FEITO:
#   - remove spaces with 'sed' command 
#
# A FAZER:
#   - camelCase
#
# at the current stage is better to user perl rename command
# $ rename -n "s/ //g" *    (-n) is a list only failsafe
#
# [^]: Fonte: http://unix.stackexchange.com/questions/196239/convert-underscore-to-pascalcase-ie-uppercamelcase
#

# get file name
OLDFILE=$1 

# remove spaces
#NEWFILE=$(echo "$OLDFILE" | sed 's/ //g') #try with ls instead of echo
NEWFILE=$(echo "$OLDFILE" | sed -re "s~(_| ){1,}(.)~\U\2~g" -e "s/^[A-Z][a-z]/\L&/g" -e "s/-[a-z]/\U&/g") 

# replace old file name into new filename 
mv "$OLDFILE" "$NEWFILE" 

