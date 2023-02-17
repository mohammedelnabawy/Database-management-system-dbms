#!/bin/bash

# table name validation
while true
do
    read -p "[$dbname] Create table <table name>: " tablename
    source TableValidation.sh 0
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

touch "$tablename" "$tablename"".meta"
while true
do
    read -p "[$dbname] Set number of [$tablename] fields : " fieldSizes
    if [[ $fieldSizes = +([0-9]) ]]
    then
        echo "----------------------------------------------------------------------"
        echo "-----------First Field will be the Primary key feild------------------"
        echo "----------------------------------------------------------------------"

        while (( $fieldSizes > 0 ));
        do
            # Field validation
            while true
            do
                read -p "[$dbname][$tablename] Set Field <Field name> : " fieldname
                source FieldValidation.sh 0
                if [[ $valid -eq 1 ]]
                then 
                    break
                fi
            done

            # Field DataType
            PS3="[$fieldname] DataType : "
            select choice in "String" "Int"
            do
                case $REPLY in
                    1) 
                        echo $fieldname:$choice >> "$tablename"".meta"
                        fieldSizes=$(( fieldSizes - 1))
                        break;;
                    2) 
                        echo $fieldname:$choice >> "$tablename"".meta"
                        fieldSizes=$(( fieldSizes - 1))
                        break;;
                    *)  
                        echo "----------------------------------------------------------------------"
                        echo "------------------------------wrong choise----------------------------"
                        echo "----------------------------------------------------------------------"
                esac
            done
            
        done
        break
    else
        echo "----------------------------------------------------------------------"
        echo "------------------ Number of Feilds must be integer ------------------"
        echo "----------------------------------------------------------------------"
    fi
done
source QueryMenu.sh