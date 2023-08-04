source common.sh

print_head "Configure NodeJS repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
status_check

print_head "Install NodeJS"
yum install nodejs -y
status_check

print_head "Add Application User"
id roboshop &>>${LOG}
if [ $? -ne 0 ]; then
  useradd roboshop &>>${LOG}
fi
status_check

mkdir /app &>>${LOG}

print_head "Downloading App Content"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
status_check

print_head "Cleanup Old Content"
rm -rf /app/* &>>${LOG}
status_check

print_head "Extracting App Content"
cd /app
unzip /tmp/cart.zip &>>${LOG}
status_check


cd /app

print_head "Configure NodeJS repos"
npm install
status_check

print_head "Configure NodeJS repos"
cp ${script_location}/files/cart.service /etc/systemd/system/cart.service &>>${LOG}
status_check

print_head "Configure NodeJS repos"
systemctl daemon-reload
status_check

print_head "Configure NodeJS repos"
systemctl enable cart
status_check

print_head "Configure NodeJS repos"
systemctl start cart
status_check

