echo -e "\e[36m >>>>>>> Configuration nodeJS repos >>>>>>>> \e[0m"
sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1

echo -e "\e[36m >>>>>>> Creating the roboshop user >>>>>>>> \e[0m"
useradd roboshop

echo -e "\e[36m >>>>>>> Creating the app folder >>>>>>>> \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m >>>>>>> Downloading the app content >>>>>>>> \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app

echo -e "\e[36m >>>>>>> unzipping the app content >>>>>>>> \e[0m"
unzip /tmp/cart.zip
cd /app

echo -e "\e[36m >>>>>>> Install nodeJS dependencies >>>>>>>> \e[0m"
npm install

echo -e "\e[36m >>>>>>> copying the cart service >>>>>>>> \e[0m"
cp /root/Roboshop/cart.service /etc/systemd/system/cart.service

echo -e "\e[36m >>>>>>> start Cart service >>>>>>>> \e[0m"
systemctl daemon-reload
systemctl enable cart
systemctl restart cart




