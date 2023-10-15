echo -e "\e[36m >>>>>>> installing the nginx repo >>>>>>>> \e[0m"
yum install nginx -y

echo -e "\e[36m >>>>>>> copying roboshop config file >>>>>>>> \e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[36m >>>>>>> enable and start nginx   >>>>>>>> \e[0m"
systemctl enable nginx
systemctl start nginx

echo -e "\e[36m >>>>>>> removing the nginx config >>>>>>>> \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[36m >>>>>>> Downloading the frontend app zip >>>>>>>> \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[36m >>>>>>> Changing the directory >>>>>>>> \e[0m"
cd /usr/share/nginx/html

echo -e "\e[36m >>>>>>> unziping frontend zip folder >>>>>>>> \e[0m"
unzip /tmp/frontend.zip

echo -e "\e[36m >>>>>>> enable and restart nginx >>>>>>>> \e[0m"
#some files needs to create
systemctl enable nginx
systemctl restart nginx

