#!/bin/bash
valid=0
if [[ $tablename=[a-zA-Z]*([A-Z]|[_-]|[a-z]|[0-9]) ]];
then
    if [[ $1 -eq 0 ]]; # 0 for create table
    then
        if ! [[ -e ~/DB/$dbname/$tablename ]];
        then
            valid=1
        else
            echo "----------------------------------------------------------------------"
            echo "-----------------Table [$tablename] is alredy exist------------------"
            echo "----------------------------------------------------------------------"
        fi
    elif [[ $1 -eq 1 ]]; # for all
    then
        if ! [[ -e ~/DB/$dbname/$tablename ]];
        then
            echo "----------------------------------------------------------------------"
            echo "--------------------Table [$tablename] is not exist-----------------"
            echo "----------------------------------------------------------------------"
        else
            valid=1
        fi
    fi
else
    echo "----------------------------------------------------------------------"
    echo "-----------The Table name not contain spechial characters-------------"
    echo "----------------------------------------------------------------------"
fi
