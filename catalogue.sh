script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

print_head "Catalogue Script Initiating"

component=catalogue
db=mongo
nodejs

