#!/bin/bash
#. ${BASH_SOURCE%/*}/createDB.sh

cd ~/DBs
echo " "
echo " choose any DataBase you want to drop it"
echo " "
ls ~/DBs/$dbname
# read -p "Database name: " dbName
arr_dataBases=($(ls))
 dbName=$(zenity --list \
       --title="Choose the DB to Drop" \
      --column "Databases Available" "${arr_dataBases[@]}" )


if [ -d $dbName ]
then
	rm -r $dbName
	echo "Database $dbName dropped successfully"
	            zenity --info \
                --text="Deleted Successfully."
	echo " "
	# read -p "press any key"
	. $mydir/firstmenu.sh
else
	echo "Database doesn't exists"
	echo " "
	zenity --error \
                --text="DB doesn't exist"
	. $mydir/firstmenu.sh
fi





















# if [[ $dbName =~ [a-zA-Z] ]]; then
# 	rm -r $dbName
# 	echo "Database $dbName created successfully"
# 	echo " "
# 	mainMenu
# fi

# function DropDatabase {
# 	echo " "
#         read -p "Enter database name want to drop: " dbName

# 	if validate $dbName;
# 	then
# 		if [ -d $dbName ]
# 	then
# 			rm -r $dbName
# 			echo "Database $dbName dropped successfully"
# 			echo " "
# 			mainMenu
# 		else
# 		        echo "Database doesn't exists";
# 		        echo " "
# 		        mainMenu
# 		fi
#         else
#                 echo "Syntax error, not valid input";
#                 echo " "
#                 mainMenu
#         fi
# }
# function validate() {
# 	if [ -z $1 ]; then
# 		return 1
# 	else
# return 0
# fi
# }
