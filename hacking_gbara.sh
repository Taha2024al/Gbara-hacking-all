#!/data/data/com.termux/files/usr/bin/bash

clear
figlet "GBARA TOOL" | lolcat
echo -e "\e[1;32m============================\e[0m"
echo -e "\e[1;33m      GBARA MULTI TOOL\e[0m"
echo -e "\e[1;36m   TELEGRAM: @gbaraex\e[0m"
echo -e "\e[1;32m============================\e[0m"
echo -e "[1] FULL WEBSITE SCANNER"
echo -e "[2] PASSWORD ATTACK"
echo -e "[3] HACKING GMAIL"
echo -e "[4] HACKING FACEBOOK"
echo -e "[5] HACKING INSTAGRAM"
echo -e "[6] HACKING WEBSITE"
echo -e "\e[1;32m============================\e[0m"

read -p $'\e[1;37m[?] Choose an option: \e[0m' option

if [ "$option" = "1" ]; then
    echo -e "\n\e[1;34m[+] Full Website Vulnerability Scanner\e[0m"
    read -p $'\e[1;37m[?] Enter full URL with parameter (e.g. https://site.com/page?id=1): \e[0m' url

    echo -e "\n\e[1;33m[*] Checking tools... (nuclei, dalfox, sqlmap)\e[0m"
    for tool in nuclei dalfox sqlmap; do
        if ! command -v $tool &> /dev/null; then
            echo -e "\e[1;31m[!] $tool not found. Installing...\e[0m"
            pkg install $tool -y || pip install $tool
        fi
    done

    echo -e "\n\e[1;36m[+] Running nuclei scan (general vulnerabilities)...\e[0m"
    echo "$url" | nuclei -t vulnerabilities/ -o gbara_nuclei.txt

    echo -e "\n\e[1;36m[+] Running dalfox scan (XSS detection)...\e[0m"
    echo "$url" | dalfox pipe --skip-mining -o gbara_xss.txt

    echo -e "\n\e[1;36m[+] Running sqlmap scan (SQL Injection)...\e[0m"
    sqlmap -u "$url" --batch --level=5 --risk=3 --threads=3 --random-agent | tee gbara_sqlmap.txt

    echo -e "\n\e[1;32m[✓] Scan completed. Results saved:\e[0m"
    echo -e "  - gbara_nuclei.txt"
    echo -e "  - gbara_xss.txt"
    echo -e "  - gbara_sqlmap.txt"

else
    echo -e "\n\e[1;31m❌ This tool is premium."
    echo -e "Please contact the developer: \e[1;36m@gbaraex\e[0m"
fi
