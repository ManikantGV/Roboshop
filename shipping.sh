echo -e "\e[36m >>>>>>> installing mavin repos >>>>>>>> \e[0m"
dnf install maven -y

echo -e "\e[36m >>>>>>> copying the shopping config file >>>>>>>> \e[0m"
cp shipping.conf /etc/systemd/system/shipping.service

echo -e "\e[36m >>>>>>> Adding the roboshop user >>>>>>>> \e[0m"
useradd roboshop

echo -e "\e[36m >>>>>>> Creating the app folder >>>>>>>> \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m >>>>>>> Downloading the application zip file >>>>>>>> \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

echo -e "\e[36m >>>>>>> clenaing the maven package and routed out application >>>>>>>> \e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m >>>>>>> Enable starting the application >>>>>>>> \e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl start shipping

echo -e "\e[36m >>>>>>> Creating mysql schema >>>>>>>> \e[0m"
dnf install mysql -y
mysql -h mysql-dev.guntikadevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql
echo -e "\e[36m >>>>>>> Restarting the shipping >>>>>>>> \e[0m"
systemctl restart shipping