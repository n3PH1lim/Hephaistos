#!/bin/bash
#***********************************************************

#***********************************************************
#*
#* Filename: hephaistos.sh
#* Programtype: Shell-Script
#* Function: renames jpeg and raw picture files
#**********************************************************

###########################################################
### -- ENVIROMENT -- ###

CURRENT_COUNTER=48796

#*******************
DEBUG=1 # Debug Mode 1(ON) 0(OFF)
#*******************


TIME=$(date)

###########################################################
### -- FUNCTIONS -- ###

# function for debug printig
# If variable DEBUG is set to 1 the string will be printed with timestamp
function decho(){
if [ $DEBUG -eq 1 ]
then :
	echo -e "$(date '+%F %T'): $1"
fi
}

#######################

# prints status when script starts
function start_processing(){
	# clear screen
	clear

	decho " ------------"
	decho "| Hephaistos |"
	decho " ------------"

	decho "############################################"
	decho "# raw and jpeg file rename utility"
	decho "# starting at ${TIME}"
	decho "############################################"
	decho ""

}


#######################


function get_files(){

# loop all directorys
for DIRECTORY in $@;
do
	# check if directory is a directory and exists
	if [ -d ${DIRECTORY} ]
	then :

		declare -a FILE_ARRAY
		FILE_ARRAY=($(find ${DIRECTORY} -maxdepth 1 -mmin +1 -type f -print | grep -v temp | awk -F"/" '{print $NF}')) || exit 1

		decho "\n$(date '+%F %T'): The following files are found in ${DIRECTORY}"
		decho "->"
		for DATA_FILE in ${FILE_ARRAY[@]}
		do
			decho "${DATA_FILE}"
		done
		decho "->"

	else
		# directory check fail
		decho "${DIRECTORY} is not a directory check parameter"
	fi
done

return

}
#######################

####################################################
############# MAIN #################################

start_processing


get_files $@
