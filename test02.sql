-- 대소문자 변환
select LOWER('Database System') from dual;
select UPPER('Database System') from dual;
select INITCAP('database system') from dual;

-- 문자열 조작
select concat('data', 'base') from dual;
select 'data' || 'base' from dual;
select substr('database', 2, 5) from dual;
select LENGTH('database') from dual;
select instr('Database', 'ba') from dual;
select first_name, LPAD(salary, 10, '*') from EMPLOYEES;
select first_name, RPAD(salary, 10, '*') from EMPLOYEES;
select trim('#' from '#####database#######') from dual;
select trim(' ' from '     database      ') from dual;

-- 숫자 함수
select ABS(-20000) from dual;
select floor(2.65) from dual;
select ceil(2.15) from dual;
select power(2, 10) from dual;
select trunc(3.145677, 3)  from dual;

-- date 함수
select first_name, hire_date from EMPLOYEES;  -- 데이트 타입은 스트링이 아님. 보여줄 때 스트링으로 변환
select value from nls_session_parameters where PARAMETER = 'NLS_DATE_FORMAT'; -- 포맷 확인
select first_name, to_char(hire_date, 'yyyy-mm-dd pm hh24:mi:ss') from EMPLOYEES;
select first_name, to_char(hire_date, 'yyyy-mm-dd') from EMPLOYEES
  WHERE '2007' <= to_char(hire_date, 'yyyy-mm-dd');
-- insert into board VALUES (' ', sysdate); sysdate 삽입 예시

-- date 변환 포맷
select to_char(sysdate, 'yyyy-mm-dd pm hh24:mi:ss') from dual;  -- 주로 java에서 사용
select to_date('2007-12-10', 'yyyy-mm-dd') from dual;           -- 주로 insert할 때

-- 숫자 변환 포맷 (결과는 String)
select first_name, to_char(salary, '$099,999') from EMPLOYEES;
select first_name, to_char(salary*1.2, 'L099,999') from EMPLOYEES;
select to_char(-100000, '999999MI') from dual;
select to_char(-100000, '999999PR') from dual;
select to_char(123, 'RN') from dual;
select to_char(123, 'rn') from dual;
select to_char(-100000, 'S999999') from dual;
select to_char(100000, 'S999999') from dual;
select to_char(1024, 'xxxxxx') from dual;

-- null 관련
select first_name, salary + nvl(commission_pct, 0)*salary from EMPLOYEES;
select first_name, salary + nvl2(commission_pct, commission_pct, 0)*salary from EMPLOYEES;

-- case, decode
select first_name, job_id, salary,
  case job_id
    when 'AD_VP' then salary*1.1
    when 'FI_MGR' then salary*1.5
    else salary
  end as "case 이번달 월급",
  decode(job_id, 'AD_VP', salary*1.1, 'FI_MGR', salary*1.5, salary) as "decode 이번달 월급"
  from EMPLOYEES;