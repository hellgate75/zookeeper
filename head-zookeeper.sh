#!/bin/bash
FLAG_ZOOKEEPER="$(status-zookeeper)"

   echo '                                     ____' \
&& echo '                                    |  _ \            _   _  ' \
&& echo '                                    | | | | ___  ___ | | / /___  _  __' \
&& echo '                                    | | | |/ _ \/  _|| |/ // _ \| |/ _|' \
&& echo '                                    | |_| | (_) | |__| |\ \  __||  ꜥ' \
&& echo '                                    |____/ \___/\___/|_| \_\___||__|' \
&& echo "" \
&& echo '\$$$$$$$$$$/                           __    __' \
&& echo ' \$$$$$$$$/                           |$$|  /$$/   ______      ______     ______      ______    __  ____' \
&& echo '     /$$/       /$$$$$$     /$$$$$$   |$$| /$$/   /$$$$$$\    /$$$$$$\   /$$$$$$\    /$$$$$$\  |$$|/$$$$|' \
&& echo '    /$$/       /$$__  $$   /$$__  $$  |$$|/$$/   /$$___/$$|  /$$___/$$| |$$|  |$$|  /$$___/$$| |$$$$$/' \
&& echo '   /$$/       | $$  \ $$| | $$  \ $$| |$$$$/    |$$$$$$$$$| |$$$$$$$$$| |$$|  |$$| |$$$$$$$$|  |$$/' \
&& echo '  /$$/        | $$    $$| | $$    $$| |$$|\$$\  |$$\   ___  |$$\  __    |$$| /$$/  |$$\   __   |$$|' \
&& echo ' /$$$$$$$$$$| | $$$$$$$$| | $$$$$$$$| |$$| \$$\  \$$|_|$$/   \$$|_|$$/  |$$$___/    \$$|_|$$/  |$$|' \
&& echo ' \          /  \_______/   \_______/  |  |  \  \  \_____/     \_____/   |$$|         \_____/   |  |' \
&& echo '                                                                        |$$|' \
&& echo '                                                                        |  |' \
&& echo '' \
&& echo "" \
&& echo "Zookeeper (v. $ZOOKEEPER_RELEASE)" \
&& echo ""
echo "" \
&& echo "Zookeeper status : $FLAG_ZOOKEEPER" \
&& echo "" \
&& echo "" \
&& echo "Zookeeper is a service : service zookeeper help" \
&& echo "                         For further available commands" \
&& echo ""
if [[ "-s" != "$1" ]]; then
  echo -e "\nApache Zookeeper v. $ZOOKEEPER_RELEASE ports : \n"
  netstat -anp
fi
