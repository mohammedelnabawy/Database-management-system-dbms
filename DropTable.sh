#!/bin/bash

while true
do
    read -p "[$dbname] Drop table <table name>: " tablename
    source TableValidation.sh 1
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

rm ~/DB/$dbname/$tablename
rm ~/DB/$dbname/$tablename.meta
echo "----------------------------------------------------------------------"
echo "------------------------Table [$tablename] is removed----------------"
echo "----------------------------------------------------------------------"
source QueryMenu.sh
