#! /bin/bash

indent () {
   temp=$indent_var    	
  while [[ $temp -ge 1 ]]
  do
    echo -n "   "
  temp=$(($temp - 1))  
  done  
}


no_sentences () {

     a=$(grep -oE '\?+' $1 | wc -l) # question mark ends the line
     b=$(grep -oE '\!+' $1 | wc -l) # exclaimation mark ends the line
     c=$(grep -oE '\.[^0-9]' $1 | wc -l) 
     d=$(grep -oE '[^0-9]\.[0-9]' $1 | wc -l)
     e=$(grep -oE '\.$' $1 | wc -l)
     sentences=$(($a + $b + $c +$d +$e))
     echo -n "$sentences"
  }

no_integers () {

     f=$(grep -oE '[0-9]+' $1 | wc -l) # counting +ve & -ve together
     g=$(grep -oE '[0-9]+\.[0-9]+' $1 | wc -l) # removing the extra cases
   #  h=$(grep -oE '-[0-9]+' $1 | wc -w) 
   #  i=$(grep -oE '-[0-9]+\.[0-9]+' $1 | wc -l)
     integers=$(($f - 2*$g ))   
     echo  "$integers"

}

function1 () {
for var in $1/*
do
    if [ ! -d "${var}" ]  
    then  
          integers_file=$(no_integers $var)
          answer=$(($answer + $integers_file))
    elif [ -d "${var}" ]
    then
         answer=$(function1 $var)
    fi
done

echo  "$answer "

}

function2 () {
for var in $1/*
do
    if [ ! -d "${var}" ]  
    then
          sentence_file=$(no_sentences $var)
          answer=$(($answer + $sentence_file))
    elif [ -d "${var}" ]
    then
         answer=$(function2 $var)
    fi
done

echo -n "$answer"

}

integer_dir () {
answer=0
function1 $1

}

sentence_dir () {
answer=0
function2 $1

}

recurse () {

for variable in $1/*
do
      if [ ! -d "${variable}" ]
      then
	   #  indent_var=$(($indent_var + 1))
              indent $indent_var
  
	      echo -n "(F) $(basename $variable)-"
          no_sentences $variable
          echo -n "-"
          no_integers  $variable
          #echo $no_sentences
          #echo "-"
          #echo $no_integers
      else
        indent $indent_var
       # indent_var=$(($indent_var + 1))
       
	 echo -n "(D) $(basename $variable)-"
         sentence_dir $variable
         echo -n "-"
         integer_dir $variable
	 indent_var=$(($indent_var+1))
         recurse $variable
	# indent_var=$(($indent_var + 1))
      fi
done
    indent_var=$(($indent_var - 1))
   # indent $indent_var

}

  indent_var=1
  echo -n "(D) $(basename $1)-"
  sentence_dir $1
  echo -n "-"
  integer_dir $1
 # indent $indent_var
  recurse $1
















