#! /bin/bash

ask_print_name()
{
	echo enter your name:
	read name
	echo your name is $name
}

if [ -v $1 ] 
then 
	echo enter a number
	read num
else 
	num=$1
fi 

while [ $num -gt 0 ] 
do
	ask_print_name
	num=$((num-1))
done

