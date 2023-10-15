echo -e "\e[36m >>>>>>> Installing the golang repo >>>>>>>> \e[0m"
dnf install golang -y

echo -e "\e[36m >>>>>>> copying the dispatch config file >>>>>>>> \e[0m"
cp dispatch.conf /etc/systemd/system/dispatch.service

echo -e "\e[36m >>>>>>> adding the roboshop user >>>>>>>> \e[0m"
useradd roboshop

echo -e "\e[36m >>>>>>> Creating the app user >>>>>>>> \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m >>>>>>> Downloading the dispatch application zip >>>>>>>> \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app

echo -e "\e[36m >>>>>>> unzip dispatch application >>>>>>>> \e[0m"
unzip /tmp/dispatch.zip

#cd /app
echo -e "\e[36m >>>>>>> building the golang dispatch app >>>>>>>> \e[0m"
go mod init dispatch
go get
go build

echo -e "\e[36m >>>>>>> Enabling and restarting the dispatch service >>>>>>>> \e[0m"
systemctl daemon-reload
systemctl enable dispatch
systemctl start dispatch