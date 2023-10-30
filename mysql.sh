script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
    echo "input mysql password is missing"
    exit
fi

print_head "disabling the default mysql "
dnf module disable mysql -y &>>$log_file
stat_check $?

print_head "installing the  mysql "
dnf install mysql-community-server -y &>>$log_file
stat_check $?

print_head "copying the default repo file"
cp $script_path/mysql.conf /etc/yum.repos.d/mysql.repo &>>$log_file
stat_check $?

print_head "Enable and stating the mysql"
systemctl enable mysqld &>>$log_file
stat_check $?
systemctl start mysqld &>>$log_file
stat_check $?

print_head "setting up the roboshop user and password:RoboShop@1"
#mysql_secure_installation --set-root-pass RoboShop@1 &>>$log_file
mysql_secure_installation --set-root-pass $mysql_root_password &>>$log_file
stat_check $?

#print_head "reset mysql password"
#mysql -uroot -pRoboShop@1 &>>$log_file
#stat_check $?
