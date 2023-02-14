#! /bin/bash
#. ${BASH_SOURCE%/*}/createTable.sh
export LC_COLLATE=C
shopt -s extglob

cd ~/DBs/$dbname

echo "all tables in  DataBase $dbname is : "
ls ~/DBs/$dbname
# ls ~/BashProject/$dbname | grep -v ".sh$"

arrayTables=($(ls))
tableName=$(zenity --list --title="Choose the Table to Insert into" --column "Tables Available" "${arrayTables[@]}")

updateRow() {
  # read -p "choose table: " tableName

  if [[ -f $tableName ]]; then
    # tableName=$1
    metadataFileRelativePath="."$tableName"_metadata"
    dataFileRelativePath=$tableName

    echo "Updating table '$tableName'"
    # zenity --info \
    #   --title "Updating $tableName" \
    #   --width 300 \
    #   --text="Updating $tableName"

    cat ~/DBs/$dbname/$tableName
    zenity --text-info \
      --title "Table Contents" \
      --filename "$totalfile" \
      --filename "$tableName" \
      --font "16"
    metadata=$(cat $metadataFileRelativePath | tail -1)
    columnsCount=$(cat $metadataFileRelativePath | head -1)

    IFS=$': ' read -r -a metaArray <<<"$metadata"

    echo "Enter primary key of the record that u want to update:"
    # read primaryKey
    primaryKey=$(zenity --entry \
      --width 500 \
      --title "Enter Primary key to update its row" \
      --text "Enter the pk of the row" \
      --entry-text primary-key)

    primaryKeyExists=$(cut -d "|" -f 1 $dataFileRelativePath | grep ^$primaryKey$)
    echo $primaryKeyExists

    if [[ -n $primaryKeyExists ]]; then
      # primary key exists in table
      columnNumberIsValid=0
      while [[ $columnNumberIsValid == 0 ]]; do
        echo "Enter the column number of the value that u want to update: "
        columnNumber=$(zenity --entry \
          --width 500 \
          --title "Enter Column Number" \
          --text "Enter the cokno to update" \
          --entry-text colno)

        # read columnNumber
        if [[ $columnNumber -gt 1 ]] && [[ $columnNumber -le $columnsCount ]]; then
          columnNumberIsValid=1
        else
          echo "Wrong column number! please enter column number between 2 and $columnsCount"
          zenity --error \
            --text="Wrong column number! please enter column number between 2 and $columnsCount"
        fi
      done

      oldValue=$(awk -F"|" '$1=='$primaryKey' {print $'$columnNumber'}' $dataFileRelativePath)
      echo "Please enter the new value: "
      newVal=$(zenity --entry \
        --width 500 \
        --title "Enter the new value to update" \
        --text "Enter the new value" \
        --entry-text newVal)
      #  read newVal

      dataTypearr2=()

      for ((index = 1; index < columnsCount * 2; index += 2)); do

        dataTypearr2+=(${metaArray[$index]})

      done

      colnum=${dataTypearr2[$columnNumber - 1]}

      if [[ $colnum == "int" ]]; then
        if ! [[ $newVal = +([1-9])*([0-9]) ]]; then
          dataTypeError=1
          errorFlag=1
          echo "ERROR: Value must be an integer"
           zenity --error \
            --text="ERROR: Value must be an integer"

          updateRow
        else

          echo "Replacing '$oldValue' with '$newVal'"
              zenity --info \
      --title "Updating.." \
      --width 300 \
      --text="Replacing '$oldValue' with '$newVal'"

          oldRow=$(cat $dataFileRelativePath | grep ^$primaryKey\|)
          newRow=${oldRow/$oldValue/"$newVal"}
          sed -i s/^$oldRow$/$newRow/ $dataFileRelativePath
            zenity --text-info \
      --title "Table Contents" \
      --filename "$dataFileRelativePath" \
      --font "16"
        fi
      else #string
        echo "Replacing '$oldValue' with '$newVal'"
          zenity --info \
      --title "Updating.." \
      --width 300 \
      --text="Replacing '$oldValue' with '$newVal'"

        oldRow=$(cat $dataFileRelativePath | grep ^$primaryKey\|)
        newRow=${oldRow/$oldValue/"$newVal"}
        sed -i s/^$oldRow$/$newRow/g $dataFileRelativePath
        zenity --text-info \
      --title "Table Contents" \
      --filename "$dataFileRelativePath" \
      --font "16"
      fi
    else
      echo "The primary key that you have entered doesn't exist!"
      zenity --error \
            --text="The primary key that you have entered doesn't exist!"
      updateRow

    fi
  else
    echo "The table you have entered doesn't exist!"
    zenity --error \
            --text="The table you have entered doesn't exist!"
    updateRow
  fi

}
updateRow
