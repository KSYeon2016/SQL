-- 표준 join SQL
-- natural join
-- 두 개의 조인 조건이 의도하지 않았는데 걸림
-- department_id, manager_id
select a.FIRST_NAME, b.DEPARTMENT_NAME
  from EMPLOYEES a
  natural join DEPARTMENTS b;
-- join ~ using
select a.FIRST_NAME, b.DEPARTMENT_NAME
  from EMPLOYEES a
  join DEPARTMENTS b
  using (department_id);
  
-- join ~ on
select a.FIRST_NAME, b.DEPARTMENT_NAME
  from EMPLOYEES a
  join DEPARTMENTS b
  on a.DEPARTMENT_ID = b.DEPARTMENT_ID;
-- 아래와 동일
-- select a.FIRST_NAME, d.DEPARTMENT_NAME
--   from EMPLOYEES a, DEPARTMENTS d
--   where a.DEPARTMENT_ID = d.DEPARTMENT_ID;

-- left outer (mysql에서도 사용 가능)
-- select a.FIRST_NAME as "사원", nvl(b.FIRST_NAME, '없음') as "매니저"
--   from EMPLOYEES a, EMPLOYEES b
--   where b.EMPLOYEE_ID (+)= a.MANAGER_ID;
select a.FIRST_NAME, b.DEPARTMENT_NAME
  from EMPLOYEES a
  left outer join DEPARTMENTS b
  on a.DEPARTMENT_ID = b.DEPARTMENT_ID;
select a.FIRST_NAME, b.DEPARTMENT_NAME
  from DEPARTMENTS b
  right outer join EMPLOYEES a
  on a.DEPARTMENT_ID = b.DEPARTMENT_ID;
-- equi join은 where, outer join은 on 추천