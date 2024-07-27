#!/bin/bash


CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
LOG_FILE="/var/log/system_health.log"

check_cpu_usage() {
    CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" |bc -l) )); then
        echo "High CPU usage detected: $CPU_USAGE%" | tee -a $LOG_FILE
    fi
}

check_memory_usage() {
    MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" |bc -l) )); then
        echo "High Memory usage detected: $MEMORY_USAGE%" | tee -a $LOG_FILE
    fi
}

check_disk_usage() {
    DISK_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
    if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
        echo "High Disk usage detected: $DISK_USAGE%" | tee -a $LOG_FILE
    fi
}

check_running_processes() {
    PROCESS_COUNT=$(ps aux | wc -l)
    echo "Number of running processes: $PROCESS_COUNT" | tee -a $LOG_FILE
}

run_health_check() {
    echo "System Health Check - $(date)" | tee -a $LOG_FILE
    check_cpu_usage
    check_memory_usage
    check_disk_usage
    check_running_processes
    echo "Health check complete." | tee -a $LOG_FILE
    echo
}


run_health_check