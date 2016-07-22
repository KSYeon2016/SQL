select EMPLOYEE_ID, SALARY, COMMISSION_PCT from EMPLOYEES;
select first_name, last_name from EMPLOYEES;

/* || : 문자열을 합쳐 칼럼을 name으로 출력, oracle에만 있음 */
select (first_name || ' ' || last_name) AS "name"  from EMPLOYEES;

select 2 + 3 from dual;
select (SALARY + SALARY*0.5) from EMPLOYEES;

/* String은 ""를 Number는 0을 default값으로 넣어주는 것이 좋음 */
/* nvl(expr1, expr2) : expr1이 null이면 expr2로 표시 */
select employee_id, commission_pct, nvl(salary + salary*commission_pct, 0) from EMPLOYEES;

/* sysdate : 현재 날짜를 나타내는 상수 */
select employee_id, 1000, sysdate from EMPLOYEES;

select '성은 ' || last_name || '이요, 이름은 ' || first_name from EMPLOYEES;

select first_name, salary from EMPLOYEES where EMPLOYEE_ID = 200;

/* salary가 1000이 넘는 employee */
select (first_name || ' ' || last_name) as "full_name" from EMPLOYEES where SALARY > 1000;

/* job_id가 'AD_PRES'가 아닌 사람 출력 */
select JOB_ID from JOBS where JOB_TITLE = 'President';
select first_name, job_id from EMPLOYEES where JOB_ID <> 'AD_PRES';

/* location이 Roma인 사람 출력 */
select * from LOCATIONS where CITY = 'Roma';
select * from DEPARTMENTS where LOCATION_ID = 1000;

/* location_id가 1700이나 1800 */
select * from DEPARTMENTS;
select * from DEPARTMENTS where LOCATION_ID in(1700, 1800);
select * from DEPARTMENTS where LOCATION_ID = 1700 or LOCATION_ID = 1800; /* 추천 */
select * from DEPARTMENTS where LOCATION_ID not in(1700, 1800);
select * from DEPARTMENTS where LOCATION_ID <> 1700 and LOCATION_ID <> 1800;

select * from EMPLOYEES where SALARY between 1000 and 10000;
select * from EMPLOYEES where 1000 <= salary and salary <= 10000;

select first_name from EMPLOYEES where first_name like 'A%';
select first_name from EMPLOYEES where first_name like '%es';
select first_name from EMPLOYEES where first_name like '%il%';
select first_name from EMPLOYEES where first_name like 'A___';

select EMPLOYEE_ID, COMMISSION_PCT from EMPLOYEES where COMMISSION_PCT is not null;

select first_name, last_name, salary from EMPLOYEES order by salary desc;
select first_name, last_name, salary from EMPLOYEES order by salary desc, first_name asc;