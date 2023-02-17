#!/bin/bash
while true
do
    read -r -p "Create DataBase <DataBase name>: " dbname
    source DatabaseValidation.sh 0
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

mkdir ~/DB/$dbname
echo "--------------------------------------------------------------------------------------------------"
echo "------------------------------------ DataBase $dbname is Added -----------------------------------"
echo "--------------------------------------------------------------------------------------------------"
source DBMenu.sh

