#!/bin/bash

while true
do
    read -p "Connect DataBase <DataBase name>: " dbname
    source DatabaseValidation.sh 1
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

echo "----------------------------------------------------------------------"
echo "------------------ DataBase ["$dbname"] is connected -----------------"
echo "----------------------------------------------------------------------"
cd ~/DB/$dbname
source QueryMenu.sh 
