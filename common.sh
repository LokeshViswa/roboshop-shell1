script_location=$(pwd)
LOG=/tmp/roboshop.log

status_check() {
  if [ $? -eq 0 ]; then
    print_head "\e[1;31mSuccess"
  else
    print_head "\e[1;31mFailure"
    echo "Refer Log file for more Information, LOG - ${LOG}"
  exit
  fi
}

print_head () {
  print_head "\e[1m $1 "



}