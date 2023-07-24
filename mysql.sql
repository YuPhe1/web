/* 데이터 베이스 생성 삭제*/
create database webdb;
drop database webdb;

/* 유저 생성 삭제 */
create user web@localhost identified by 'pass';
drop user web@localhost;

/* 유저에게 권한 부여 */
grant all privileges on webdb.* to web@localhost;