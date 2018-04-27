#!/bin/bash
num_element=0;
while read -a elements
do
 for element in ${elements[@]}
 do
     arr1[$num_element]=$element
     num_element=$((num_element+1))
#echo $num_element
#echo $element
 done
done < "$2"
#echo $elements

num_thread=0;
while read -a threads
do
 for thread in ${threads[@]}
 do
     #echo num_thread
     #echo $threads
     arr2[$num_thread]=$thread
     num_thread=$((num_thread+1))
 done
done < "$3"
#echo num_thread
#echo $threads

count=1;
num_elem=0;
num_thr=0;
rm analyse.txt
while read -r str;
do
    a=( $str )
    echo "${arr1[$num_elem]} ${a[3]}" >> analyse.txt

    if [[ $(( $count % 100 )) == 0 ]]
    then
	num_elem=$(($num_elem + 1))
	if [ $num_elem -eq $num_element ]
	then 
	    #echo $count
	    #echo $num_elem
	    num_elem=0;
	fi
    fi
#echo $count
#echo $num_elem
    
    if [[ $(( $count % $(($num_thread * 100)) )) == 0 ]]
    then
	#echo $num_thread
        #echo $num_thr
	num_thr=$(($num_thr + 1))
	if [ $num_thr -eq $num_thread ]
	then 
	    num_thread=0;
	fi
    fi
    count=$(($count + 1))
#echo $num_thread
#echo $num_thr

done < "$1"
