echo -e "\e[36m >>>>>>> Downloading the rabbitmq  >>>>>>>> \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[36m >>>>>>> Installing the rabbitMQ >>>>>>>> \e[0m"
dnf install rabbitmq-server -y

echo -e "\e[36m >>>>>>> Enable and start the rabbitMQ server >>>>>>>> \e[0m"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

echo -e "\e[36m >>>>>>> Adding the roboshop user and permission >>>>>>>> \e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"