#!/bin/bash


mydir=$( cd -- "$( dirname -- "$BASH_SOURCE" )" ; pwd;)
export $mydir
while [[ "$option" != "Exit" ]] 
do
clear
	# select option in "List databases" "Create Database" "Connect to Database" "Drop Database" "Exit"
	# do
	MainMenu=$(zenity --width=350 --height=300 --list --title "Database Manager" --text "Choose a database operation:" --radiolist --column "" --column "Operation" TRUE "Create Database" FALSE "Drop Database" FALSE "connect Databases" FALSE "List Databases" FALSE "exit");
	  if [ $? -ne 0 ]
	 then
		 break
	 fi
		case $MainMenu in	
		    
			"Create Database") . $mydir/createDB.sh
			;;
			"Drop Database" ) . $mydir/dropDB.sh 
			;;
			"connect Databases") . $mydir/connectDB.sh 
			;;
			"List Databases" )  . $mydir/listDB.sh
			;;
			"exit")  
			exit $?;;
			*) echo "Invalid option MainMenu";;
		esac
	# done
done