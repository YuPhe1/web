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
