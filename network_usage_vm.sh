#!/bin/bash
PID=$(pgrep qemu | head -1 | tail -1)
mac=$(awk -F , -v OFS='\t' 'NR == 1 || $6 > 4 {print $39}' /proc/$PID/cmdline | cut -c7-)
tap=$(ifconfig | grep $mac | awk '{print$1}')
bandwidth=$(sudo iftop -B -i $tap -t -s1 2>/dev/null |grep 'l send a'|awk {'print $8'} )
OS_server_id=$( awk -F , -v OFS='\t' 'NR == 1 || $6 > 4 {print $11}' /proc/$PID/cmdline | cut -c6-)
#case $bandwidth in
#[10000-30000]*)
#echo "$bandwidth"
echo "Send/Receive by  PID $PID OPEN STACK SERVER ID $OS_server_id is $bandwidth ."
#exit 0
#;;
#[31000-50000]*)
#echo "WARNING - Send/Receive by  PID $PID OPEN STACK SERVER ID $OS_server_id is $bandwidth."
#exit 1
#;;
#[51000-100000]*)
#ech "CRITICAL - Send/Receive by  PID $PID OPEN STACK SERVER ID $OS_server_id is $bandwidth."
#esac
exit
