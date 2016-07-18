# script to inspect a .csv file
#
# run later with `ls *.csv | xjobs ./script.sh`

echo
echo ---------------------------------------
echo ---------------------------------------
echo

#get file name
FILE=$1 
FILENAME=$(ls $FILE | cut -d. -f 1)
FILEEXT=$( ls $FILE | cut -d. -f 2)

echo
echo File:
echo -----
echo $FILE

#get clean file 
# change delimiter, remove lines without delimiters, remove empty spaces
CLEANFILE="clean_"$FILENAME".txt"
cat $FILE | tr "," "." | tr ";" "," | grep "," | sed 's/  * //g' > $CLEANFILE		#change delimiters, 


# get dimensions
echo
echo Dimensions:
echo -----------

#with csvtool package
#DIMX=$(csvtool width $CLEANFILE)
#DIMY=$(csvtool height $CLEANFILE)
#otherwise
DIMX=$(head -n 1 $CLEANFILE | tr "," "\n" | wc -l)
DIMY=$(cat $CLEANFILE | wc -l)

#echo "Dims = " $DIMX "x "$DIMY
echo "Linhas = "  $DIMY
echo "Colunas = " $DIMX


#get head and tail
#SAMPLEFILE="sample_""$FILENAME"".txt"
echo
echo "head(4) + tail(3):" #+ mid(3) 
echo --------------------
cat -n $CLEANFILE | head -n 4  #> $SAMPLEFILE
# MID | head - n 100 | tail -n 3
cat -n $CLEANFILE | tail -n 3  #>> $SAMPLEFILE


#get header
HEADERFILE="header_""$FILENAME"".txt"
echo
echo header:
echo -------
head -n 1 $CLEANFILE #> $HEADERFILE


#long header
echo
echo Header fields:
echo --------------
head -n 1 $CLEANFILE | tr "," "\n" | cat -n > $HEADERFILE
cat $HEADERFILE


# statistics
echo
echo Field statistics:
echo -----------------
STATFILE="stat_"$FILENAME".txt"
csvstat $CLEANFILE > $STATFILE
cat $STATFILE


echo ---------------------------------------
echo ---------------------------------------
