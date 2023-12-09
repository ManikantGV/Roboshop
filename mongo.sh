script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "mongodb processing initiating "
print_head "Copying the mongo config file "
cp mongo.conf /etc/yum.repos.d/mongo.repo &>>$log_file
stat_check $?

print_head "installing thr mongodb"
dnf install mongodb-org -y &>>$log_file
stat_check $?

#print_head "enable and start mongo service"
#systemctl enable mongod &>>$log_file
#stat_check $?
#systemctl start mongod &>>$log_file
#stat_check $?

print_head "changing the IP address 0.0.0.0 in mogod config file"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf &>>$log_file
stat_check $?

print_head "Restating the mongod service"
systemctl enable mongod &>>$log_file
systemctl restart mongod &>>$log_file
stat_check $?

print_head "mongodb process Completed"