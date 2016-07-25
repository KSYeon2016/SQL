-- simple join (equi join)
select e.FIRST_NAME, d.DEPARTMENT_ID, d.DEPARTMENT_NAME from EMPLOYEES e, DEPARTMENTS d
  where e.DEPARTMENT_ID = d.DEPARTMENT_ID -- join 조건(table 수 - 1)
  and e.SALARY < 5000;                    -- row 선택 조건
  
-- inner join (행 106개)
-- equi join
select a.FIRST_NAME, d.DEPARTMENT_NAME
  from EMPLOYEES a, DEPARTMENTS d
  where a.DEPARTMENT_ID = d.DEPARTMENT_ID;
-- theta join (not equal join)
select *
  from EMPLOYEES a, JOBS j
  where a.SALARY BETWEEN j.MIN_SALARY and j.MAX_SALARY;
-- self join
select a.FIRST_NAME as "사원 이름", b.FIRST_NAME as "매니저 이름"
  from EMPLOYEES a, EMPLOYEES b
  where a.MANAGER_ID = b.EMPLOYEE_ID;

-- outer join (행 107개) oracle only
select a.FIRST_NAME as "사원", nvl(b.FIRST_NAME, '없음') as "매니저"
  from EMPLOYEES a, EMPLOYEES b
  where b.EMPLOYEE_ID (+)= a.MANAGER_ID;
  
select a.FIRST_NAME, d.DEPARTMENT_NAME
  from EMPLOYEES a, DEPARTMENTS d
  where d.DEPARTMENT_ID (+)= a.DEPARTMENT_ID;