cd ~
echo "[client] \nuser=root \npassword=" > .my.cnf # необходимо вставить свой пароль
mysql < hw2.sql # файл hw2.sql нужно предварительно положить в домашнюю директорию
mysqldump example > example.sql
mysql sample < example.sql