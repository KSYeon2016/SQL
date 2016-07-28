-- insert1
insert into AUTHOR values(1, '박경리', '토지 작가');

-- insert2
insert into AUTHOR(no, name) values(2, '이훈');
insert into AUTHOR(name, no) values('공자', 3);
select * from AUTHOR;

-- insert3
insert into book values(1, '토지', null, 1);
insert into book(no, title, author_no) values(2, '칼의노래', 2);
select * from BOOK;

-- insert4(sub query)
select 3, '논어', null, 3 from dual;
insert into book(select 3, '논어', null, 3 from dual);

commit;

-- update1
-- update BOOK set title = '토지3판', rate = 5, author_no = 3;
update BOOK set title = '토지3판', rate = 5, author_no = 3 where no = 1;
select * from BOOK;
rollback; -- commit한 데까지 적용
commit;

-- update2
select no from author where name = '박경리';
update BOOK 
  set rate = 5
  where author_no = (select no 
                      from author 
                      where name = '이훈');
commit;
select * from book;

-- delete1
delete from book where no = 3;
select * from book;
commit;

-- delete2
delete from book
  where author_no = (select no 
                      from author 
                      where name = '이훈');
select * from book;
commit;

-- pseudo column
select user from dual;