#curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[36m >>>>>>> Installing the nodejs >>>>>>>> \e[0m"
sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1

#dnf install nodejs -y
echo -e "\e[36m >>>>>>> copying the mongo repo and catalogue service >>>>>>>> \e[0m"
cp mongo.conf /etc/yum.repos.d/mongo.repo
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m >>>>>>> adding the roboshop user >>>>>>>> \e[0m"
useradd roboshop

echo -e "\e[36m >>>>>>> creating the app folder >>>>>>>> \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m >>>>>>> downloading the catalogue zip folder >>>>>>>> \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

echo -e "\e[36m >>>>>>> unzip catalogue.zop >>>>>>>> \e[0m"
unzip /tmp/catalogue.zip

##cd /app
echo -e "\e[36m >>>>>>> NPM installing >>>>>>>> \e[0m"
npm install

echo -e "\e[36m >>>>>>> enabling the catalogue service >>>>>>>> \e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[36m >>>>>>> Installing mongodb client >>>>>>>> \e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[36m >>>>>>> creating the catalogue schema >>>>>>>> \e[0m"
mongo --host mongodb-dev.guntikadevops.online </app/schema/catalogue.js

