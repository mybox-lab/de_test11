#!/bin/bash

LOG_FILE="access.log"
# Общее количество запросов
total_requests=$(grep -c '' "$LOG_FILE")

# Количество уникальных IP-адресов
unique_ips=$(awk '{print $1}' "$LOG_FILE" | sort | uniq | wc -l)

# Количество запросов по методам (GET, POST и т.д.)
requests_by_method=$(awk -F '"' '{print $2}' "$LOG_FILE" | awk '{print $1}' | sort | uniq -c | awk '{print $1, $2}')

# Самый популярный URL
popular_url=$(awk -F '"'  '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $1, $2}')

# Создание отчета
REPORT_FILE="report.txt"
{
  echo "Отчет о логе веб-сервера"
  echo "========================"
  echo "Общее количество запросов: $total_requests"
  echo "Количество уникальных IP-адресов: $unique_ips"
  echo
  echo "Количество запросов по методам:"
  echo "$requests_by_method"
  echo
  echo "Самый популярный URL: $popular_url"
} > "$REPORT_FILE"

echo "Отчет сохранен в файл $REPORT_FILE"
