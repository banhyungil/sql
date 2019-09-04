-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
	select count(*) '평균 연봉 이상 직원 수'
    from employees e, salaries s
    where e.emp_no = s.emp_no 
    and salary >= (select avg(salary)
				  from salaries);
-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, dept_no, salary 최고연봉
    from employees e, dept_emp de, salaries s
    where e.emp_no = de.emp_no and e.emp_no = s.emp_no
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
    and salary = (select max(salary)
				  from salaries s2, dept_emp de2
                  where s2.emp_no = de2.emp_no
                  and de2.dept_no = de.dept_no 
                  and s2.to_date = '9999-01-01' and de2.to_date = '9999-01-01'
                  group by dept_no)
    group by dept_no
    order by salary desc;
    
    select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, de.dept_no, max_sal 최고연봉
    from employees e, dept_emp de, salaries s, (select dept_no, max(salary) 'max_sal'
												from salaries s2, dept_emp de2
												where s2.emp_no and de2.emp_no
												group by dept_no) ds_max
    where e.emp_no = de.emp_no and e.emp_no = s.emp_no and  de.dept_no = ds_max.dept_no
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
    order by salary desc;
    
-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
	select  e.emp_no 사번, concat(first_name, ' ', last_name) 이름, salary
    from employees e, salaries s, dept_emp de
    where salary > (select avg(salary)
					from dept_emp de2, salaries s2
					where de.dept_no = de2.dept_no
                    group by dept_no);
    
-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
	select  e.emp_no 사번, concat(first_name, ' ', last_name) 이름, 
    
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 

-- 문제7.
-- 평균 연봉이 가장 높은 직책?

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
	