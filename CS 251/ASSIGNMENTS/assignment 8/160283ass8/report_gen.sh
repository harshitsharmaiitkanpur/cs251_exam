rm output.txt
while read -a num_threads
do
  while read -a num_elements
  do
     for num_thread in ${num_threads[@]}
     do
	 for num_element in ${num_elements[@]}
	 do
	    for k in {1..100}
            do
		./App "$num_element" "$num_thread" >> output.txt
	    done
	 done
     done
  done < "$1"
done < "$2"

