#! /bin/bash



    cd ~/DBs
    #     #check if the dataBase exist
    if [[ -d ~/DBs/$dbname ]]; then

        cd ~/DBs/$dbname
        ls
        # arrayTables=($(ls))
        #tables=$(zenity --list --title="Choose the Table to Insert into" --column "Tables Available" "${arrayTables[@]}")

        tableName=$(zenity --entry \
            --width 500 \
            --title "Enter Table Name" \
            --text "Enter the Table Name")
        printf "\nEnter the name of table ?\n"
        # read tableName

        #Check the validation
        if [[ $tableName =~ ^[a-zA-Z][a-zA-Z0-9_]+$ ]]; then

            if [ -f "$dbname/$tableName" ]; then

                echo "This table_name is  already exist"
                zenity --warning \
                    --text="This table_name is  already exist."

            else
                # cd $dbname

                echo "Enter your noColumn"
                # read col
                # export $col

                col=$(zenity --entry \
                    --width 500 \
                    --title "Enter Number of Columns" \
                    --text "Enter Number of Columns")
                if [ ! -f tableName ]; then
                    touch "."$tableName"_metadata"
                    touch $tableName
                    export $tableName
                    echo -ne "$col\n" >>"."$tableName"_metadata"
                    if [ $col -gt 0 ]; then
                        for ((i = 0; i < $col; i++)); do
                            echo "What is the column names note:[The first column is PK]"
                            Names[$i]=$(zenity --entry \
                                --width 500 \
                                --title "EEnter the name of col $i note:[The first column is PK]" \
                                --text "EEnter the name of col $i")
                            # read  Names[$i]
                            echo -n "${Names[$i]}:" >>"."$tableName"_metadata"

                            #$arr[i] >> $tableName"_metadata"
                            echo "what is your data type column $i"
                            datatyp=$(zenity --width=350 --height=300 --list --title "Datatpe of col $i" --text "Choose a ata type:" --radiolist --column "" --column "datatypes": TRUE "int" FALSE "string")

                            case $datatyp in
                            "int")

                                echo -n "$datatyp " >>"."$tableName"_metadata"
                                
                                ;;
                            "string")

                                echo -n "$datatyp " >>"."$tableName"_metadata"
                                
                                ;;
                            *)
                                echo "please enter a valid data type"
                                zenity --error \
                                    --text="This table_name is  already exist."
                                ;;
                            esac

                        done

                    else

                        echo "No Column should be greater than 0"
                        zenity --warning \
                            --text="No.Column should be greater than 0"
                    fi
                else
                    echo
                    zenity --warning \
                        --text="This table name already exists"

                fi

            fi

        else

            echo
            zenity --warning \
                --text="the table name must be string only ,,please try again"
            . $mydir/createTable.sh

        fi

    else

        

        echo "Go back to menu"
        . $mydir/firstmenu.sh
        #calling menu

    fi


