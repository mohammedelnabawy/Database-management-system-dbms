#!/bin/bash

while true
do
    read -p "Drop DataBase <DataBase name>: " dbname
    source DatabaseValidation.sh 1
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

rm -r ~/DB/$dbname
echo "----------------------------------------------------------------------"
echo "------------------DataBase [$dbname] is removed-------------------"
echo "----------------------------------------------------------------------"
source DBMenu.sh
