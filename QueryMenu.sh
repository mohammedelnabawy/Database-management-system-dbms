#!/bin/bash
PS3="[$dbname] operation number : "
select choice in "Create-Table" "Drop-Table" "Insert-Into-Table" "List-Tables" "Select-From-Table" "Delete-From-Table" "Update-Table" "Exit";
do
    case $REPLY in
        1) 
            source CreateTable.sh
	        break;;
        2) 
            source DropTable.sh
            break;;
        3) 
            source InsertIntoTable.sh 
            break;;
        4) 
            source ListTables.sh  
            break;;
        5) 
            source SelectFromTable.sh 
            break;;
        6)
            source Delete.sh 
            break;;
        7)
            source updateTable.sh 
            break;;
        8)
            echo "----------------------------------------------------------------------"
            cd ~/DB
            source DBMenu.sh
            break;;
        *) 
            echo "----------------------------------------------------------------------"
            echo "------------------------------wrong choise-----------------------------"
            echo "----------------------------------------------------------------------"
    esac
done
