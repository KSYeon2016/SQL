-- 혼합 문제
/* 문제1.
가장 늦게 입사한 직원(first_name last_name)의 이름과 연봉(salary)과 근무하는 부서 이름(department_name)은? */
select (e.FIRST_NAME || ' ' || e.LAST_NAME) as 이름, e.SALARY as 연봉, d.DEPARTMENT_NAME as "부서 이름" 
  from EMPLOYEES e, DEPARTMENTS d
  where e.DEPARTMENT_ID = d.department_id
    and e.HIRE_DATE = (select max(HIRE_DATE) from EMPLOYEES);

/* 문제2. 
자신의 부서 평균 급여보다 연봉이 많은 사원의 사번(employee_id), 성(last_name)과 연봉(salary)을 조회하세요 */
select a.EMPLOYEE_ID as 사번, a.LAST_NAME as 성, a.SALARY as 연봉
  from EMPLOYEES a,
       (select DEPARTMENT_ID, avg(salary) as avg_salary from EMPLOYEES group by DEPARTMENT_ID) b
  where a.DEPARTMENT_ID = b.DEPARTMENT_ID
    and a.SALARY > b.avg_salary;

/* 문제3.
평균연봉(salary)이 가장 높은 부서 사원들의 사번(employee_id), 이름(firt_name), 성(last_name)과
업무(job), 연봉(salary)을 조회하시오. */
select max(avg(salary)) from EMPLOYEES group by DEPARTMENT_ID;  -- 최고 평균연봉

select DEPARTMENT_ID, avg(salary)
  from EMPLOYEES group by DEPARTMENT_ID
  having avg(salary) = (select max(avg(salary)) from EMPLOYEES group by DEPARTMENT_ID);

-- 답  
select a.EMPLOYEE_ID as 사번, a.FIRST_NAME as 이름, a.LAST_NAME as 성,
       c.JOB_TITLE as 업무, a.SALARY as 연봉
  from EMPLOYEES a,
       (select DEPARTMENT_ID, avg(salary)
          from EMPLOYEES group by DEPARTMENT_ID
          having avg(salary) = (select max(avg(salary)) from EMPLOYEES group by DEPARTMENT_ID)) b,
       JOBS c
  where a.DEPARTMENT_ID = b.DEPARTMENT_ID
    and a.JOB_ID = c.JOB_ID;

/* 문제4.
평균 연봉(salary)이 가장 높은 부서는? */
select DEPARTMENT_NAME as 부서명
  from DEPARTMENTS
  where DEPARTMENT_ID = 
    (select DEPARTMENT_ID
      from EMPLOYEES
      group by DEPARTMENT_ID
      having avg(salary) = (select max(avg(salary)) from EMPLOYEES group by DEPARTMENT_ID));

/* 문제5.
평균 연봉(salary)이 가장 높은 지역은? */
select max(avg(a.SALARY)) 
  from EMPLOYEES a, DEPARTMENTS b
  where a.DEPARTMENT_ID = b.DEPARTMENT_ID
  group by b.LOCATION_ID; -- location_id로 묶어서 제일높은 평균연봉
  
-- 답
select CITY
  from LOCATIONS
  where LOCATION_ID = (select d.location_id
                        from EMPLOYEES a,
                        DEPARTMENTS d
                        where a.DEPARTMENT_ID = d.DEPARTMENT_ID
                        group by d.LOCATION_ID
                        having avg(a.SALARY) = (select max(avg(a.SALARY)) 
                                                  from EMPLOYEES a, DEPARTMENTS b
                                                  where a.DEPARTMENT_ID = b.DEPARTMENT_ID
                                                  group by b.LOCATION_ID));

/* 문제6.
평균 연봉(salary)이 가장 높은 업무는? */
select JOB_TITLE
  from JOBS
  where JOB_ID = (select JOB_ID
                    from EMPLOYEES
                    group by JOB_ID
                    having avg(salary) = (select max(avg(salary))
                                            from EMPLOYEES
                                            group by JOB_ID));