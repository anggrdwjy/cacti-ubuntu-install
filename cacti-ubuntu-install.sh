#!/bin/bash
#===============================================================#
# Script Name   : cacti-ubuntu-install                          #
# Description   : Script Install Cacti on Ubuntu	              #
# Author        : Anggarda Saputra Wijaya                       #
# Github        : https://github.com/anggrdwjy.                 #
#===============================================================#
again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]] ; do
clear   
echo "   __________________________________________________	";                                                            
echo "                                                	      	";
echo "   Options List :                                		";
echo "   1) Install Cacti Fastmode        			";
echo "   2) Install Cacti Weathermap        			";
echo "   3) Reboot Server	                   		";
echo "   4) Exit		                      		";
echo "   __________________________________________________   	";
echo "                                                          ";
read -p "   Enter a number the options listed: " choice;
echo "                                                        	";
case $choice in              

1) read -p "   Install Cacti Fastmode ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   sudo apt install unzip fping apache2 -y
   systemctl enable --now apache2
   sudo apt install php php-{mysql,curl,net-socket,gd,intl,pear,imap,memcache,pspell,tidy,xmlrpc,snmp,mbstring,gmp,json,xml,common,ldap} -y
   sudo apt install libapache2-mod-php
   mv /etc/php/*/apache2/php.ini /etc/php/*/apache2/php.ini.bak
   cp support/apache2/php.ini /etc/php/*/apache2/php.ini
   sudo apt install mariadb-server mariadb-client-compat -y
   systemctl enable --now mariadb
   sudo apt update
   echo -n "Username Database Cacti : ";
   read usercacti
   echo -n "Password Database Cacti : ";
   read passcacti
   mysql -e "CREATE DATABASE cacti DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
   mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO '$usercacti'@'localhost' IDENTIFIED BY '$passcacti';"
   mysql -e "GRANT SELECT ON mysql.time_zone_name TO cacti@localhost;"
   mysql -e "ALTER DATABASE cacti CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   mysql -e "FLUSH PRIVILEGES;"
   sudo clear
   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
   systemctl restart apache2
   sudo apt install snmp snmpd rrdtool -y
   sudo apt install git -y
   git clone https://github.com/Cacti/cacti.git
   mv cacti /var/www/html/cacti
   mysql -u root cacti < /var/www/html/cacti/cacti.sql
   chown -R www-data:www-data /var/www/html/cacti
   cp support/cactid.service /etc/systemd/system/cactid.service
   touch /etc/default/cactid
   systemctl --now enable cactid
   systemctl daemon-reload
   echo "                                                  ";
   echo "   ======== Cacti Success Installing Done ======== 	   ";
   echo "                                                  ";
   fi
   ;;

2) read -p "   Install Cacti Weathermap ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   git clone https://github.com/Cacti/plugin_weathermap.git
   mv plugin_weathermap/ /var/www/html/cacti/plugins/weathermap/
   chmod -R 777 /var/www/html/cacti/plugins/weathermap/
   cp support/weathermap/config.php /var/www/html/cacti/plugins/weathermap/config.php
   chown -R www-data:www-data /var/www/html/cacti/plugins/weathermap/configs
   echo "                                                  ";
   echo "   ======== Weathermap Done Integration ========	   ";
   echo "                                                  ";
   fi
   ;;

3) read -p "   Reboot Your Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   reboot
   fi
   ;;
   
4) exit
   ;;

*)    echo "Sorry, Your Choice Not Available"
esac
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo " Variable Not Available in Menu ";
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
done
done 

