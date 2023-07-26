create table local(
	id int auto_increment primary key,
	lid varchar(20) not null,
	lname varchar(200) not null,
    laddress varchar(500),
    lphone varchar(30),
    lurl varchar(300),
    x varchar(100),
    y varchar(100),
    rdate datetime default now()
);

drop table local;

desc local;

select * from local;

delete from local where id>0;