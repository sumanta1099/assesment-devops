#!/bin/bash

LOG_FILE="/var/log/nginx/access.log"

count_404_errors() {
    echo "Number of 404 errors:"
    grep " 404 " $LOG_FILE | wc -l
    echo
}

most_requested_pages() {
    echo "Most requested pages:"
    awk '{print $7}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10
    echo
}

most_requesting_ips() {
    echo "IP addresses with the most requests:"
    awk '{print $1}' $LOG_FILE | sort | uniq -c | sort -nr | head -n 10
    echo
}

generate_report() {
    echo "Log File Analysis Report"
    echo "========================"
    echo
    count_404_errors
    most_requested_pages
    most_requesting_ips
    echo "Report generation complete."
}

generate_report