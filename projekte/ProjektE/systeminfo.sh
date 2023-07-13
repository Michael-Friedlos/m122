#!/bin/bash

# Hostname des Systems
hostname=$(hostname)

# Betriebssystemversion
os_version=$(lsb_release -d | cut -f2)

# Modellname der CPU
cpu_model=$(cat /proc/cpuinfo | grep "model name" | uniq | cut -d':' -f2)

# Anzahl der CPU-Cores
cpu_cores=$(grep -c '^processor' /proc/cpuinfo)

# Gesamter und genutzter Arbeitsspeicher
total_memory=$(free -h | awk '/Mem:/{print $2}')
used_memory=$(free -h | awk '/Mem:/{print $3}')

# Menge des verfügbaren, freien und belegten Speichers
available_disk_space=$(df -h --total | awk '/total/{print $2}')
free_disk_space=$(df -h --total | awk '/total/{print $4}')
used_disk_space=$(df -h --total | awk '/total/{print $3}')

# Gesamtgröße des Dateisystems
total_filesystem_size=$(df -h --total | awk '/total/{print $2}')

# Systemlaufzeit
uptime=$(uptime -p)

# Aktuelle Systemzeit
current_time=$(date '+%Y-%m-%d %H:%M:%S')

# Terminal-Ausgabe
echo "Hostname: $hostname"
echo "Betriebssystemversion: $os_version"
echo "CPU-Modell: $cpu_model"
echo "Anzahl der CPU-Cores: $cpu_cores"
echo "Arbeitsspeicher (gesamt/genutzt): $total_memory/$used_memory"
echo "Verfügbarer Speicher: $available_disk_space"
echo "Freier Speicher: $free_disk_space"
echo "Belegter Speicher: $used_disk_space"
echo "Gesamtgröße des Dateisystems: $total_filesystem_size"
echo "Systemlaufzeit: $uptime"
echo "Aktuelle Systemzeit: $current_time"

# Ausgabe in Datei schreiben
output_file="system.info"
echo "Hostname: $hostname" > "$output_file"
echo "Betriebssystemversion: $os_version" >> "$output_file"
echo "CPU-Modell: $cpu_model" >> "$output_file"
echo "Anzahl der CPU-Cores: $cpu_cores" >> "$output_file"
echo "Arbeitsspeicher (gesamt/genutzt): $total_memory/$used_memory" >> "$output_file"
echo "Verfügbarer Speicher: $available_disk_space" >> "$output_file"
echo "Freier Speicher: $free_disk_space" >> "$output_file"
echo "Belegter Speicher: $used_disk_space" >> "$output_file"
echo "Gesamtgröße des Dateisystems: $total_filesystem_size" >> "$output_file"
echo "Systemlaufzeit: $uptime" >> "$output_file"
echo "Aktuelle Systemzeit: $current_time" >> "$output_file"

echo "Die Informationen wurden im Terminal ausgegeben und in die Datei '$output_file' geschrieben."
