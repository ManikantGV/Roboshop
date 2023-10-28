
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