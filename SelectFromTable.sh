#!/bin/bash

while true
do
    read -p "[$dbname] Select From <table name>: " tablename
    source TableValidation.sh 1
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

source SelectMenu.sh
