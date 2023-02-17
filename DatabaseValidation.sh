#!/bin/bash
valid=0
if [[ $dbname = [A-Za-z]*([A-Z]|[_-]|[a-z]|[0-9]) ]];
then
    if [[ $1 -eq 0 ]]; # 0 for create database
    then
        if ! [[ -e ~/DB/$dbname ]];
        then
            valid=1
        else
            echo "----------------------------------------------------------------------"
            echo "----------------- DataBase ["$dbname"] is alredy exist ---------------"
            echo "----------------------------------------------------------------------"
            
        fi
    elif [[ $1 -eq 1 ]]; # 1 for connect, and delete database
    then
        if ! [[ -e ~/DB/$dbname ]];
        then
            echo "----------------------------------------------------------------------"
            echo "----------------- DataBase ["$dbname"] is not exist ----------------"
            echo "----------------------------------------------------------------------"
            
        else
            valid=1
        fi
    fi
else
    echo "----------------------------------------------------------------------"
    echo "----------The database name not contain spechial characters-----------"
    echo "----------------------------------------------------------------------"
fi
