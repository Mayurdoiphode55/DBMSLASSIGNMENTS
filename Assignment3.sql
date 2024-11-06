desc Employee2;
select * from Employee2;
select * from Dept2;
select * from Project2;
select  * from Employee2 natural join Dept2;
select e.Emp_fname,e.Emp_position,d.Location,e.Emp_joindate from Employee2 e join Dept2 d on e.Dept_id=d.Dept_id;
select e.Emp_fname,e.Emp_position,d.Location,e.Emp_joindate from Employee2 e join Dept2 d on e.Dept_id=d.Dept_id where e.Dept_id in (select Dept_id From Dept2 group by Dept_id);
select e.Emp_fname,e.Emp_position,e.Emp_joindate,p.Proj_id,p.Proj_cost from Employee2 e join Project2 p on e.Dept_id=p.Dept_id where Proj_location <> 'New York';
select d.Dept_name,e.Emp_fname,e.Emp_position from Employee2 e join Dept2 d where e.Dept_id in (select Dept_id from Project where year(Proj_year)='2021');
	