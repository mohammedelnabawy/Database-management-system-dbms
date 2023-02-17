#!/bin/bash
PS3="Enter DB operation number: "
select choice in "CreateDB" "ConnectDB" "ListDB" "DropDB" "Exit";
do
    case $REPLY in
        1) 
            source CreateDB.sh
            break;;
        2) 
            source ConnectDB.sh
            break;;
        3) 
            source ListDB.sh
            break;;
        4) 
            source DropDB.sh
            break;;
        5) 
            break;;
        *) 
            echo "----------------------------------------------------------------------"
            echo "---------------------------- wrong choice ----------------------------"
            echo "----------------------------------------------------------------------";;
    esac
done
