
echo -e "\e[36m >>>>>>> Downloading and installing the nodes repo >>>>>>>> \e[0m"
sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1

echo -e "\e[36m >>>>>>> copying the mongod and user.service config files >>>>>>>> \e[0m"
cp mongo.conf /etc/yum.repos.d/mongo.repo
cp user.conf /etc/systemd/system/user.service

echo -e "\e[36m >>>>>>> Creating the roboshop user >>>>>>>> \e[0m"
useradd roboshop

echo -e "\e[36m >>>>>>> Creating the app folder >>>>>>>> \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m >>>>>>> downloading user.zip >>>>>>>> \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m >>>>>>> unzip user.zp >>>>>>>> \e[0m"
unzip /tmp/user.zip

echo -e "\e[36m >>>>>>> NPM installing >>>>>>>> \e[0m"
#cd /app
npm install

echo -e "\e[36m >>>>>>> enable and starting the user service >>>>>>>> \e[0m"
systemctl daemon-reload
systemctl enable user
systemctl start user


dnf install mongodb-org-shell -y

mongo --host mongodb-dev.guntikadevops.online </app/schema/user.js
