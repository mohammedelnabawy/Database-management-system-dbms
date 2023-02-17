#!/bin/bash

# Auther : Maha El-Komy   &&   Mahammed El-Nabawy
# Creted Time : 3 / 1 / 2023
# Last Modified : 10 / 1 /2023 

# Description
# 

# Usage
#


shopt -s extglob
echo "----------------------------------------------------------------------"
echo "------------------------- Welcom to our DBMS -------------------------"
echo "----------------------------------------------------------------------"
PS3="Enter your choice number: "
select choice in "Enter to DBMS system" "Exit";
do
    case $REPLY in
        1) 
            if ! [[ -e ~/DB ]];
            then
                mkdir ~/DB
            fi
            cd ~/DB
	        echo "----------------------------------------------------------------------"
            source DBMenu.sh
            break;;
        2) 
            break;;
        *) 
            echo "----------------------------------------------------------------------"
            echo "---------------------------- wrong choice ----------------------------"
            echo "----------------------------------------------------------------------";;
    esac
done

















