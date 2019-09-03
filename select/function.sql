-- 1. 자바 데이터 처리하는것보다 DB에서 데이터 처리하는것이 훨씬 빠르다.
-- 2. 웬만한 데이터처리는 DB에서 다해주고 java에서는 출력만 해주는것이 바람직하다.
-- 3. 자바 코드가 간결해서 좋다.
-- upper, lower, lcase
select upper('SEoul') upper, lower('SEoul') lower, lcase('SEOUL');
select upper(first_name) from employees;

-- subString
select substring('Happy Day', 1, 2);
select substring('Happy Day', 6);
-- ex
select hire_date, substring(hire_date,1,4) 입사년도 from employees order by hire_date;

-- lpad, rpad
select lpad('1234', 5, '-');
select rpad('1234', 5, '*');
select rpad('1234', 3,'*');

-- ltrim, rtrim, trim
select concat(ltrim('   apple   '),'-',rtrim('apple    '), '-',trim('        apple        '));
select trim(both 'x' from 'xxxxhelloxxxx');
select trim(leading 'x' from 'xxxxhelloxxxx');
select trim(trailing 'x' from 'xxxxhelloxxxx');


