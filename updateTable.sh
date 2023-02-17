#!/bin/bash

# table name validation
while true
do
    read -p "[$dbname] Update table <table name> : " tablename
    source TableValidation.sh 1
    if [[ $valid -eq 1 ]]
    then 
        break
    fi
done

# field name validation
while true
do
	read -p "[$dbname][$tablename] Field <Field name> : " fieldname
	source FieldValidation.sh 1
	if [[ $valid -eq 1 ]]
	then 
		break
	fi
done

# information about where condition
fieldnum=$( awk -F: -v fieldname=$fieldname '{if($1==fieldname)print NR}' ~/DB/$dbname/$tablename.meta )
FieldType=`awk -F: -v fnum=$fieldnum '{if(NR==fnum)print $2}' ~/DB/$dbname/$tablename.meta`;
while true
do
    read -p "[$dbname][$tablename] Where [$fieldname] equal : " FieldValue
    source dataTypeValidation.sh
    if [ $valid -eq 1 ]	
    then
        data=$FieldValue
        break;
    fi
done


touch ~/DB/$dbname/temp2
touch ~/DB/$dbname/temp3
awk -F: -v fieldnum=$fieldnum -v data=$data '{if($fieldnum==data)print $0}' ~/DB/$dbname/$tablename > ~/DB/$dbname/temp2 # for column that will be updated
awk -F: -v fieldnum=$fieldnum -v data=$data '{if($fieldnum!=data)print $0}' ~/DB/$dbname/$tablename > ~/DB/$dbname/temp3 # column will not be updated
NumberOfTargetRows=`cat ~/DB/$dbname/temp2 | wc -l`

while true
do
    # field name validation that will be updated
    while true
    do
        read -p "[$dbname][$tablename] Field <Field name> : " fieldname
        source FieldValidation.sh 1
        if [[ $valid -eq 1 ]]
        then
            break
        fi
    done

    updatablefieldnum=$( awk -F: -v updatablefield="$fieldname" '{if($1==updatablefield)print NR}' ~/DB/$dbname/"$tablename".meta )

    # check if we will update the primary key
    if [[ NumberOfTargetRows -gt 1 &&  updatablefieldnum -eq 1 ]]
    then
        echo "----------------------------------------------------------------------"
        echo "-----------Primary key can't updated for more than one record---------"
        echo "----------------------------------------------------------------------"
        continue 
    fi

    FieldType=$( awk -F: -v fieldname="$fieldname" '{if($1==fieldname)print $2}' ~/DB/$dbname/"$tablename".meta )
    touch ~/DB/$dbname/temp
    
    while true
    do
        
        while true
        do
            read -p "[$dbname][$tablename] Set [$fieldname] equal : " FieldValue
            source dataTypeValidation.sh;
            if [ $valid -eq 1 ]	
            then
                break;
            fi	
        done

        if [[ $updatablefieldnum -eq 1 ]]
        then
            if [[ $(cut -d":" -f 1 $tablename | grep "^$FieldValue$") ]];
            then
				echo "----------------------------------------------------------------------"
				echo "---------------------primary key should be unique---------------------"
				echo "----------------------------------------------------------------------" 
                continue
			fi
		fi
        awk -F: -v data=$data -v fieldnum=$fieldnum -v updatablefieldnum=$updatablefieldnum -v FieldValue=$FieldValue 'BEGIN {OFS = FS} {if($fieldnum==data){$updatablefieldnum=FieldValue;} print $0}' ~/DB/$dbname/temp2 > ~/DB/$dbname/temp
        break
    done

    if [[ $updatablefieldnum -eq  $fieldnum ]]
    then
        data=$FieldValue
    fi

    cat ~/DB/$dbname/temp > ~/DB/$dbname/temp2

    read -N 1 -p "Are you want another update [y/n]? " check
    while true
    do
        if [[ $check = "y" ]]
        then
            echo
            continue 2
        elif [[ $check = "n" ]] 
        then
            echo
            break 2
        else
            break 2
        fi
    done
done



    cat ~/DB/$dbname/temp2 >> ~/DB/$dbname/temp3
    NumberOfRowUpdated=`sort ~/DB/$dbname/temp3 ~/DB/$dbname/$tablename | uniq -u | wc -l`   # unique print replicated record once, -u option print only unique record
    NumberOfRowUpdated=$(( $NumberOfRowUpdated/2  ))
    sort -n ~/DB/$dbname/temp3 > ~/DB/$dbname/"$tablename"
    rm -f ~/DB/$dbname/temp*

    echo "----------------------------------------------------------------------"
    echo "---------------------- $NumberOfRowUpdated rows is updated -----------------------------"
    echo "----------------------------------------------------------------------"

source QueryMenu.sh


