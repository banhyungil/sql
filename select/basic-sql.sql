-- select 기본
select first_name, last_name,gender,hire_date
from employees;
-- concat
select concat(first_name,' ', last_name) concat, gender, hire_date from employees;

-- alias -> as 생략 가능
select concat(first_name,' ', last_name) concat, gender, hire_date from employees;
select concat(first_name,' ', last_name) 'con cat', e.gender, hire_date from employees e;

-- 중복 제거 distinct
select distinct(title) from titles;

-- order by
select concat(first_name, ' ', last_name) as 이름, gender as 성별, hire_date as 입사일
from employees
order by hire_date;

-- salaries 테이블에서 2001년 월급을 가장 높은순으로 사번, 월근순으로 출력
select emp_no, salary, from_date
from salaries
where from_date like '2001%'
order by salary desc;

-- employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select concat(first_name, ' ', last_name) 이름, gender 성별, hire_date 입사일
from employees
where hire_date < '1991-01-01'
order by hire_date desc;

-- dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사번, 부서번호 출력
select *
from dept_emp
where dept_no = 'd005' 
or dept_no = 'd009';

select *
from dept_emp
where dept_no in('d005','d009');