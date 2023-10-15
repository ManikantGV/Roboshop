
echo -e "\e[36m >>>>>>> disabling the default mysql >>>>>>>> \e[0m"
dnf module disable mysql -y
echo -e "\e[36m >>>>>>> installing the  mysql >>>>>>>> \e[0m"
dnf install mysql-community-server -y

echo -e "\e[36m >>>>>>> copying the default repo file >>>>>>>> \e[0m"
cp mqsql.conf /etc/yum.repos.d/mysql.repo

echo -e "\e[36m >>>>>>> Enable and stating the mysql >>>>>>>> \e[0m"
systemctl enable mysqld
systemctl start mysqld

echo -e "\e[36m >>>>>>> setting up the roboshop user >>>>>>>> \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1