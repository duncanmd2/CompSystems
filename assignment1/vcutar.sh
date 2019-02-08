#! /bin/bash

################################################################################
# name: Madison Duncan													   #
# class: CMSC 257 - section 1 												   #
# semester: spring 2019														   #
# assignment one - phase 2													   #
# this script creates, extracts, and displays a tarball for the user		   #
################################################################################


#-- archive() function ------------------------------------------------------#
# prompts user for verbose options, compression options, directory containing
# files to be archived, and files to be archived, name of tarball and creates 
# a tar ball with given specifications 
#----------------------------------------------------------------------------#
archive(){

	# saves current directory address as a variable
	current_dir="$PWD"

	#------------------------------------------------#
	# code help for above line from 				 #
	# https://stackoverflow.com/questions/1636363/	 #
	# getting-current-path-in-variable-and-using-it  #
	#------------------------------------------------#

	# prints out the options for user to chose from 
	echo "select your options:"
	echo "	v - show the process of archiving"
	echo "	j - use bzip2"
	echo " 	z - use gzip"

	# reads in user input and stores in variable 
	read archive_options

	# checks to see if user enterd the quit command 
	quit $archive_options

	# quits if user entered both compression options 
	if [[ $archive_options == *"z"* && $archive_options == *"j"* ]]
	then 
		echo cannot have both gzip and bzip2 extension. please try again. 
		exit
	fi

	# checks which compression extension to use 
	if [[ $archive_options == *"z"* ]]
	then
		extension=".gz"
	elif [[ $archive_options == *"j"* ]]
	then
		extension=".bz2"
	else
		entension=""
	fi

	# prompts user to enter name of directory containing files
	echo "input the directory containing the source files. (* if current)"
	
	# reads in the name of the directory
	read dir_from
	
	# checks to see if user enterd the quit command 
	quit $dir_from

	if [[ $dir_extract_to == "*" ]]
	then
		dir_command="."
	else
		dir_command="$dir_from"
	fi

	file_to_add=""		# variable to hold name of read in file
	file_list=""		# string of file names to be included in archive


	# allows for the entry of file/directory names 
	while [[ "$file_to_add" != ":q" ]] && [[ "$file_to_add" != ":a" ]]
	do
		echo input the files/directories to archive
		echo "	:q to quit"
		echo "	:a to continue to archive"
		
		# read in user input 
		read file_to_add

		# checks to see if user enterd the quit command 
		quit $file_to_add

		# adds file to list if not archive or quit command 
		if [[ $file_to_add != ":a" ]]
		then
			file_list="$file_list $file_to_add"
		fi
	done




	# prompts user for the name of archive
	echo input the name of the archive

	# reads in the name of the archive 
	read archive_name

	# checks to see if user enterd the quit command 
	quit $archive_name




	# checks if tarball must be made verbosely and creates tarball 
	if [[ $archive_options == *"v"* ]]
	then
		cd $dir_command
		tar -cvf $archive_name.tar$extension $file_list
		mv $archive_name.tar$extension $current_dir
	else
		cd $dir_command
		tar -cf $archive_name.tar$extension $file_list
		mv $archive_name.tar$extension $current_dir
	fi

} # archive() 

#-- extract() function ------------------------------------------------------#
# prompts the user for the name of the tarball file to extract from and the
# directory for which the files should be extracted to and extracts the files
# to the given location
#----------------------------------------------------------------------------#
extract(){
	echo input the name of archive to be extracted
	read file_extracted
	quit $file_extracted
	echo the file to be extracted is $file_extracted
	echo 'input the name of the directory to be extracted to (* if current)'
	read dir_extract_to
	quit $dir_extract_to  
	echo "the directory to be extracted to is $dir_extract_to"
	if [[ $dir_extract_to == "*" ]]
	then
		tar -xvf $file_extracted -C .
	else
		tar -xvf $file_extracted -C $dir_extract_to
	fi
} # extract()

#-- view() function ---------------------------------------------------------#
# prompts the user for the name of the tarball file they wish to view the 	 #
# contents of, and then outputs the files in the tarball					 #
#----------------------------------------------------------------------------#
view(){

	# ask for tarball file name
	echo input the name of the archive to be viewed

	# reads tarball name 
	read file_viewed

	# checks to see if user enterd the quit command
	quit $file_viewed

	# outputs the contents of the tarball
	tar -tf $file_viewed
} # view()

#-- quit() function ---------------------------------------------------------#
# input: a string
# if the string is ":q" then the program exits the script
#----------------------------------------------------------------------------#
quit(){
	if [ $1 = ":q" ]
	then
		exit
	fi
} # quit()


# checks if call type was given by user 
if [ -z $1 ]
then
	echo A call type was not specified. Please try again.
	exit
else
	call_type=$1 
fi


if [ $call_type = 'archive' ]				
then
	echo the call type is $call_type
	archive
elif [ $call_type = 'extract' ]
then
	echo the call type is $call_type
	extract
elif [ $call_type = 'view' ]
then
	echo the call type is $call_type
	view
else
	echo the call type is not recognized. Please try again.
fi
