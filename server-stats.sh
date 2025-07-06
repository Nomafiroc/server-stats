#!/bin/bash

mpstat 1 1 | awk '/Average:/ && $2=="all" {printf"\n\nCPU Usage\n\nIdle: %.2f%%\nTotal CPU Usage: %.2f%%\n",$NF,100-$NF}'


free -m | awk '/Mem:/ {printf"\n\nMemory Usage\n\nFree: %d\nUsed: %d\nUsed %%: %.2f%%\nFree %%: %.2f%%\n",$4,$3,$3/$2*100,$4/$2*100}' Usage

df -m | awk '/^\/dev/ {printf "\n\nDisk Usage\n\nTotal: %s\nUsed: %s\nUse%%: %s\n",$2,$3,$5}'

echo
echo
echo "Top 5 processes by CPU usage"
echo
echo

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

echo
echo
echo "Top 5 processes by Memory usage"
echo
echo

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6


echo
echo
echo "Additional Info"
echo
echo 


echo
echo
echo "OS version"
echo
echo 

cat /etc/os-release

echo
echo
echo "uptime"
echo
echo 
uptime

echo
echo
echo "load average"
echo
echo 

uptime | awk -F'load average:' '{print $2}' | xargs

echo
echo
echo "logged in users"
echo
echo 

who | wc -l

echo
echo
echo "Failed login attempts"
echo
echo 

grep "Failed password:" /var/log/auth.log 2>/dev/null | wc -l