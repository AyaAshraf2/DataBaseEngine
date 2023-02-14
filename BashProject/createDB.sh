#! /bin/bash

export LC_COLLATE=C
shopt -s extglob

echo "please Enter the name of the database"
#read  dbname

CreateDB() {
    dbname=$(zenity --entry --title="CreateDB" --width=300 --height=200 --text="Enter name of new db:" --entry-text dbname)

    echo "$dbname"

    if [[ $dbname =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]]; then
        if [ -d ~/DBs/$dbname ]; then

            echo "$dbname is already exists please enter another name"
            zenity --warning --title="Invalid Input" --text="DB already exists enter another name" --no-wrap

        else
            # echo "$dbname has been created"
            zenity --info --width=300 --text="$dbname has been created successfully"
            mkdir -p ~/DBs/$dbname

            export $dbname

            . $mydir/firstmenu.sh

        fi
    else

        if [[ $dbname == *['!'@#\$%^\&*()_/+]* ]]; then
            echo "DB name Can't contain with a special character"
            zenity --warning --title="Invalid Input" --text="DB name Can't contain with a special character" --no-wrap
            CreateDB

        fi
        if [[ $dbname =~ ^[0-9] ]]; then
            echo "DB name Can't start with a digit"
            zenity --warning --title="Invalid Input" --text="DB name Can't start with a digit" --no-wrap
            CreateDB

        fi
        if [[ $dbname == *[' ']* ]]; then
            echo "DB name Can't Have any Spaces"
            zenity --warning --title="Invalid Input" --text="DB name Can't Have any Spaces" --no-wrap

            echo "Do you want to become $(echo $dbname | sed 's/[[:space:]]//g')? press 'y' to continue"
            ans=$(zenity --question \
                --text="Do you want to replace it with  $(echo $dbname | sed 's/[[:space:]]//g') ?")
            read answer

            if [ $? -eq 0 ]; then
               zenity --info --width=300 --text="$dbname has been created successfully"
                mkdir -p ~/DBs/$(echo "$dbname" | sed 's/[[:space:]]//g')
                

            else
              
                echo "Enter another name"
                CreateDB
                # . ~/BashProject/firstmenu.sh

            fi
        fi

    fi

}
CreateDB
