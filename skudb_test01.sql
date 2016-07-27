-- table list
select * from tab;

-- table scheme
desc book;

create table book(
  no       NUMBER,
  title    VARCHAR2(100),
  author   VARCHAR2(100),
  pub_date DATE
);

-- 예제 데이터 넣기
insert into book values(1, '논어', '공자', to_date('1918-10-10', 'yyyy-mm-dd'));
insert into book values(2, '토지', '박경리', to_date('1918-10-10', 'yyyy-mm-dd'));
insert into book values(3, '슬램덩크', '다케이코', to_date('1918-10-10', 'yyyy-mm-dd'));
select * from book;

-- 데이터를 넣으면서 테이블 생성하기 (테이블 백업)
create table book_temp
  as(select * from book);
select * from book_temp;

-- 테이블 변경 (칼럼 추가)
alter table book add(pubs VARCHAR2(200));
desc book;
select * from book;

-- 테이블 변경 (칼럼 수정)
alter table book MODIFY(pubs VARCHAR(500));
desc book;

-- 테이블 변경 (칼럼 삭제)
alter table book drop(pubs);

-- 테이블 변경 (칼럼 unused 설정)
alter table book set unused(author);
desc book;

-- 테이블 삭제
drop table book_temp;

-- 테이블 데이터 삭제
TRUNCATE table book;
select * from book;

-- comment 달기
COMMENT on table book is 'this is comment';
select * from user_tab_comments;

-- rename
rename book to article;
select * from article;

-- commit
insert into article values(1, '논어', to_date('1918-10-10', 'yyyy-mm-dd'));
insert into article values(2, '토지', to_date('1918-10-10', 'yyyy-mm-dd'));
insert into article values(3, '슬램덩크', to_date('1918-10-10', 'yyyy-mm-dd'));
commit;

-- constraint(제약조건) - not null
create table book(
  no       NUMBER        NOT NULL,
  title    VARCHAR2(100) not null,
  author   VARCHAR2(100),
  pub_date DATE
);

-- error
-- insert into book values(1, null, null, null);
-- insert into book values(1, '', null, null); mysql에선 허용
insert into book values(1, '논어', null, null);
select * from book;

-- constraint(제약조건) - unique
drop table book;
create table book(
  no       NUMBER        NOT NULL,
  title    VARCHAR2(100) not null,
  author   VARCHAR2(100),
  pub_date DATE,
  unique(no) -- or constraint c_book_uique unique(no)
);
insert into book values(1, '논어', '공자', sysdate);
insert into book values(1, '논어2', '공자', sysdate);
select * from book;

-- constraint(제약조건) - primary key = not null + unique
drop table book;
create table book(
  no       NUMBER        NOT NULL,
  title    VARCHAR2(100) not null,
  author   VARCHAR2(100),
  pub_date DATE,
  primary key(no)
);
insert into book values(1, '논어', '공자', sysdate);
insert into book values(1, '논어2', '공자', sysdate);
select * from book;

-- constraint(제약조건) - check
drop table book;
create table book(
  no       NUMBER        NOT NULL,
  title    VARCHAR2(100) not null,
  author   VARCHAR2(100),
  pub_date DATE,
  rate     NUMBER NOT NULL,
  primary key(no),
  check(rate in(1, 2, 3, 4, 5))
);
insert into book values(1, '논어', '공자', sysdate, 5);
insert into book values(2, '논어2', '공자', sysdate, 1);
select * from BOOK;

-- author table 생성
drop table author CASCADE CONSTRAINT;
create table author(
  no number,
  name varchar2(80) not null,
  description varchar2(2000),
  primary key(no)
);
insert into author values(1, '공자', '...');
select * from author;
  
-- constraint(제약조건) - Foreign Key(외래키)
drop table book CASCADE CONSTRAINT;
create table book(
  no       NUMBER,
  title    VARCHAR2(100) not null,
  pub_date DATE,
  rate     NUMBER NOT NULL,
  author_no NUMBER,
  primary key(no),
  check(rate in(1, 2, 3, 4, 5)),
  foreign key(author_no)
    references author(no) -- 삭제 시 에러
    on delete set null -- on delete set null pk 삭제 시 null로 세팅
                       -- on delete cascade pk 삭제 시 함께 삭제
);
insert into book values(1, '논어', sysdate, 5, 1);
insert into book values(2, '논어2', sysdate, 1, 1);
select * from BOOK;

-- Foreign key 삭제 시 문제점
delete from author where no = 1;

select object_name 
  from user_objects 
  where object_type = 'TABLE';
select constraint_name, constraint_type, search_condition 
  from user_constraints 
  where table_name = 'BOOK';