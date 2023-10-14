curl -sL https://rpm.nodesource.com/setup_lts.x | bash

dnf install nodejs -y

useradd roboshop

mkdir /app

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

cd /app
npm install

systemctl daemon-reload
