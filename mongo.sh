echo -e "\e[36m >>>>>>> Copying the mongo config file >>>>>>>> \e[0m"
cp mongo.conf /etc/yum.repos.d/mongo.repo

echo -e "\e[36m >>>>>>> installing thr mongodb >>>>>>>> \e[0m"
dnf install mongodb-org -y

echo -e "\e[36m >>>>>>> enable and start mongo service  >>>>>>>> \e[0m"
systemctl enable mongod
systemctl start mongod

echo -e "\e[36m >>>>>>> changing the IP address 0.0.0.0 in mogod config file >>>>>>>> \e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/mongod.conf

echo -e "\e[36m >>>>>>> Restating the mongod service >>>>>>>> \e[0m"
systemctl restart mongod