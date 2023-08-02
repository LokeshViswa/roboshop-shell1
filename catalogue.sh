script_location=$(pwd)

echo -e "\e[35m Install Nginx\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
yum install nodejs -y &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
useradd roboshop &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
mkdir -p /app &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
rm -rf /app/* &>>${LOG}

echo -e "\e[35m Install Nginx\e[0m"
cd /app

echo -e "\e[35m Install Nginx\e[0m"
unzip /tmp/catalogue.zip &>>${LOG}

cd /app

echo -e "\e[35m Install Nginx\e[0m"
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













