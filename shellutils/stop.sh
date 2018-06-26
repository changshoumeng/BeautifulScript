#!/bin/bash
#date:2015-01-29
#author:zhangtao
#desc:stop the service by given service-name
######################################################
SERVICE_NAME=imgate
WATCHDOG_NAME=startimgate.sh
#######################################
function stopService()
{
        PROCESS_NAME=$1

        PIDS=`ps axu | grep $PROCESS_NAME | grep -v "grep" | awk '{print $2}'`
	PIDNUM=0

	for PID in $PIDS
	do      	
		echo "IsKilled : $PROCESS_NAME : $PID"
                kill -9 $PID
		let PIDNUM=$PIDNUM+1	       
	done 
	
	if [ $PIDNUM == 0 ] ;then
		echo "NotFound : $PROCESS_NAME"
	else 
		echo "FoundNum : $PROCESS_NAME : $PIDNUM"
        fi 
      
        echo "-------"  
	return 
}
####################################
function printPrompt()
{
	read -p ">>>:you must input 'yes' to continue:" choice
        [ "$choice" != "yes" ] && echo ">>>: not yes,so exit" && exit 0
        echo ">>>:yes,continue..."
}

#####################################
function main()
{
	printPrompt

    #set -x
    echo "............"

    PROCESS_ARRAY=($WATCHDOG_NAME $SERVICE_NAME)
    echo "length of process_array :${#PROCESS_ARRAY[@]}"

    echo "============"
    for PROCESS in ${PROCESS_ARRAY[@]};
    do
            stopService $PROCESS
    done

    echo "---->finished"

}

main
