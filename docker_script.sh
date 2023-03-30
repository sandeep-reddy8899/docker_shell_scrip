#!/bin/bash

R="/e[32m"
Y="/e[31m"
G="/e[33m"
N="/e[0m"

LOG=docker-install.log
USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
        echo -e "$R You are not the rrot user, you don'thave the permissions to run this $N"
        exit 1
fi
validate(){
    if [ $1 -ne 0 ]; then
        echo -e "$2.... $R FAILURE $N"
        exit 1 
    else
        echo "$2... $G SUCESS ra abbai $N" 
    fi
}

yum-update -y &>>LOG
validate $? " Updated packages"
