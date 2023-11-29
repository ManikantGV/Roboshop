script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_appuser_password=$1

print_head "rabbitMQ Script Initiating"
if [ -z "$rabbitmq_appuser_password" ]; then
    echo "Rabit Mq password is empty -- please enter roboshop123"
    exit 1
fi

print_head "Downloading the rabbitmq "
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$log_file
stat_check $?
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$log_file
stat_check $?

print_head "Installing the rabbitMQ"
dnf install rabbitmq-server -y &>>$log_file
stat_check $?

print_head "Enable and start the rabbitMQ server "
systemctl enable rabbitmq-server &>>$log_file
stat_check $?
systemctl start rabbitmq-server &>>$log_file
stat_check $?

#password -- roboshop123
print_head "Adding the roboshop user and permission"
rabbitmqctl add_user roboshop $rabbitmq_appuser_password &>>$log_file
stat_check $?
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log_file
stat_check $?