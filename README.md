# Roboshop

1. Frontend.sh -- deploying the frontend.sh
2. 

How the following command  works "&>>$log_file"

1. The & operator is used to combine stdout and stderr into a single stream, so both the normal output and error messages will be redirected to the same file.
2. ">>" is a redirection operator that appends the combined output to the specified file, which is represented by the variable $logfile.
3. So, any command that is executed after this line will have its standard output and standard error appended to the file represented by $logfile. This can be helpful for capturing both regular program output and error messages in a single log file for debugging or auditing purposes.

" if [ $1 -eq 0 ] "
    
1. "$1" represents the first command-line argument passed to the script. This is typically a number.
2. "-eq" is the numeric equality operator. It checks if the value of $1 is equal to zero.

 script=$(realpath "$0")

 script_path=$(dirname "$script")

 source ${script_path}/common.sh

1. script=$(realpath "$0"):
    "$0" represents the name of the currently running script.
realpath is a command used to resolve the full path of a file, which in this case, is the current script.
script is a variable that will store the full, absolute path to the currently running script.
script_path=$(dirname "$script"):

2. dirname is a command that extracts the directory portion of a file path.
$script contains the full path to the script, and this line extracts the directory part of that path.
script_path is a variable that will store the directory path of the currently running script.
source ${script_path}/common.sh:

3. source is used to execute the content of another script within the current script, as if the contents of "common.sh" were part of the current script.
${script_path}/common.sh is the full path to the "common.sh" script file. The ${} notation is used to substitute the value of script_path into the path.

