script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "installing the nginx repo"
yum install nginx -y &>>$log_file
stat_check $?

print_head "copying roboshop config file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file
stat_check $?

print_head "enable and start nginx"
systemctl enable nginx &>>$log_file
stat_check $?
systemctl start nginx &>>$log_file
stat_check $?

print_head "removing the nginx config"
rm -rf /usr/share/nginx/html/* &>>$log_file
stat_check $?

print_head "Downloading the frontend app zip"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file
stat_check $?

print_head "Changing the directory"
cd /usr/share/nginx/html &>>$log_file
stat_check $?

print_head "unziping frontend zip folder"
unzip /tmp/frontend.zip &>>$log_file
stat_check $?

print_head "enable and restart nginx"
#some files needs to create
systemctl enable nginx &>>$log_file
stat_check $?
systemctl restart nginx &>>$log_file
stat_check $?
