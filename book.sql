create table books(
	seq int auto_increment primary key,
    title varchar(200) not null,
    thumbnail varchar(200),
    price int default 0,
    pdate varchar(20),
    authors varchar(100),
    url varchar(300),
    isbn varchar(100),
    contents text,
    rdate datetime default now(),
    publisher varchar(100)
);

drop table books;
desc books;

select * from books;

alter table books modify column url varchar(300);

select count(*) from books;