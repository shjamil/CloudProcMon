#!/bin/bash
PID=$(pgrep qemu | head -1 | tail -1)
ram=$(top -b -n2 -p $PID |tail -n 1 | awk '{print $10}')
OS_server_id=$( awk -F , -v OFS='\t' 'NR == 1 || $6 > 4 {print $11}' /proc/$PID/cmdline | cut -c6-)
case $ram in
[1-30]*)
echo "OK - Memory utilization of PID $PID OpenStack Server ID $OS_server_id is $ram%."
exit 0
;;
[31-50]*)
echo "WARNING - Memory utilization of PID $PID OpenStack Server ID $OS_server_id is $ram%."
exit 1
;;
[51-100]*)
echo "CRITICAL - Memory utilization of PID $PID OpenStack Server ID $OS_server_id is $ram%."
exit 2
;;
*)
echo "UNKNOWN - Memory utilization of PID $PID OpenStack Server ID $OS_server_id is $ram%."
exit 3
;;
esac

