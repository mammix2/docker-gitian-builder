#!/bin/bash

##########################################################################
# A simple script for launching Docker Gitian Builder with options
# maintainer: mammix2#protonmail.com
##########################################################################

function fHeader() {
	echo -e "\e[92m"
	echo -e "####################################################################"
	echo -e "# A simple script for launching Docker Gitian Builder with options #"
	echo -e "# maintainer: mammix2#protonmail.com                               #"
	echo -e "####################################################################"
	echo -e " \e[0m"
}
function fStartInfo() {
	echo -e " "
	echo -e ">> Starting project: $1"
	echo -e ">> Building for platform: $2"
	echo -e " "
}
function fName_Error() {
	echo -e "Missing \e[1m<projectname>\e[0m parameter. make sure project Dockerfile exists in path 'project/<projectname>/Dockerfile_<target platform>'"
	echo -e "Options: ./build_builder.sh \e[1m<projectname>\e[0m <target platform>"
	echo -e "Usage: ./build_builder.sh \e[1mboostcoin\e[0m win"
}
function fPlat_Error() {
	echo -e "Missing \e[1m<target platform>\e[0m parameter."
	echo -e "Options: ./build_builder.sh <projectname> \e[1m<target platform>\e[0m [osx, win, linux]"
	echo -e "Example: ./build_builder.sh boostcoin \e[1mwin\e[0m"
}
function fPlat_Incorrect() {
	echo -e "Incorrect \e[1m<target platform>\e[0m parameter. make sure to specify [osx, win or linux] target platform"
	echo -e "Format: ./build_builder.sh <projectname> \e[1m<target platform>\e[0m [osx, win, linux]"
	echo -e "Example: ./build_builder.sh boostcoin \e[1mwin\e[0m"
}
function fError() {
	echo -e "\e[41m### Error ###\e[0m"
}
function fRun_Builder() {
	fHeader
	fStartInfo  $1 $2
	docker build -t builder -f project/$1/Dockerfile_$2 .	
}

if [ -z "$1" ]
then
	fError
	fName_Error
elif [ -z "$2" ]
then
	fError
	fPlat_Error
elif [[ $2 != "win" && $2 != "osx" && $2 != "linux" ]]
then
	fError
	fPlat_Incorrect
else
	fRun_Builder $1 $2
fi






