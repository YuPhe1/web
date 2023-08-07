create database shopdb;

create user shop@localhost identified by 'pass';

grant all privileges on shopdb.* to shop@localhost;