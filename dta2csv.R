#! /usr/bin/Rscript
#dtatocsv.R
# 
# usage:
# ./dtatocsv input.sta output.csv 

print("loading libraries...")
library("foreign")

# read STATA .dta table
print(paste("reading file:", args[1],"...")
STATA <- read.dta(args[1])

head(STATA)

# Write table to .CSV
print("writing to .csv...")
write.csv(STATA,file=args[2],row.names=FALSE, na="", quote = FALSE)
print("DONE.")
