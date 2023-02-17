#!/bin/bash

while true
do
    read -p "[$dbname] Delete from table <table name>: " tablename
    source TableValidation.sh 1
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

PS3="Enter Delete type number: "
before=$(wc -l < ~/DB/$dbname/$tablename)
select choice in "Delete ALL Records" "Delete Specific Records"
do
    case $REPLY in
        1) 
            > ~/DB/$dbname/$tablename
            break;;
        2)
            while true
            do
                read -p "[$dbname][$tablename] Where <Field name>: " fieldname
                source FieldValidation.sh 1
                if [[ $valid -eq 1 ]]
                then 
                    break
                fi
            done

            fieldnum=$( awk -F: -v fieldname=$fieldname '{if($1==fieldname)print NR}' ~/DB/$dbname/$tablename.meta )
            FieldType=`awk -F: -v fnum=$fieldnum '{if(NR==fnum)print $2}' ~/DB/$dbname/$tablename.meta`;
            while true
            do
                read -p "[$dbname][$tablename] Where [$fieldname] equal : " FieldValue
                source dataTypeValidation.sh
                if [ $valid -eq 1 ]	
                then
                    break;
                fi
            done
            
            touch ~/DB/$dbname/temp
            awk -F: -v data=$FieldValue fieldnum=$fieldnum'{if($fieldnum!=data)print $0}' ~/DB/$dbname/$tablename > ~/DB/$dbname/temp
            cat ~/DB/$dbname/temp > ~/DB/$dbname/$tablename
            rm -f ~/DB/$dbname/temp
            break;;
        *)  
            echo "----------------------------------------------------------------------"
            echo "----------------------------wrong choise------------------------------"
            echo "----------------------------------------------------------------------"
    esac
done
after=$(wc -l < ~/DB/$dbname/$tablename)
echo "----------------------------------------------------------------------"
echo "--------------------"$(( $before - $after )) record is deleted"---------------------------"
echo "----------------------------------------------------------------------" 
source QueryMenu.sh