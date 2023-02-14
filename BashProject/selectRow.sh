#! /bin/bash

cd ~/DBs/$dbname
clear

echo "Please enter the table you want to show"
ls
arrayTables=($(ls))
table=$(zenity --list --title="Choose the Table to Select from" --column "Tables Available" "${arrayTables[@]}")

# read table

while true; do
    if [ -n "$table" ]; then
        if [ -f ~/DBs/$dbname/$table ]; then
            break
        else
            echo "There's no table with name $table enter valid name"
            zenity --error \
                --text="Wrong Table name"
            arrayTables=($(ls))
            table=$(zenity --list --title="Choose the Table to Select from" --column "Tables Available" "${arrayTables[@]}")

        fi

    else
        echo "enter valid name"
        zenity --error \
            --text="Enter a valid name"
        arrayTables=($(ls))
        table=$(zenity --list --title="Choose the Table to Select from" --column "Tables Available" "${arrayTables[@]}")

    fi
done

selectAll() {
    zenity --text-info \
        --title "Hostname Information" \
        --filename "$table" \
        --font "16"
    # 	while read line
    #     do
    #         echo "------------------------"
    #       # printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    #         echo $line
    #     done < ~/DBs/$dbname/$table
    #
}

selectRow() {
    echo "Enter The PK"
    # read id
    PK=$(zenity --entry \
        --width 500 \
        --title "Enter Primary key to select its row" \
        --text "Enter the pk of the row" \
        --entry-text primary-key)

    while true; do
        if [ -n $PK ]; then
            value=$(awk -F"|" -v key=$PK '{ if ($1 == key) print $0; }' ~/DBs/$dbname/$table)
            if [ -n $value ]; then
                echo $value

             zenity --info \
             --title "Selected Row:"\
             --width 300 \
             --text="$value" 
              

                break
            else
                echo "PK isn't found please try again"
                zenity --error \
                    --text="PK doesn't exist"
                selectRow
                break
            fi
        else
            echo "enter valid PK"
            zenity --error \
                --text="Enter a valid PK"
            # read PK
            PK=$(zenity --entry \
                --width 500 \
                --title "Enter Primary key to select its row" \
                --text "Enter the pk of the row" \
                --entry-text primary-key)
        fi
    done

}
# source ~/BashProject/secondMenu.sh

# selectAll

selection=$(zenity --width=350 --height=300 --list --title "Type of selection" --text "Choose type of selection:" --radiolist --column "" --column "Select:" TRUE "All" FALSE "Row by PK" FALSE "Back to second menu")
# if [ $? -ne 0 ]; then
#     break
# fi
case $selection in

"All")
    selectAll
    ;;
"Row by PK")
    selectRow
    ;;
"Back to second menu")
    source $mydir/secondMenu.sh
    ;;
*)
    echo "Invalid option"
    zenity --error \
        --text="Invalid option"
    ;;
esac

# select option in "Select all from table" "SElect Row with pk" "Back to second menu"
# do
#     case $REPLY in
#         1 )
#         selectAll
#         ;;
#         2 )
#         selectRow
#         ;;
#         3 )
#                         source $mydir/secondMenu.sh
# ;;

#         * ) echo "Invalid option";;
#     esac
# done
