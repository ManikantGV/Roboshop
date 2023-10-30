script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "disabling the default mysql "
dnf module disable mysql -y &>>$log_file
print_head "installing the  mysql "
dnf install mysql-community-server -y &>>$log_file

print_head "copying the default repo file"
cp mysql.conf /etc/yum.repos.d/mysql.repo &>>$log_file

print_head "Enable and stating the mysql"
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file

print_head "setting up the roboshop user"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file

print_head "Check the password"
mysql -uroot -pRoboShop@1 &>>$log_file
