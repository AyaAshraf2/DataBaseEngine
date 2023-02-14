#! /bin/bash

secondMenu() {
    cd ~/DBs/$dbname

    # select choise in "Create Table" "Select from Table" "Drop table if exists" "Insert Row" "Delete from table" "Update Table" "Back to main menu"
    # do
    SecondMenu=$(zenity --width=350 --height=300 --list --title "Database Manager" --text "Choose a database operation:" --radiolist --column "" --column "Operation" TRUE "Create Table" FALSE "Select Row" FALSE "Drop Table" FALSE "Insert Into Row" FALSE "Delete Row" FALSE "Update Row" FALSE "MainMenu" FALSE "exit")

    if [ $? -ne 0 ]; then
        exit
    fi
    case $SecondMenu in

    "Create Table")

        source $mydir/createTable.sh
        ;;

    "Select Row")
        source $mydir/selectRow.sh
        ;;

        #source select

    "Drop Table")

        source $mydir/dropTable.sh

        ;;
    "Insert Into Row")

        source $mydir/insert.sh
        ;;

    
        "Delete Row")

        source $mydir/deleteRow.sh
        ;;

    "Update Row")
        source $mydir/updateRow.sh
        ;;
    "MainMenu")
        source $mydir/firstmenu.sh
        ;;

    "Exit") ;;

    *)
        echo "Insert a valid option please"
        ;;
    esac

    # done

}

secondMenu
