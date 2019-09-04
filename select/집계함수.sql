select avg(salary), sum(salary)
from salaries
where emp_no='10060';

select emp_no, avg(salary), sum(salary)
from salaries
where to_date = '9999-01-01'
group by emp_no
having avg(salary) > 40000
order by avg(salary) asc;


-- 각 사원별로 평균연봉 출력
-- 높은순서대로
select emp_no, avg(salary)
from salaries
group by emp_no
order by avg(salary) desc;

-- 사원별 몇 번의 직책변경이 있엇는지 조회
select emp_no, count(*)
from titles
group by emp_no
order by count(*) desc;

-- ex2 [과제]각 현재 Manager 직책 사원에 대한 평균 연봉은?
select avg(salary)
from salaries s, titles t
where s.emp_no = t.emp_no
and title = 'Manager' and t.to_date >= now();

-- ex2 [과제]각 현재 직책별 사원에 대한 평균 연봉은?
select avg(salary)
from salaries s, titles t
where s.emp_no = t.emp_no
and t.to_date >= now()
group by t.title;

-- 예제3:  사원별 몇 번의 직책 변경이 있었는지 조회 
select emp_no, count(*)
from titles
group by emp_no;

-- 예제4 : 각 사원별로 평균연봉 출력하되 50,000불 이상인 직원만 출력
select emp_no, avg(salary)
from employees
group by emp_no
having avg(salary) > 50000
order by avg(salary) asc;

-- 예제5: 현재 직책별로 평균 연봉과 인원수를 구하되 직책별로 인원이  100명 이상인 직책만 출력하세요.
select title, avg(salary), count(*)
from employees e, salaries s, titles t
where e.emp_no = s.emp_no and e.emp_no = t.emp_no and t.to_date > now()
group by title
having count(*) >= 100;

-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
select dept_no, avg(salary)
from employees e, dept_emp d, titles t, salaries s
where e.emp_no = d.emp_no and e.emp_no = t.emp_no and e.emp_no = s.emp_no
and title = 'Engineer' and t.to_date >= now() and d.to_date >= now()
group by dept_no;

-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요. 
select title, sum(salary)
from titles t, salaries s
where t.emp_no = s.emp_no and title <> 'Engineer' 
and t.to_date = '9999-01-01' and s.to_date = '9999-01-01'
group by title
having sum(salary) >= 2000000000
order by sum(salary) desc;

-- top query
select * from salaries order by salary desc limit 3;
