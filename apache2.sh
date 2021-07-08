#!/bin/bash
#HORAINICIAL=$(date +%T)
#LOG="/var/log/$(echo $0 | cut -d'/' -f2)"
#echo -e "Início do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`" &>> $LOG
add-apt-repository universe &>> $LOG
add-apt-repository multiverse &>> $LOG
sudo rm /var/cache/debconf/config.dat
sudo rm -f /var/lib/dpkg/lock-frontend /var/lib/dpkg/lock /var/cache/apt/archives/lock &>> $LOG
rm /var/lib/dpkg/updates/0001 &>> $LOG
sudo dpkg --configure -a &>> $LOG
sleep 2;
sudo apt --fix-broken install -y  &>> $LOG
apt update &>> $LOG
apt -y install apache2
chown -v www-data.www-data /var/www/html/* &>> $LOG
sed -i '225 i ServerTokens ProductOnly' /etc/apache2/apache2.conf &>> $LOG
sed -i '226 i ServerSignature Off' /etc/apache2/apache2.conf &>> $LOG
systemctl restart apache2 &>> $LOG
netstat -an | grep '80'
#HORAFINAL=`date +%T`
#HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
#HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
#TEMPO=`date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S"`
#echo -e "Tempo gasto para execução do script $0: $TEMPO"
#echo -e "Fim do script $0 em: `date +%d/%m/%Y-"("%H:%M")"`" &>> $LOG
exit 1
