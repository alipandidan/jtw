#!/bin/bash
JAVA_PID=$(pidof java)
STRACE_FILE=strace.tmp
jstack $JAVA_PID > $STRACE_FILE
echo "[$(date '+%Y-%m-%d %H:%M:%S %Z')] Running thread scan"
ps -To pcpu,tid,time -C java | sort -r -s -n -k 1,1  | head -n 10 | awk '$1 > 25' | while read -r LINE ; do
    PCPU=$(echo $LINE | awk '{print $1}')
    PID=$(echo $LINE | awk '{print $2}')
    TIME=$(echo $LINE | awk '{print $3}')
    HEX_PID=$(printf "%x\n" $PID)
    echo "(CPU: ${PCPU}%) [Duration: ${TIME}] Thread information: $(grep -i $HEX_PID $STRACE_FILE)" >> threads.log
done
