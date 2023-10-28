source common.sh

#echo -e "\e[36m >>>>>>> installing the nginx repo >>>>>>>> \e[0m"
print_head "installing the nginx repo"
yum install nginx -y &>>$log_file


#echo -e "\e[36m >>>>>>> copying roboshop config file >>>>>>>> \e[0m"
print_head "copying roboshop config file"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>$log_file

#echo -e "\e[36m >>>>>>> enable and start nginx   >>>>>>>> \e[0m"
print_head "enable and start nginx"
systemctl enable nginx &>>$log_file
systemctl start nginx &>>$log_file

#echo -e "\e[36m >>>>>>> removing the nginx config >>>>>>>> \e[0m"
print_head "removing the nginx config"
rm -rf /usr/share/nginx/html/* &>>$log_file

#echo -e "\e[36m >>>>>>> Downloading the frontend app zip >>>>>>>> \e[0m"
print_head "Downloading the frontend app zip"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>$log_file

#echo -e "\e[36m >>>>>>> Changing the directory >>>>>>>> \e[0m"
print_head "Changing the directory"
cd /usr/share/nginx/html &>>$log_file

#echo -e "\e[36m >>>>>>> unziping frontend zip folder >>>>>>>> \e[0m"
print_head "unziping frontend zip folder"
unzip /tmp/frontend.zip &>>$log_file

#cho -e "\e[36m >>>>>>> enable and restart nginx >>>>>>>> \e[0m"
print_head "enable and restart nginx"
#some files needs to create
systemctl enable nginx &>>$log_file
systemctl restart nginx &>>$log_file

