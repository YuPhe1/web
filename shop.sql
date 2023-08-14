use shopdb;
/* 상품테이블 */
create table goods(
	gid char(8) not null primary key,
    title varchar(300) not null,
    price int default 0,
    maker varchar(300),
    image varchar(500),
    regDate datetime default now()
);

desc goods;

select count(*) from goods;

select * from goods;

/* 사용자 테이블 */
create table users(
	uid varchar(20) not null primary key,
    upass varchar(200) not null,
    uname varchar(20) not null,
    phone varchar(20),
    address1 varchar(300),
    address2 varchar(300),
	regDate datetime default now(),
    photo varchar(200)
);

desc users;


/* 구매자 정보 테이블 */
create table purchase(
	pid char(13) not null primary key,
    uid varchar(20) not null,
	raddress1 varchar(300),
    raddress2 varchar(300),
    rphone varchar(20),
    purDate datetime default now(),
    status int default 0,	/*주문상태 0:상품준비중, 1:배송준비중, 2:배송완료, 3:구매확정*/
    purSum int default 0,	/*주문총액*/
	foreign key(uid) references users(uid)
);
/*주문상품테이블*/
create table orders(
	oid int auto_increment primary key,
    pid char(13) not null,
    gid char(8) not null,
    price int default 0,
    qnt int default 0,
    foreign key(pid) references purchase(pid),
    foreign key(gid) references goods(gid)
);

insert into users(uid, upass, uname, phone, address1, address2)
values('blue', 'pass', '최블루', '010-1010-1010', '인천서구 청라3동', '디이스트 215-1801');
insert into users(uid, upass, uname, phone, address1, address2)
values('pink', 'pass', '이핑크', '010-1010-2020', '인천 부평구 계산동', '현대 612-604');

select * from users;

select count(*) from purchase;

select * from orders;

create view view_purchase as
select p.*, u.uname
from purchase p ,users u
where p.uid = u.uid;

create view view_orders as
select o.*,title, image
from orders o , goods g 
where o.gid = g.gid;

select * from view_orders;
alter table users add role int default 2;
select * from users;

insert into users(uid, upass, uname, role)
values('manager', 'pass', '관리자', 1);

create table reviews(
	rid int auto_increment primary key,
    uid varchar(20) not null,
    gid char(8) not null,
    revDate datetime default now(),
    content text,
    foreign key(uid) references users(uid),
    foreign key(gid) references goods(gid)
);

drop table reviews;
desc reviews;

select count(*) from reviews;

create view view_reviews as
select r.*, u.uname, u.photo
from reviews r, users u
where r.uid = u.uid;

select * from view_reviews;

create table favorite(
	gid char(8) not null,
	uid varchar(20) not null,
    regDate datetime default now(),
    primary key(gid, uid),
    foreign key(uid) references users(uid),
    foreign key(gid) references goods(gid)
);

insert into favorite(gid, uid)
values('85abd749','black');

select * from favorite;

create view view_goods as
select * , (select count(*) from reviews where gid=g.gid) rcnt,
(select count(*) from favorite where gid=g.gid) fcnt
from goods g
order by regDate desc;

select *, (select count(*) from favorite where gid=g.gid and uid='blue') ucnt from view_goods g;

select count(*) ucnt from favorite where gid = '85abd749' and  uid = 'black';

select count(*) fcnt,
 (select count(*) ucnt from favorite where gid = '85abd749' and  uid = 'black') ucnt
 from favorite
 where gid = '85abd749';