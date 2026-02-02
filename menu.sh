#!/bin/bash
# MATS-Software-Labs v1.3 - Matrix Edition (Clean)
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # Standard-Grau

# --- UNTERMENÜ FUNKTION ---
show_extra_tools() {
    while true; do
        clear
        echo -e "${GREEN}==========================================${NC}"
        echo -e "${GREEN}    🛠️ MATS-LABS EXTRA TOOLS v1.3 🛠️    ${NC}"
        echo -e "${GREEN}==========================================${NC}"
        echo -e "1) 🧹 Müll weg (Cache & Logs clean)"
        echo -e "2) 🚀 (In Entwicklung - Coming Soon)"
        echo -e "3) 🖕 Admin-Status (Secret Check)"
        echo -e "4) Zurück zum Hauptmenü"
        echo -e "${GREEN}==========================================${NC}"
        read -p "Wähle ein Tool (1-4): " tool_choice

        case $tool_choice in
            1)
                echo "--- Bereinige System-Müll ---"
                sudo apt-get clean && sudo pihole -cc
                echo -e "${GREEN}System-Müll wurde eliminiert! ✅${NC}"
                sleep 2 ;;
            2)
                echo -e "${RED}Dieses Modul wird gerade in der Werkstatt überarbeitet...${NC}"
                sleep 2 ;;
            3)
                echo -e "${RED}"
                echo "       .---. "
                echo "      |  _  | "
                echo "      | |_| | "
                echo "      |     | "
                echo "   _  |  _  | "
                echo "  | |_| |_| |"
                echo "  |         |"
                echo "  |_________|"
                echo -e "\n   MATS-LABS sagt: FUCK OFF! 🖕${NC}"
                sleep 3 ;;
            4) break ;; 
        esac
    done
}

# --- HAUPTMENÜ SCHLEIFE ---
while true; do
    clear
    TEMP=$(vcgencmd measure_temp | cut -d "=" -f2) # Echtzeit-Temp Check
    
    echo -e "${GREEN}==========================================${NC}"
    echo -e "${GREEN}    🚀 JUSTUS PI-CONTROL-CENTER v1.3 🚀    ${NC}"
    echo -e "${GREEN}    CPU-TEMP: $TEMP | MODE: GOD MODE     ${NC}"
    echo -e "${GREEN}==========================================${NC}"
    echo -e "1) Pi-hole Status prüfen"
    echo -e "${GREEN}2) Live-Matrix starten (DNS Log)${NC}"
    echo -e "${RED}3) Bild.de & Speedtest freischalten${NC}"
    echo -e "4) Internet-Wachhund manuell testen"
    echo -e "5) System-Update (Neutrinos jagen)"
    echo -e "${GREEN}6) 🤖 KI-FIREWALL & HARDWARE (GOD MODE)${NC}"
    echo -e "7) 🛠️ EXTRA TOOLS (Sub-Menu)"
    echo -e "8) Beenden"
    echo -e "${GREEN}==========================================${NC}"
    read -p "Was willst du tun, Boss? (1-8): " choice

    case $choice in
        1) sudo pihole status; read -p "Enter..." ;;
        2) sudo pihole -t ;;
        3) 
            sudo pihole -w bild.de www.bild.de speedtest.net www.speedtest.net
            echo -e "${RED}Whitelist aktualisiert! ✅${NC}"
            sleep 2 ;;
        4) /home/justin/reconnect.sh; read -p "Fertig. Enter..." ;;
        5) sudo pihole -up; read -p "Fertig. Enter..." ;;
        6) 
            echo -e "${GREEN}Aktiviere God Mode...${NC}"
            echo -ne "${GREEN}[####################] (100%)${NC}\n"
            echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
            # Die legendären 2.500.000 Buffer bleiben natürlich drin!
            sudo sysctl -w net.core.rmem_max=2500000
            sudo sysctl -w net.core.wmem_max=2500000
            echo -e "${RED}--- KI-FIREWALL SCHARF GESCHALTET ---${NC}"
            sudo tail -f /var/log/pihole/FTL.log | while read line; do
                if [[ $line == *"eval("* ]] || [[ $line == *"unescape("* ]]; then
                    domain=$(echo $line | awk '{print $4}')
                    echo -e "${RED}[!] KI-ALARM: $domain geblockt! 🛡️${NC}"
                    sudo pihole -b $domain
                fi
            done ;;
        7) show_extra_tools ;;
        8) echo "Imperium gesichert. 🤘"; exit ;;
        *) echo -e "${RED}Fehler! 🤣🤣🤣${NC}"; sleep 1 ;;
    esac
done
