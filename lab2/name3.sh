#! /bin/bash

if [ -v $1 ]
then
	echo enter a number:
	read num
else 
	num=$1
fi

while [ $num -gt 0 ] 
do 
	echo Enter your name:
	read name
	echo Your name is: $name
	num=$((num-1))
done 
