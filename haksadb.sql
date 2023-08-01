create database haksadb;

create user haksa@localhost identified by 'pass';

grant all privileges on haksadb.* to haksa@localhost;