#!/bin/bash

if [ ! -d ~/DBs ]; then

    echo "pls create db "
    zenity --warning \
        --text="Please Create DB"

else

    cd ~/DBs

    export arr_dataBases=($(ls))

    if [[ ${#arr_dataBases[@]} > 0 ]]; then

        echo "All available DataBases:"

        for i in $(ls -d *); do
            echo ${i}
        done

        # printf "\nEnter the dbname of dataBase ?\n"
        # read dbname;
        # arr_dataBases=($(ls))
        dbname=$(zenity --list \
            --title="Choose the DB to connect" \
            --column "Databases Available" "${arr_dataBases[@]}")

        echo $dbname
        export $dbname
        PS3="$dbname>>"

        if [ -d "$dbname" ]; then

            source $mydir/secondMenu.sh

        else

            echo "This dataBase doesn't exist"
            zenity --warning \
                --text="This dataBase doesn't exist"

            echo "Go back to menu"

            source $mydir/firstmenu.sh
        fi

    else

        echo "This DBM is empty create database first"
        zenity --warning \
            --text="This DBM is empty create database first"
        source $mydir/firstmenu.sh

    fi

fi
