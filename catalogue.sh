script_location=$(pwd)
LOG=/tmp/roboshop.log

echo -e "\e[35m Configure NodeJS repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
exit
fi

echo -e "\e[35m Install NodeJS\e[0m"
yum install nodejs -y &>>${LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
exit
fi

echo -e "\e[35m Add Application User\e[0m"
useradd roboshop &>>${LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  echo "Refer Log file for more Information, LOG - ${LOG}"
exit
fi

mkdir -p /app &>>${LOG}

echo -e "\e[35m Downloading the App Content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
exit
fi

rm -rf /app/* &>>${LOG}
cd /app

echo -e "\e[35m Install Nginx\e[0m"
unzip /tmp/catalogue.zip &>>${LOG}

cd /app

echo -e "\e[35m Install npm\e[0m"
npm install &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
systemctl daemon-reload &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
systemctl enable catalogue &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
systemctl restart catalogue &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
cp ${script_location}/files/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
yum install mongodb-org-shell -y &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
mongo --host mongodb-dev.lokeshviswa44.online </app/schema/catalogue.js &>>${LOG}













