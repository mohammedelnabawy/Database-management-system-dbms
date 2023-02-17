#!/bin/bash

while true
do
	read -p "[$dbname][$tablename] Select <Field name>: " fieldname
	source FieldValidation.sh 1
	if [[ $valid -eq 1 ]]
	then 
		break
	fi
done

FieldNum=`awk -F: -v fname=$fieldname '{if($1==fname)print NR}' ~/DB/$dbname/$tablename.meta`;
FieldType=`awk -F: -v fnum=$FieldNum '{if(NR==fnum)print $2}' ~/DB/$dbname/$tablename.meta`;
while true
do
	read -p "[$dbname][$tablename] Where [$fieldname] equal : " FieldValue
	source dataTypeValidation.sh
	if [ $valid -eq 1 ]	
	then
		break;
	fi
done

header=""
FieldName=`cut -d":" -f1 ~/DB/$dbname/$tablename.meta`;
for field in $FieldName
do
    header+=${field^^}","
done

echo "-------------Output data In [$dbname][$tablename] table-------------"
awk -F: -v fnum=$FieldNum -v fvalue=$FieldValue '{if($fnum==fvalue)print $0}' ~/DB/$dbname/$tablename | column -t -s ":" -N "$header" -o "|"
echo "----------------------------------------------------------------------"

source SelectMenu.sh
