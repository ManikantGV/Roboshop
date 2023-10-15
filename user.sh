sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1

cp mongo.conf /etc/yum.repos.d/mongo.repo
useradd roboshop

rm -rf /app
mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip

cd /app
npm install
systemctl daemon-reload
systemctl enable user
systemctl start user


dnf install mongodb-org-shell -y

mongo --host mongodb-dev.guntikadevops.online </app/schema/user.js
