#!/bin/bash
# shopt -s extglob
echo "----------------------------------------------------------------------"
echo "-----------------All Tables In [$dbname] database---------------------"
ls -I "*.meta" | column #list all thing except the match pattern
echo "----------------------------------------------------------------------"
source QueryMenu.sh
