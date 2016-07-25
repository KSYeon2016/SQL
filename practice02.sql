/* 문제 1. 
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name),
매니저(manager)의 이름(first_name)을 조회하세요. */
select e.EMPLOYEE_ID as 사번, e.FIRST_NAME as 이름, d.DEPARTMENT_NAME as 부서명,
       e2.FIRST_NAME as "매니저 이름"
  from EMPLOYEES e, DEPARTMENTS d, EMPLOYEES e2
  where e.DEPARTMENT_ID = d.DEPARTMENT_ID and e.MANAGER_ID = e2.EMPLOYEE_ID;

/* 문제2.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되
지역이름, 나라이름 순서대로 내림차순으로 정렬하세요. */
select r.REGION_NAME as 지역이름, c.COUNTRY_NAME as 나라이름
  from REGIONS r, COUNTRIES c
  where r.REGION_ID = c.REGION_ID
  order by r.REGION_NAME desc, c.COUNTRY_NAME desc;

/* 문제3.
각 부서(department)에 대해서 부서번호(department_id), 이름(department_name), 매니저(manager)의 이름(first_name),
위치(locations)한 도시(city), 나라(countries)의 이름(countries_name)
그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요. */
select d.DEPARTMENT_ID as 부서번호, d.DEPARTMENT_NAME as 이름, e.FIRST_NAME as "매니저 이름",
       c.COUNTRY_NAME as "위치한 도시", c.COUNTRY_NAME as "나라 이름", r.REGION_NAME as "지역구분 이름"
  from DEPARTMENTS d, EMPLOYEES e, LOCATIONS l, COUNTRIES c, REGIONS r
  where d.MANAGER_ID = e.EMPLOYEE_ID and d.LOCATION_ID = l.LOCATION_ID
        and c.COUNTRY_ID = l.COUNTRY_ID and c.REGION_ID = r.REGION_ID;

/* 문제4.
‘Public Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요.
(현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려하지 않습니다.)
이름은 first_name과 last_name을 합쳐 출력합니다. */
select e.EMPLOYEE_ID as 사번, (e.FIRST_NAME || ' ' || e.LAST_NAME) as 이름
  from JOB_HISTORY jh, JOBS j, EMPLOYEES e
  where jh.JOB_ID = j.JOB_ID and e.EMPLOYEE_ID = jh.EMPLOYEE_ID and jh.JOB_ID = 'AC_ACCOUNT';
  
/* 문제5.
같은 성(last_name)을 가진 직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서 이름을 조회하여
성(last_name)순서로 정렬하세요 */
select * from EMPLOYEES;
select e.EMPLOYEE_ID, e.LAST_NAME
  from EMPLOYEES e, DEPARTMENTS d
  where e.DEPARTMENT_ID = d.DEPARTMENT_ID
  order by e.LAST_NAME;

/* 문제6.
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 사번(employee_id), 성(last_name)과 채용일(hire_date)을
조회하세요 */ 
select * from EMPLOYEES;
select e.EMPLOYEE_ID, e.LAST_NAME, e.HIRE_DATE
  from EMPLOYEES e, EMPLOYEES e2
  where e.MANAGER_ID = e2.EMPLOYEE_ID;