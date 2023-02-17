#!/bin/bash
echo "---------------------All Databases In The System---------------------"
ls -F ~/DB | grep / | cut -f1 -d/ 
echo "----------------------------------------------------------------------"
source DBMenu.sh
