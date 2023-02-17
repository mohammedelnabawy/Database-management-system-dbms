#!/bin/bash
header=""
FieldName=`cut -d":" -f1 ~/DB/$dbname/$tablename.meta`;
for field in $FieldName
do
    header+=${field^^}"," # ^^ for capitalization
done

echo "---------------All data In [$dbname][$tablename] table---------------"
#cat ~/DB/$1/$2 #read all data in table
column -t -s ":" -N "$header" -o "|" ~/DB/$dbname/$tablename
echo "----------------------------------------------------------------------"
source SelectMenu.sh
