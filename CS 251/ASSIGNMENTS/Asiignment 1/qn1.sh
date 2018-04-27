#!/bin/bash

old=$1

new=$(echo $old | sed 's/^0*//')

naming () {
	arr[0]=''
	arr[1]='one'
	arr[2]='two'
	arr[3]='three'
	arr[4]='four'
	arr[5]='five'
	arr[6]='six'
	arr[7]='seven'
	arr[8]='eight'
	arr[9]='nine'
	arr[10]='ten'
	arr[11]='eleven'
	arr[12]='twelve'
	arr[13]='thirteen'
	arr[14]='forteen'
	arr[15]='fifteen'
        arr[16]='sixteen'
	arr[17]='seventeen'
	arr[18]='eighteen'
	arr[19]='nineteen'
	arr_n[0]='twenty'
        arr_n[1]='thirty'
	arr_n[2]='forty'
	arr_n[3]='fifty'
	arr_n[4]='sixty'
	arr_n[5]='seventy'
	arr_n[6]='eighty'
	arr_n[7]='ninety'

if [ $1 -le 19 ]
then
	echo -n ${arr[$1]}
	echo -n ' '
else
	echo -n  ${arr_n[$(($1/10-2))]}
	echo -n ' '
	echo -n ${arr[$(($1%10))]}
	echo -n ' '
fi	
}


digit_3 () {
 local  temp=$1	
  new=$(($1/100))	
  naming $new
  echo -n hundred
  echo -n ' '
  naming $(($temp%100))
}


digit_4and5 () {
 local temp=$1	
   new=$(($1/1000))
   naming $new
   echo -n thousand
   echo -n ' '
   digit_3 $(($temp%1000))
}


digit_6and7 () {
  local temp=$1
    new=$(($1/100000))
    naming $new
    echo -n lakh
    echo -n ' '
    digit_4and5 $((temp%100000))
}


digit_8and9and10and11 () {
   local temp=$1
   new=$(($1/10000000))
   p=${#new}
   if [ $p == 1 ] || [ $p == 2 ]
   then
	naming $new   
   elif [ $p == 3 ]
   then	   
	digit_3 $new
   elif [ $p == 4 ]
   then
	digit_4and5 $new
   fi  	
   echo -n crore
   echo -n ' '
   digit_6and7 $((temp%10000000))
}   


  n=${#new}


if [ $n -le 2 ]
then
  naming $new
fi

if [ $n == 3 ]
then 
  digit_3 $new
fi



if [ $n == 4 ] || [ $n == 5 ]
then
   digit_4and5 $new
fi

if [ $n == 6 ] || [ $n == 7 ]
then
     digit_6and7 $new
fi    

if [ $n == 8 ] || [ $n == 9 ] || [ $n == 10 ] || [ $n == 11 ]
then
    digit_8and9and10and11 $new
fi

if [ $n -ge 12 ]
then
    echo 'invalid input'	
fi

echo \
	

      	






































