#!/bin/bash
#
# script para dissecar um .pdf de slides de aulas para
#facilitar resumos posteriores em markdown
#
# 
# [TODO]
#  * make it handle files with spaces. Until then use 'rename -n "s/ //g" *.ext"
#

# get file name
echo "1. getting file name ..."
FILE=$1 
FILENAME=$(ls $FILE | cut -d. -f 1)
FILEEXT=$( ls $FILE | cut -d. -f 2)

# make a directory for the pdf files
echo "2. creating ($FILENAME) directory for the pdf files ..."
mkdir $FILENAME
cd $FILENAME

# copy the original file into the new folder
echo "3. Backing up $FILE ..."
cp ../$FILE $FILE


# creates pdf statistics file and get number of pages
echo "4. Creating pdf statistics file ..."
pdftk $FILE dump_data > stats.txt

# get number of pages/slides in pdf
echo "5. Getting number of pages/slides in pdf ..."
NUMPAGES=$(cat stats.txt | grep "NumberOfPages" | cut -d" " -f 2)
echo "R= "$NUMPAGES

# extract images
echo "6. Extract images ..."
mkdir images
cd images
pdfimages -all ../$FILE pic
cd ..

# creates a text file
echo "7. Creating a text file..."
pdftotext $FILE text.txt
cp text.txt t1.txt

# procura linhas repetidas mais de 10x (slides header / footer
echo "8. Searching lines repeated more than 10x (slides header / footer) ..."
LINREP=$(cat text.txt | sort | uniq -c | grep -E ' {2,}[0-9]{2,3} .' | cut  -c 9-)

echo R: found "$LINREP"

# apaga as linhas
echo "9. Deleting overly repeated lines ..."
#echo $LINREP | while read LINE
#                do 
#                    echo "removing $SLINE..."
#                    grep -v "$LINE" text.txt > aux1.txt
#                    cp aux1.txt text.txt
#                done

for LINE in "$LINREP"
  do 
    echo "removing $LINE..."
    grep -v "$LINE" text.txt > aux1.txt
    cp aux1.txt text.txt
  done
cp text.txt t2.txt




# adiciona separadores de pagina
echo "10. adicionando separadores de pagina..."
cat text.txt | sed -r 's/^[0-9]{1,5}$/\n> fim do slide &\n\n\n\n***\n/g' > aux2.txt
cp aux2.txt t3.txt
cp aux2.txt text.txt

# limpa ficheiros
echo "11. Cleaning files"
cp text.txt $FILENAME.md
cp text.txt $FILENAME.txt
mv stats.txt stat_$FILENAME.txt

rm text.txt
rm aux1.txt
rm aux2.txt

# go back to the original folder
echo "12. Going back to the original folder ..."
cd ..

echo "DONE"

