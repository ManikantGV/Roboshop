echo -e "\e[36m >>>>>>> Installing the redis server >>>>>>>> \e[0m"
dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[36m >>>>>>> enabling the redis servier >>>>>>>> \e[0m"
dnf module enable redis:remi-6.2 -y

echo -e "\e[36m >>>>>>> Enabling the redis server >>>>>>>> \e[0m"
dnf install redis -y

echo -e "\e[36m >>>>>>> changing the ip address 0.0.0.0 in redis.conf >>>>>>>> \e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf

echo -e "\e[36m >>>>>>> Enable and start the redis server >>>>>>>> \e[0m"
systemctl enable redis
systemctl start redis