-- 의사 칼럼(Pseudo Column) : 테이블에 실제론 없지만 출력 가능
-- connect by prior (계층구조 데이터 표현할 때, 트리, 디렉토리 구조, 조직도)
select sysdate, EMPLOYEE_ID from EMPLOYEES;
select level, employee_id, MANAGER_ID, last_name
  from EMPLOYEES
  start with manager_id is null
  connect by prior EMPLOYEE_ID = MANAGER_ID
  order by level;
  
-- rollup, cube
select department_id, job_id, sum(salary) 
  from employees 
  group by department_id, job_id
  order by department_id;
select DEPARTMENT_ID, JOB_ID, sum(SALARY)
  from EMPLOYEES
  group by rollup(DEPARTMENT_ID, JOB_ID);
select DEPARTMENT_ID, JOB_ID, sum(SALARY)
  from EMPLOYEES
  group by cube(DEPARTMENT_ID, JOB_ID);

-- top-k rownum (게시판에서 페이징처리)
select rownum, employee_id, first_name
  from EMPLOYEES
  where rownum < 6;
  
-- order by 이전에 where 절까지 실행되서 선택된 row가 있는 임시 테이블에서 rownum이 세팅됨
select rownum, employee_id, first_name
  from EMPLOYEES
  order by first_name;
  
-- 해결방법(subquery)
select rownum, employee_id, first_name
  from (select employee_id, first_name
          from EMPLOYEES
          order by first_name)
  where rownum < 6;
select rownum, employee_id, first_name
  from (select employee_id, first_name
          from EMPLOYEES
          order by first_name)
  where 10 < rownum and rownum < 20;
  
-- 최종 해결 방법
select *
  from (select rownum as rn, employee_id, first_name
        from (select employee_id, first_name
                from EMPLOYEES
                order by first_name))
  where (4-1)*10+1 <= rn and rn <= 4*10;
  
-- rowid(pseudo column rownum, sysdate, rowid)
select rowid, first_name from EMPLOYEES;