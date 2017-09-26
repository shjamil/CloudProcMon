#!/bin/bash
PID=$(pgrep qemu | head -1 | tail -1)
pcpu=$(top -b -n2 -p $PID |tail -n 1 | awk '{print $9}')
OS_server_id=$( awk -F , -v OFS='\t' 'NR == 1 || $6 > 4 {print $11}' /proc/$PID/cmdline | cut -c6-)
case $pcpu in
[1-44]*)
echo "OK - CPU utilization of PID $PID OpenStack Server ID $OS_server_id is $pcpu%."
exit 0
;;
[45-70]*)
echo "WARNING - CPU utilization of PID $PID OpenStack Server ID $OS_server_id is $pcpu%."
exit 1
;;
[71-100]*)
echo "CRITICAL - CPU utilization of PID $PID OpenStack Server ID $OS_server_id is $pcpu%."
exit 2
;;
*)
echo "UNKNOWN - CPU utilization of PID $PID OpenStack Server ID $OS_server_id is $pcpu%."
exit 3
;;
esac

