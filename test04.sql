-- sub query
-- Jack보다 연봉이 많은 사원
select salary from EMPLOYEES where first_name = 'Jack';
select first_name, salary from EMPLOYEES where salary > 8400;

select first_name, salary from EMPLOYEES
  where salary > (select salary from EMPLOYEES where first_name = 'Jack');
  
-- 문제점
select first_name, salary from EMPLOYEES
  where salary > (select salary from EMPLOYEES where first_name = 'Karen'); -- 에러
select salary from EMPLOYEES where first_name = 'Karen';  -- 둘임

-- sub query는 from절과 where절에 들어갈 수 있다

-- 임금이 제일 적은 사원
select first_name, salary from EMPLOYEES
  where salary = (select min(salary) from EMPLOYEES);
-- 평균연봉보다 적게 받는 사원들
select first_name, salary from EMPLOYEES
  where salary < (select avg(salary) from EMPLOYEES);
  
-- Purchasing에서 근무하고 있는 사원들
-- sub query
select first_name, department_id from EMPLOYEES
  where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENTS where department_name = 'Purchasing');
-- join
select e.first_name, e.department_id 
  from EMPLOYEES e, DEPARTMENTS d
  where e.DEPARTMENT_ID = d.DEPARTMENT_ID
    and d.DEPARTMENT_NAME = 'Purchasing';

-- 최저임금을 받고 있는 사원들    
-- subquery의 결과가 multi row
select first_name, salary 
  from EMPLOYEES
  where salary in (select min(salary) from EMPLOYEES group by DEPARTMENT_ID);
select first_name, salary 
  from EMPLOYEES
  where salary = any (select min(salary) from EMPLOYEES group by DEPARTMENT_ID);
select min(salary) from EMPLOYEES group by DEPARTMENT_ID;

-- multi row & multi colum ***
select first_name, salary 
  from EMPLOYEES
  where (DEPARTMENT_ID, salary) 
    in (select DEPARTMENT_ID, min(salary) from EMPLOYEES group by DEPARTMENT_ID);
select DEPARTMENT_ID, min(salary) from EMPLOYEES group by DEPARTMENT_ID;

-- correlated query (비추)
select first_name, department_id, salary
  from EMPLOYEES a
  where salary = (select min(salary) from EMPLOYEES where department_id = a.department_id);

-- from 절에 select(select 결과를 테이블로 사용한다) *****
-- select DEPARTMENT_ID, min(salary) as min_salary from EMPLOYEES group by DEPARTMENT_ID;
-- select * from EMPLOYEES;
select a.FIRST_NAME, a.SALARY
  from EMPLOYEES a,
       (select DEPARTMENT_ID, min(salary) as min_salary
        from EMPLOYEES
        group by DEPARTMENT_ID) b
  where a.DEPARTMENT_ID = b.DEPARTMENT_ID -- join 조건
    and a.SALARY = b.min_salary;          -- 검색 조건