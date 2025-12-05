#!/bin/sh

echo -e "\033[32m  
Was moechtest du tun? \n 
(1)	Server/Channel starten
(2)	Server/Channel schliessen
(3)	Logs loeschen
(4)	Quests reloaden
(5)	Nichts
\033[0m"

read anzahl
case $anzahl in 

1*)
		cd /usr/home/game/Datenbank && ./db &
		sleep 3
		cd /usr/home/game/Channel1 && ./game &
		sleep 2
		cd /usr/home/game/Channel2 && ./game &
		sleep 2
		cd /usr/home/game/Channel3 && ./game &
		sleep 2
		cd /usr/home/game/Channel99 && ./game &
		sleep 2
		cd /usr/home/game/Loginserver  && ./game &
		sleep 2
		cd ..
;;

2*)
killall -1 db game
echo -e "\033[31m Der Server wurde heruntergefahren.\033[0m"
cd ..
;;

3*)
echo -e "\033[31m Loesche Logs...\033[0m"

rm -rvf /usr/home/game/logs/*/*


find /usr/home/game -name "syserr" -type f -delete
find /usr/home/game -name "syslog" -type f -delete
find /usr/home/game -name "stdout" -type f -delete
find /usr/home/game -name "mob_data.txt" -type f -delete
find /usr/home/game -name "p2p_packet_info.txt" -type f -delete
find /usr/home/game -name "packet_info.txt" -type f -delete
find /usr/home/game -name "pid" -type f -delete
find /usr/home/game -name "PTS" -type f -delete
find /usr/home/game -name "ver.txt" -type f -delete
find /usr/home/game -name "VERSION.txt" -type f -delete
find /usr/home/game -name "mob_count" -type f -delete
find /usr/home/game -name "game.core" -type f -delete
find /usr/home/game -name "db.core" -type f -delete
find /usr/home/game -name "usage.txt" -type f -delete
cd ..
echo -e "\033[31m Geloescht!\033[0m"
;;

4*)
cd /usr/home/game/share/quest && python make.py
cd ..
;;

5*)
cd ..
;;
esac
