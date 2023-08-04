source common.sh

print_head "Configure NodeJS repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
status_check

print_head "Configure NodeJS repos"
yum install nodejs -y
status_check

print_head "Configure NodeJS repos"
useradd roboshop
status_check

mkdir /app

print_head "Configure NodeJS repos"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip
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

