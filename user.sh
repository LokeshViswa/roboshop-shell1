source common.sh

print_head "Configuring NodeJS Repos"
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

mkdir /app &>>${LOG}


print_head "Downloading App Content"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${LOG}

print_head "Cleanup Old Content"
rm -rf /app/* &>>${LOG}
status_check

print_head "Extracting App Content"
cd /app
unzip /tmp/user.zip
status_check

print_head "Copy MongoDB Repo file"
cd /app
npm install &>>${LOG}
status_check

print_head "Copy MongoDB Repo file"
cp ${script_location}/files/user.service /etc/systemd/system/user.service &>>${LOG}
status_check

print_head "Copy MongoDB Repo file"
systemctl enable user &>>${LOG}
status_check

print_head "Copy MongoDB Repo file"
systemctl start user &>>${LOG}
status_check
