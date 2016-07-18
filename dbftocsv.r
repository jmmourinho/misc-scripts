#! /usr/bin/Rscript

args <- commandArgs(TRUE)

library(foreign)

inputTable <- read.dbf(args[1], as.is = FALSE)

write.table(inputTable,file=args[2], sep=";", row.names=FALSE, na="", quote = FALSE, dec = ",")