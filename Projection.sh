#!/bin/bash
# Enter number of fields
FieldArr=""
while true
    read -p "[$dbname][$tablename] Number of Fields : " Fcount;
    do
        if [[ $Fcount = +([0-9]) ]]
        then
            break
        fi
    done


echo "----------------------------------------------------------------------"
echo "------------ The dublicated column will be print once ----------------"
echo "----------------------------------------------------------------------"


# touch ~/DB/$dbname/header # file for display header
touch ~/DB/$dbname/headerNum
touch ~/DB/$dbname/headerNumPrint
header=""

while (( $Fcount > 0 ))
do
    while true
    do
        read -p "[$dbname][$tablename] Select <Field name>: " fieldname
        source FieldValidation.sh 1
        if [[ $valid -eq 1 ]]
        then 
            break
        fi
    done

    # for create -f for cut like this -----> 1,2,3,4
    FieldNum=`awk -F: -v fname=$fieldname '{if($1==fname)print NR}' ~/DB/$dbname/$tablename.meta`;
    
    if [ $Fcount -eq 1 ]
    then
        FieldArr=$FieldArr$FieldNum;
    else
        FieldArr=$FieldArr$FieldNum",";
    fi
    Fcount=$(( Fcount - 1));

    if ! [[ $(grep -w "^$FieldNum$" ~/DB/$dbname/headerNum) ]];
    then
    	echo $FieldNum >> ~/DB/$dbname/headerNum;
        # echo $fieldname >> ~/DB/$dbname/header
    fi
    
done

sort ~/DB/$dbname/headerNum | uniq > ~/DB/$dbname/headerNumPrint;
fieldHeader=`cat ~/DB/$dbname/headerNumPrint`;
for num in $fieldHeader
do
	headerTemp=`awk -F: -v fnum=$num '{if(NR==fnum)print $1}' ~/DB/$dbname/$tablename.meta`;
	header+=${headerTemp^^};
	header+=",";
done


echo "-------------Output data In [$dbname][$tablename] table---------------"
cut -d: -f $FieldArr ~/DB/$dbname/$tablename | column -t -s ":" -N "$header" -o "|"
echo "----------------------------------------------------------------------"
rm -f ~/DB/$dbname/header*
source SelectMenu.sh
