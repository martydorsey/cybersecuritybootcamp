#!/bin/bash


filename=$1
Time=$3
typeOG=$4
 

awk -F"\t" '/(AM|PM)/{print $1" "$3}' $filename | grep $Time" "$typeOG
