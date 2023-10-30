script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "Catalogue Script Initiating"

component=catalogue

echo -e "\e[36m >>>>>>> copying the mongo repo and catalogue service >>>>>>>> \e[0m"

cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m >>>>>>> adding the roboshop user >>>>>>>> \e[0m"
useradd roboshop

print_head "creating the app folder "
rm -rf /app
mkdir /app

print_head "downloading the catalogue zip folder"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

print_head unzip catalogue.zip
unzip /tmp/catalogue.zip
cd /app

print_head "NPM installing"
npm install

print_head "enabling the catalogue service"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

print_head "Installing mongodb client"
dnf install mongodb-org-shell -y
cp mongo.conf /etc/yum.repos.d/mongo.repo

print_head "creating the catalogue schema"
mongo --host mongodb-dev.guntikadevops.online </app/schema/catalogue.js
print_head "Catalogue process completed "

