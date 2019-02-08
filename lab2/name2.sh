#! /bin/bash 

if [ -z "$1" ] 
then 
	echo "enter your name"
	read name
else
	name=$1
fi
echo Your name is: $name
