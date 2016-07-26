-- 집계 sql 문제

/* 문제 1. 
직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 함께 출력해 보세요.
두 임금의 차이는 얼마인가요? 함께 “최고임금 – 최저임금”이란 타이틀로 출력해 보세요. */
select max(salary) as 최고임금,
       min(salary) as 최저임금,
       max(salary)-min(salary) as "최고임금 - 최저임금"
  from EMPLOYEES;

/* 문제2.
마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일 */
select to_char(max(HIRE_DATE), 'yyyy"년" mm"월" dd"일"') from EMPLOYEES;

/* 문제3.
부서별로 평균임금, 최고임금, 최저임금을 부서(department_id)와 함께 출력하고
정렬순서는 평균연봉, 최고임금, 최저임금의 내림차순입니다. */
select DEPARTMENT_ID,
       to_char(avg(salary), '99,999') as 평균임금,
       to_char(max(salary), '99,999') as 최고임금,
       to_char(min(salary), '99,999') as 최저임금
  from EMPLOYEES
  group by DEPARTMENT_ID
  order by 평균임금 desc, 최고임금 desc, 최저임금 desc;

/* 문제4.
업무(JOB_ID)별로 평균임금, 최고임금, 최저임금을 업무(job_id)와 함께 출력하고
정렬순서는 평균연봉, 최고임금, 최저임금의 내림차순입니다. */
select JOB_ID as 업무, avg(salary) as 평균임금, max(salary) as 최고임금, min(salary) as 최저임금
  from EMPLOYEES
  group by JOB_ID
  order by 평균임금 desc, 최고임금 desc, 최저임금 desc;

/* 문제5.
가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
예) 2014년 07월 10일 */
select to_char(min(HIRE_DATE), 'yyyy"년" mm"월" dd"일"') from EMPLOYEES;

/* 문제6.
평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금 그리고 (평균임금 – 최저임금)를
(평균임금 – 최저임금)의 내림차순으로 정렬해서 출력하세요. */
select DEPARTMENT_ID as 부서,
       to_char(avg(salary), '99,999') as 평균임금, 
       to_char(min(salary), '99,999') as 최저임금, 
       to_char((avg(salary) - min(salary)), '99,999') as "(평균임금 - 최저임금)"
  from EMPLOYEES
  group by DEPARTMENT_ID
  having (avg(salary) - min(salary)) < 2000
  order by "(평균임금 - 최저임금)" desc;

/* 문제7.
업무(JOBS)별로 최고임금과 최저임금의 차이를 출력해보세요.
그리고 가장 큰 차이는 얼마입니까? 그 업무는 무엇인가요? */
-- 1. 최고임금 - 최저임금 출력
select JOB_ID as 업무, (max(salary) - min(salary)) as "최고임금 - 최저임금"
  from EMPLOYEES
  group by JOB_ID
  order by "최고임금 - 최저임금" desc;
-- 2. 가장 큰 차이와 업무
select JOB_TITLE from JOBS where JOB_ID = 'SA_REP';
-- 3. sub query
select *
  from (select JOB_ID, (max(salary) - min(salary)) as DIFF_SALARY
          from EMPLOYEES
          group by JOB_ID) a,
        JOBS b
  where a.JOB_ID = b.JOB_ID;