PS3="Enter query operation number [$dbname][$tablename] : "
select choice in "Select-All" "Selection" "Projection" "Exit";
do
    case $REPLY in
        1) 
            source SelectAll.sh
	        break;;
        2) 
            source Selection.sh
            break;;
        3) 
            source Projection.sh
            break;;
        4)
            echo "----------------------------------------------------------------------"
            source QueryMenu.sh
            break;;
        *) 
            echo "----------------------------------------------------------------------"
            echo "--------------------------------wrong choise--------------------------"
            echo "----------------------------------------------------------------------"
    esac
done
