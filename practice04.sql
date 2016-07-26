-- 서브쿼리(SUBQUERY) SQL 문제
/* 문제1.
평균 연봉보다 적은 월급을 받는 직원은 몇 명이나 있습니까? */
select count(*)
  from EMPLOYEES
  where salary < (select avg(salary) from EMPLOYEES);

/* 문제2. 
각 부서별로 최고의 급여를 받는 사원의 사번(employee_id), 성(last_name)과 연봉(salary)을 조회하세요
단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. */
select EMPLOYEE_ID as 사번, LAST_NAME as 성, SALARY as 연봉
  from EMPLOYEES
  where (DEPARTMENT_ID, SALARY)
    in (select DEPARTMENT_ID, max(salary) from EMPLOYEES group by DEPARTMENT_ID)
  order by salary desc;

/* 문제3.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 */
select b.JOB_TITLE as 업무명, a.합 as "연봉 총합"
  from (select JOB_ID, sum(salary) as 합 from EMPLOYEES group by JOB_ID) a,
       JOBS b
  where a.JOB_ID = b.JOB_ID
  order by a.합 desc;

/* 문제4.
자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의
사번(employee_id), 성(last_name)과 연봉(salary)을 조회하세요 */
select a.EMPLOYEE_ID as 사번, a.LAST_NAME as 성, a.SALARY as 연봉
  from EMPLOYEES a,
       (select DEPARTMENT_ID, avg(salary) as avg_salary from EMPLOYEES group by DEPARTMENT_ID) b
  where a.DEPARTMENT_ID = b.DEPARTMENT_ID and a.SALARY > b.avg_salary;