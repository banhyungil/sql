-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, salary 연봉 
    from employees e, salaries s
    where e.emp_no = s.emp_no
    and to_date = '9999-01-01'
    order by salary desc;
    
-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, title
    from employees e, titles t
    where e.emp_no = t.emp_no
    and to_date = '9999-01-01';
    
-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, dept_name
    from employees e, dept_emp de, departments d
    where e.emp_no = de.emp_no and de.dept_no = d.dept_no
    and to_date ='9999-01-01'
    order by concat(first_name, ' ', last_name);
    
-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름, salary 연봉, title 직책, dept_name 부서
    from employees e, dept_emp de, departments d, salaries s, titles t
    where e.emp_no = de.emp_no and de.dept_no = d.dept_no and e.emp_no = t.emp_no and e.emp_no = s.emp_no
    and t.to_date = '9999-01-01' and s.to_date = '9999-01-01' and de.to_date = '9999-01-01';
    
-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
	select e.emp_no 사번, concat(first_name, ' ', last_name) 이름
    from employees e, titles t
    where e.emp_no = t.emp_no
    and title = 'Technique Leader' and t.to_date <> '9999-01-01';
    
-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
	select concat(first_name, ' ', last_name) 이름, title 직책, dept_name 부서
    from employees e, dept_emp de, departments d, titles t
    where e.emp_no = de.emp_no and de.dept_no = d.dept_no and e.emp_no = t.emp_no
    and t.to_date = '9999-01-01' and de.to_date = '9999-01-01'
    and last_name like 'S%';
    
-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
	select concat(first_name, ' ', last_name) 이름, title 직책, salary 급여
    from employees e, titles t, salaries s
    where e.emp_no = t.emp_no and e.emp_no = s.emp_no
    and title='Engineer' and salary >= 40000 and s.to_date = '9999-01-01'
    order by salary desc;
    
-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
	select title 직책, salary 급여
    from titles t, salaries s
    where t.emp_no = s.emp_no
    and salary > 50000
    and s.to_date = '9999-01-01'
    order by salary desc;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
	select dept_no 부서번호, avg(salary) 평균연봉
    from dept_emp de, salaries s
    where de.emp_no = s.emp_no
    and de.to_date = '9999-01-01' and s.to_date = '9999-01-01'
    group by dept_no;
    
-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
	select title 부서번호, avg(salary) 평균연봉
    from titles t, salaries s
    where t.emp_no = s.emp_no
    and t.to_date = '9999-01-01' and s.to_date = '9999-01-01'
    group by title
    order by avg(salary) desc;