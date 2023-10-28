
logfile=/temp/roboshop.log
rm -f roboshop.log

function print_head() {
    echo -e "\e[36m>>>>>>>> $1 >>>>>>>>>>>>>>>\e[0m"
    echo -e "\e[36m>>>>>>>> $1 >>>>>>>>>>>>>>>\e[0m" &>>$logfile
}