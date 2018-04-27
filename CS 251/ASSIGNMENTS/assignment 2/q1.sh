#!/bin/bash

recurse () {

for variable in $1/*
do
    
      if [ ! -d "${variable}" ]
      then
	      name=$(basename $variable)
              temp=0
              echo $name > $temp
              
	      a=$(grep -oE '\.c' $temp | wc -l)
              #echo $a
	      if [ $a == 1 ]
	      then
               #echo 2
	      awk_output=$(awk -f q1.awk $variable)
               #echo 2
             # echo $awk_output
	       comments=$( echo "$awk_output" | awk '{print $1}' )
	       strings=$( echo "$awk_output" |  awk '{print $2}' )
               
	      total_comments=$(( total_comments + comments ))
	       total_strings=$(( total_strings + strings ))
              
               #echo $awk_output
               #echo 2
      fi
      else
         #echo 2
         recurse $variable 
         #echo 2
      fi
done
   
}
total_comments=0
total_strings=0

if [ "$(ls -A $1)" ]
then
   recurse $1
   #echo 2
else
   echo "empty directory"
fi
   echo "$total_comments lines of comments"    
   echo "$total_strings quoted strings"
#recurse $1

