delete from employee where no >= 4;
commit;

desc employee;
desc department;

alter table employee auto_increment=1;
delete from employee where no > 1;

select * from employee;
select * from department;

insert into department values(null, '총무팀');
insert into department values(null, '영업팀');
insert into department values(null, '인사팀');
insert into department values(null, '개발팀');

insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 2);
insert into employee values(null, '또치', 3);
insert into employee values(null, '진국', null);
