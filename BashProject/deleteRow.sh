#!/bin/bash

deleteRow() 
{
    echo "Please Select a table"
    clear
    cd ~/DBs/$dbname
    ls
    arrayTables=($(ls))
    tname=$(zenity --list --title="Choose the Table to DElete from" --column "Tables Available" "${arrayTables[@]}")

    # read tname

    if [[ -f ~/DBs/$dbname/$tname ]]; then
        #  cat ~/DBs/iti/$tname
        zenity --text-info \
            --title "Hostname Information" \
            --filename "$tname" \
            --font "16"

        PK=$(zenity --entry \
            --width 500 \
            --title "Enter Primary key to delete its row" \
            --text "Enter the pk of the row" \
            --entry-text primary-key)
        echo "PLease enter PK to delete"
        # read PK
        noLine=$(awk -v n=$PK 'BEGIN { FS="|"; }{ if ($1 == n){print NR;} }' ~/DBs/$dbname/$tname)
        echo $noLine
        if [ -n "$noLine" ]; then
            sed -i "$noLine d" ~/DBs/$dbname/$tname
            zenity --info \
                --text="Deleted Successfully."

            echo "After deleting..."
            echo "-------------------------"
            cat ~/DBs/$dbname/$tname
            zenity --text-info \
                --title "Hostname Information" \
                --filename "$tname" \
                --font "16"
            #return to menu
        else
            echo "Wrong PK"
            zenity --error \
                --text="Wrong PK"
            deleteRow
        fi
    else
        echo "inValid table"
        zenity --error \
            --text="Invalid table"
        . $mydir/secondMenu.sh
        # return to menu
    fi
}

deleteRow
