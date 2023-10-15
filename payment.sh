echo -e "\e[36m >>>>>>> C >>>>>>>> \e[0m"
dnf install python36 gcc python3-devel -y

echo -e "\e[36m >>>>>>> copying the payment config file >>>>>>>> \e[0m"
cp payment.conf /etc/systemd/system/payment.service

echo -e "\e[36m >>>>>>> Creating the roboshop user >>>>>>>> \e[0m"
useradd roboshop

echo -e "\e[36m >>>>>>> Creating the app directory >>>>>>>> \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m >>>>>>> download the payment zip file >>>>>>>> \e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app

echo -e "\e[36m >>>>>>> unzip payment app file >>>>>>>> \e[0m"
unzip /tmp/payment.zip

#cd /app
echo -e "\e[36m >>>>>>> pip install the requirements >>>>>>>> \e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[36m >>>>>>> enable and start the payment >>>>>>>> \e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl start payment