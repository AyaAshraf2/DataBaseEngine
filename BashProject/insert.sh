#! /bin/bash

clear
cd ~/DBs/$dbname
echo "Tables in DB:"
# ls
arrayTables=($(ls))
tableName=$(zenity --list --title="Choose the Table to Insert into" --column "Tables Available" "${arrayTables[@]}")
filee=$(cat "."$tableName"_metadata" | tail -1)
colno=$(cat "."$tableName"_metadata" | head -1)

export colno
#echo $filee
IFS=$': ' read -r -a metaArray <<<"$filee"




totalfile="."$tableName"_metadata" >>"$tableName"
zenity --text-info \
    --title "Table Contents" \
    --filename "$totalfile" \
    --filename "$tableName" \
    --font "16"



cat $tableName

insertRow() {
    dataTypeError=0
    pkError=0
    errorFlag=0
    for ((i = 0; i < colno * 2; i += 2)); do

        colName=${metaArray[i]}
        colDataType=${metaArray[i + 1]}

        # read -p "Enter $colName: " newVal
        newVal=$(zenity --entry \
            --width 500 \
            --title "Enter $colName" \
            --text "Enter the $colName " \
            --entry-text newValue)

        if [[ $colDataType == "int" ]]; then
            if ! [[ $newVal =~ ^[1-9]*[0-9]+$ ]]; then
                dataTypeError=1
                errorFlag=1
                echo "ERROR: Value must be an integer"
                zenity --error \
                    --text="ERROR: Value must be an integer"
                insertRow
            fi
        fi

        #checking PK for only first col.

        if [[ ${colName[i]} == ${metaArray[0]} ]]; then

            IFS=$'\n' read -r -a dataLines <"$tableName"

            for j in "${!dataLines[@]}"; do
                IFS='|' read -r -a record <<<"${dataLines[$j]}"
                if [[ ${record[i]} == $newVal ]]; then
                    pkError=1
                    errorFlag=1
                    echo "ERROR: Primary key must be unique"
                    zenity --error \
                        --text="ERROR:Primary key must be unique "
                    insertRow

                fi
            done
        fi

        if [[ $dataTypeError == 0 ]] && [[ $pkError == 0 ]]; then
            if [[ $i == 0 ]]; then
                newRecord=$newVal
            else
                newRecord="$newRecord|$newVal"
            fi
        else
            echo "inValid record"
            zenity --error \
                --text="ERROR:Invalid record"
            insertRow

        fi

    done

    # echo $pkFlag

    if ! [[ $newRecord == "" ]]; then
        if [[ $errorFlag == 0 ]] && [[ $pkError == 0 ]]; then
            if echo $newRecord >>"$tableName"; then
                echo "Inserted Successfully"
                zenity --info \
                    --text="Inserted Successfully."

                source $mydir/secondMenu.sh
            else
                echo "ERROR: Failed to insert"

                zenity --error \
                    --text="Failed to Insert"
                source $mydir/secondMenu.sh

            fi
        else
            echo "ERROR: Failed to store record in $tableName"
            source $mydir/secondMenu.sh

        fi
    else
        echo "ERROR: Record is empty"
        source $mydir/secondMenu.sh

    fi

}
insertRow
#--------------------------------------------------------------------------------------------------

