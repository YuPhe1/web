/* 데이터 베이스 사용 */
use webdb;

create table products(
	pcode int auto_increment primary key,
    pname varchar(100) not null,
    price int default 0,
    rdate datetime default now()
);

drop table products;

desc products;

insert into products(pcode, pname, price)
values(100, '냉장고', 3000000);
insert into products(pname, price)
values('세탁기', 2500000);
insert into products(pname, price)
values('스타일러', 1500000);

select *, format(price, 0) fprice, date_format(rdate, '%Y-%m-%d %T') fdate from products; 

insert into products(pname, price)
select pname, price from products;

select count(*) from products;

update products set pname='엘지전자 모니터', price=1000000
where pcode = 103;

delete from products
where pcode > 4;

select * from products order by pcode desc;
select * from products order by pcode desc limit 0,5;