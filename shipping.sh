dnf install maven -y

cp shipping.conf /etc/systemd/system/shipping.service

useradd roboshop
rm -rf /app
mkdir /app

curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

systemctl daemon-reload

systemctl enable shipping
systemctl start shipping

dnf install mysql -y
mysql -h mysql-dev.guntikadevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

systemctl restart shipping