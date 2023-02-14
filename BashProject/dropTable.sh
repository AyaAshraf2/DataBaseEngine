#!/bin/bash

dropTable()
{   
    cd ~/DBs/$dbname
	echo "Enter Table Name to Delete"
	# read tname
    arrayTables=($(ls))
tname=$(zenity --list --title="Choose the Table to Insert into" --column "Tables Available" "${arrayTables[@]}")

	if [ -n "$tname" ]
      	then
		if [[ -f "$tname" ]]
    		then
			rm -r $tname
			rm -r "."$tname"_metadata"
        		echo "Table Deleted Successfully" 
                zenity --info \
                --text="Deleted Successfully."
        		. $mydir/firstmenu.sh
    		else

        		echo "There is no table with name $tname"
                 zenity --error \
                        --text="There is no table with name $tname"

        		. $mydir/firstmenu.sh
    		fi
	else
		echo "not valid name"
         zenity --error \
                        --text="not valid name"
    
	fi
}
dropTable