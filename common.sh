
log_file=/tmp/roboshop.log
#rm -f roboshop.log
if [ -z $log_file ]; then
  rm -f $log_file
fi



function print_head() {
    echo -e "\e[36m>>>>>>>> $1 >>>>>>>>>>>>>>>\e[0m"
    echo -e "\e[36m>>>>>>>> $1 >>>>>>>>>>>>>>>\e[0m" &>>log_file
}