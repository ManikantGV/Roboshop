#curl -sL https://rpm.nodesource.com/setup_lts.x | bash
sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1

dnf install nodejs -y

useradd roboshop

mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

systemctl daemon-reload

cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y

mongo --host mongodb-dev.guntikadevops.online </app/schema/catalogue.js