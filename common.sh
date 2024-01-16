app_user=roboshop
script=$(realpath "$0")
script_path=$(dirname "$script")
log_file=/tmp/roboshop.log
rm -f $log_file
#if [ -z $log_file ]; then
 # rm -f $log_file
#fi


function print_head() {
    echo -e "\e[36m>>>>>>>> $1 >>>>>>>>>>>>>>>\e[0m"
    echo -e "\e[36m>>>>>>>> $1 >>>>>>>>>>>>>>>\e[0m" &>>$log_file
}

function stat_check() {
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m >>>>>> SUCCESS >>>>>>>> \e[0m"
    else
      echo -e "\e[31m >>>>>> Failure >>>>>>>> \e[0m"
      echo "Refer the log file /tmp/roboshop.log for more information"
    fi
}

#mongodb client config
function schema_setup() {
    if [ "${db}" == "mongo" ]; then

    print_head "Copy Mongo config file "
    cp ${script_path}/mongo.conf /etc/yum.repos.d/mongo.repo &>>$log_file
    stat_check $?

    print_head "Installing mongodb client"
    dnf install mongodb-org-shell -y &>>$log_file
    stat_check $?

    print_head "Load schema"
    mongo --host mongodb-dev.guntikadevops.online </app/schema/${component}.js &>>$log_file
    stat_check $?

    fi
    if [ "${db}" == "mysql" ]; then
      print_head "Creating mysql schema"
      dnf install mysql -y &>>$log_file
      stat_check $?

      print_head "Load schema"
      #mysql -h mysql-dev.guntikadevops.online -uroot -p${mysql_root_password} < /app/schema/shipping.sql &>>$log_file.
      mysql -h mysql-dev.guntikadevops.online -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>$log_file
      stat_check $?
    fi
}

function app_prereq() {

    id $app_user &>>$log_file
    if [ $? -ne 0 ]; then
      print_head "adding the roboshop user "
      useradd $app_user &>>$log_file
    fi
    stat_check $?

    print_head "creating the app folder "
    rm -rf /app &>>$log_file
    stat_check $?
    mkdir /app &>>$log_file
    stat_check $?

    print_head "downloading the catalogue zip folder"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$log_file
    stat_check $?
    cd /app &>>$log_file
    stat_check $?

    print_head "Extract application"
    unzip /tmp/${component}.zip &>>$log_file
    #cd /app

}

function systemd() {

        print_head "copying component the service "
        cp ${script_path}/${component}.service /etc/systemd/system/${component}.service &>>$log_file
        stat_check $?

        print_head "enabling the catalogue service"
        systemctl daemon-reload &>>$log_file
        stat_check $?
        systemctl enable ${component} &>>$log_file
        stat_check $?
        systemctl restart ${component} &>>$log_file
        stat_check $?

}

# nodejs repo installation
function nodejs() {
  print_head "Installing the nodejs"
  sudo yum install https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y &>>$log_file
  stat_check $?

  #sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1 &>>$log_file
  sudo yum install nodejs -y  &>>$log_file
  stat_check $?

  app_prereq

  print_head "NPM installing"
  npm install &>>$log_file
  stat_check $?

  schema_setup
  systemd

}

function redis() {

    print_head "Installing the redis server "
    dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>$log_file
    stat_check $?

    print_head "enabling the redis servier"
    dnf module enable redis:remi-6.2 -y &>>$log_file
    stat_check $?

    print_head "Installing the redis server"
    dnf install redis -y &>>$log_file
    stat_check $?

    print_head "changing the ip address 0.0.0.0 in redis.conf "
    sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/redis.conf  /etc/redis/redis.conf &>>$log_file
    stat_check $?

    print_head "Enable and start the redis server"
    systemctl enable redis &>>$log_file
    stat_check $?
    systemctl restart redis &>>$log_file
    stat_check $?
}

function shipping() {

    print_head "installing mavin repos"
    dnf install maven -y  &>>$log_file
    stat_check $?

    app_prereq

    print_head "clenaing the maven package and routed out application "
    mvn clean package  &>>$log_file
    stat_check $?
    mv target/${component}-1.0.jar ${component}.jar  &>>$log_file
    stat_check $?

    schema_setup
    systemd
}

function python() {

    print_head "Python installing "
    dnf install python36 gcc python3-devel -y &>>$log_file
    stat_check $?

    app_prereq

    print_head "pip install the requirements "
    pip3 install -r requirements.txt &>>$log_file
    stat_check $?

    systemd

}

function golang() {
    print_head "Installing the golang repo"
    dnf install golang -y &>>$log_file
    stat_check $?
    app_prereq

    echo -e "\e[36m >>>>>>> building the golang dispatch app >>>>>>>> \e[0m"
    go mod init dispatch &>>$log_file
    stat_check $? &>>$log_file
    go get
    stat_check $? &>>$log_file
    go build
    stat_check $? &>>$log_file

    systemd
}