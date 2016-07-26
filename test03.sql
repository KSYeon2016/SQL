-- count : null이 아닌 것만 셈
select count(*) from EMPLOYEES;
select count(MANAGER_ID) from EMPLOYEES;

-- avg (+sum, max, min)
select avg(salary) from EMPLOYEES;
select DEPARTMENT_ID,
       to_char(avg(salary), '999,999') as avg_salary,
       to_char(sum(salary), '999,999'),
       to_char(max(salary), '999,999'),
       to_char(min(salary), '999,999')
  from EMPLOYEES
  group by DEPARTMENT_ID
  order by avg_salary;

select department_id, avg(salary)
  from EMPLOYEES
  group by department_id
  having avg(salary) > 5000 ;
  
-- 사장님을 뺀 사원들의 부서별 평균 연봉이 5,000 이상인 부서와 평균연봉을 평균연봉이 높은 순으로 출력
select department_id as 부서, to_char(avg(salary), '$99,999') as 평균연봉
  from EMPLOYEES
  where DEPARTMENT_ID is not null
  group by DEPARTMENT_ID
  having avg(salary) > 5000
  order by avg(salary) desc;