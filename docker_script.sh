#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG=docker-install.log
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
        echo -e "$R You are not the root user, you don'thave the permissions to run this $N"
        exit 1
fi
VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$2.... $R FAILURE $N"
        exit 1 
    else
        echo -e "$2... $G SUCESS ra abbai $N" 
    fi
}

yum update -y &>>$LOG
VALIDATE $? " Updated packages"

yum install docker -y &>>$LOG
VALIDATE $? "Docker insatlled"

service docker start &>>$LOG
VALIDATE $? "Stated docker"

systemctl enable docker &>>$LOG
VALIDATE $? "Enabling Docker"

usermod -a -G docker ec2-user &>>$LOG
VALIDATE $? "Added ec2-user to docker group"

yum install git -y &>>$LOG
VALIDATE $? "Installing GIT"

curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose &>>$LOG
VALIDATE $? "Downloaded docker-compose"

chmod +x /usr/local/bin/docker-compose
VALIDATE $? "Moved docker-compose to local bin"

echo  -e "$R You need logout and login to the server $N"
