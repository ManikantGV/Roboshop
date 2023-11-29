
script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

print_head "Shipping Script Initiating"
#password -- RoboShop@1
if [ -z "$mysql_root_password" ]; then
    echo mysql password is empty
    exit 1
fi

component=shipping
db=mysql
shipping

