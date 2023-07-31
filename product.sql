
SELECT count(*) FROM products where pname like '%%';

SELECT * FROM products where pname like '%냉장고%' order by pcode desc limit 0, 5;

desc products;
 
select count(*) c from products;

select * from products order by pcode desc;

select * from products order by pcode desc limit 0,5;

update products set pname='삼성 모니터', price=350000
where pcode > 450 and pname = '냉장고';