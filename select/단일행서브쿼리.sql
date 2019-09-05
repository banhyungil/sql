-- 단일행 연산

-- ex) (현재 Fai Bale이 근무하는 부서)에서 근무하는 (직원의 사번, 전체이름)을 출력해보세요.

-- sol1-1)
select de.emp_no, de.dept_no
from dept_emp de, employees e
where de.emp_no = e.emp_no
and e.first_name = 'Fai'
and e.last_name = 'Bale'
and to_date = '9999-01-01';

-- sol1-2)
select de.emp_no 사번, concat(first_name, ' ', last_name) 이름
from dept_emp de, employees e
where de.emp_no = e.emp_no
and dept_no = d004
and to_date = '9999-01-01';

-- sol2)
select de.emp_no 사번, concat(first_name, ' ', last_name) 이름
from employees e, dept_emp de
where e.emp_no = de.emp_no
and dept_no = (select dept_no
			   from employees e, dept_emp de
			   where e.emp_no = de.emp_no
				and to_date = '9999-01-01'
                and first_name = 'Fai'
                and last_name = 'Bale');
                
-- 서브쿼리는 괄호로 묶여야 함
-- 서브쿼리 내에 order by 금지
-- group by 절 외에 모든 절에서 사용가능
-- where 절인 경우,
-- 	1)단일행 연산자 : =, >, <, >=, <=, <>


-- 실습문제1)
-- 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 나타내세요.
	select concat(first_name, ' ', last_name) 이름, salary 급여
    from employees e, salaries s
    where to_date = '9999-01-01' 
    and salary < (select avg(salary)
					from salaries
					where to_date = '9999-01-01');
    
-- 실습문제2)
-- 현재 가장적은 평균 급여를 받고 있는 직책에 대해서 평균 급여를 구하세요.
-- sol-1
	select title, min(avg_sal) '최저 평균급여'
    from (select title, avg(salary) 'avg_sal'
		  from salaries s, titles t
          where s.emp_no = t.emp_no
          and s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
          group by title) avg_tab;
          
-- sol-2
select title, avg(salary)
from salaries s, titles t
where s.emp_no = t.emp_no
and s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
group by title
order by avg(salary)
limit 0, 1;
          