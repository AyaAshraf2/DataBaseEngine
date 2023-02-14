
#! /bin/bash


# choice=$(zenity --list --title="Choose the DB to connect --column="Bug Number" --column="Severity" --column="Description" \
#     992383 Normal "GtkTreeView crashes on multiple selections" \
#     293823 High "GNOME Dictionary does not handle proxy" \
#     393823 Critical "Menu editing does not work in GNOME )

# 
cd ~/DBs
arr_dataBases=($(ls))
 choice=$(zenity --list \
       --title="Choose the DB to connect" \
      --column "Databases Available" "${arr_dataBases[@]}" )

echo hi
echo $choice