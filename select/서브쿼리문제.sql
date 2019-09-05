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
--  sol 1-1
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
    order by salary desc;
    
--  sol 1-2
    select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, de.dept_no 부서, max_sal 최고연봉
    from employees e, dept_emp de, salaries s, (select dept_no, max(salary) 'max_sal'
												from salaries s2, dept_emp de2
												where s2.emp_no = de2.emp_no
                                                and s2.to_date = '9999-01-01' and de2.to_date = '9999-01-01'
												group by dept_no) ds_max
    where e.emp_no = de.emp_no and e.emp_no = s.emp_no and  de.dept_no = ds_max.dept_no
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
    and salary = max_sal
    order by salary desc;
    
-- 문제3. 113154
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
	select  e.emp_no 사번, concat(first_name, ' ', last_name) 이름, salary
    from employees e, salaries s, dept_emp de
    where e.emp_no = s.emp_no and e.emp_no = de.emp_no
    and s.to_date = '9999-01-01' and de.to_date = '9999-01-01'
    and salary > (select avg(salary)
					from dept_emp de2, salaries s2
					where de2.emp_no = s2.emp_no
                    and de.dept_no = de2.dept_no
                    and de2.to_date = '9999-01-01' and s2.to_date = '9999-01-01'
                    group by dept_no);
    
-- 문제4.	240124
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, m_name, dept_name
    from employees e, dept_emp de, departments d, (select dept_no ,e.emp_no, concat(first_name, ' ', last_name) 'm_name'
												   from employees e, dept_manager dm
                                                   where e.emp_no = dm.emp_no
                                                   and dm.to_date = '9999-01-01') m_tab
	where e.emp_no = de.emp_no and de.dept_no = d.dept_no 
    and de.dept_no = m_tab.dept_no
    and de.to_date = '9999-01-01';
    
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
-- sol 1-1
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, title 직책, salary 연봉, dept_no 부서번호
    from employees e, titles t, salaries s, dept_emp de
    where e.emp_no = t.emp_no and e.emp_no = s.emp_no and e.emp_no = de.emp_no
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
    and de.dept_no = (select dept_no
					 from (select dept_no, avg(salary) avg_sal
						   from dept_emp de, salaries s
                           where de.emp_no = s.emp_no
                           and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
                           group by dept_no
                           order by avg(salary) desc limit 1) max_avg_tab);
                           
-- sol 1-2
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, title 직책, salary 연봉, dept_no 부서번호
    from employees e, titles t, salaries s, dept_emp de
    where e.emp_no = t.emp_no and e.emp_no = s.emp_no and e.emp_no = de.emp_no
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01' and t.to_date = '9999-01-01'
    and de.dept_no = (select dept_no
					  from dept_emp de, salaries s
					  where de.emp_no = s.emp_no
					  and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
					  group by dept_no
					  having avg(salary) >= all (select avg(salary)
												 from dept_emp de, salaries s
												 where de.emp_no = s.emp_no
                                                 and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
                                                 group by de.dept_no));
                                                 
-- 문제6.
-- 평균 연봉이 가장 높은 부서는?
-- sol 1-1) 
	select dept_name 직책, avg(salary) '평균 연봉'
    from departments d, dept_emp de, salaries s
    where d.dept_no = de.dept_no and de.emp_no = s.emp_no
    group by d.dept_no 
    order by avg(salary) desc limit 1;
    
-- 문제7.
-- 평균 연봉이 가장 높은 직책?
-- sol 1-1)
	select title 직책, avg(salary) '평균 연봉'
    from titles t, salaries s
    where t.emp_no = s.emp_no
    group by title 
    order by avg(salary) desc limit 1;
    
-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
	select dept_name 부서이름, concat(first_name, ' ', last_name) 이름, salary '연봉', e.emp_no 사번 , m_name '매니저 이름', m_salary '매니저 연봉'
    from employees e, salaries s, dept_emp de, departments d, (select dept_no , concat(first_name, ' ', last_name) 'm_name', salary 'm_salary'
												   from employees e, dept_manager dm, salaries s
                                                   where e.emp_no = dm.emp_no and e.emp_no = s.emp_no
                                                   and dm.to_date = '9999-01-01' and s.to_date = '9999-01-01') m_tab
	where e.emp_no = de.emp_no and de.dept_no = d.dept_no and e.emp_no = s.emp_no
    and de.dept_no = m_tab.dept_no 
    and salary > m_salary
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01';
	