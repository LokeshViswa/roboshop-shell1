script_location=$(pwd)
LOG=/tmp/roboshop.log

status_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[1;32mSuccess\e[0m"
  else
    echo -e "\e[1;31mFailure\e[0m"
    echo "Refer Log file for more Information, LOG - ${LOG}"
    exit
  fi
}

print_head () {
  echo -e "\e[1m $1 \e[0m"
}

NODEJS() {
  print_head "Configure NodeJS repos"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
  status_check

  print_head "Install NodeJS"
  yum install nodejs -y &>>${LOG}
  status_check

  print_head "Add Application User"
  id roboshop &>>${LOG}
  if [ $? -ne 0 ]; then
    useradd roboshop &>>${LOG}
  fi
  status_check

  mkdir -p /app &>>${LOG}

  print_head "Downloading the App Content"
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
  status_check

  print_head "Clean Up Old Content"
  rm -rf /app/* &>>${LOG}
  status_check

  print_head "Extracting App Content"
  cd /app
  unzip /tmp/${component}.zip &>>${LOG}
  status_check

  print_head "Installing NodeJS Dependencies"
  cd /app
  npm install &>>${LOG}
  status_check

  print_head "Configuring ${component} Service File"
  cp ${script_location}/files/${component}.service /etc/systemd/system/catalogue.service &>>${LOG}
  status_check

  print_head "Reload SystemD"
  systemctl daemon-reload &>>${LOG}
  status_check

  print_head "Enable ${component} Service"
  systemctl enable ${component} &>>${LOG}
  status_check

  print_head "Start ${component} service"
  systemctl start ${component} &>>${LOG}
  status_check

  if [ ${schema_load} == "true" ]; then
    print_head "Configuring Mongo Repo"
    cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}
    status_check

    print_head "Install Mongo Client"
    yum install mongodb-org-shell -y &>>${LOG}
    status_check

    print_head "Load Schema"
    mongo --host mongodb-dev.lokeshviswa44.online </app/schema/${component}.js &>>${LOG}
    status_check
  fi
}
