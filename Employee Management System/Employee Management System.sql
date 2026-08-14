CREATE DATABASE CompanyDB;


USE CompanyDB;



##Create Department Table


CREATE TABLE Departments(
Dept_ID INT PRIMARY KEY,
Dept_Name VARCHAR(50) UNIQUE,
Location VARCHAR(50)
);






## insert Departments

insert into Departments values
(101, 'IT','Pune'),
(102, 'HR','Mumbai'),
(103,'Finance','Delhi'),
(104,'Sales','Bangalore'),
(105,'Marketing','Chennai');



## #create employee table

create table Employees(
Emp_ID int primary key,
Emp_Name VARCHAR(50) NOT NULL,
Age int CHECK(AGE>=18),
Gender varchar(10),
Salary Decimal(10, 2),
City VARCHAR(30) DEFAULT 'Pune',
Joining_Date DATE,
Dept_ID INT,
Email VARCHAR(100) UNIQUE,
FOREIGN KEY(Dept_ID) REFERENCES Departments(Dept_ID)
);





# Insert Employees


INSERT INTO Employees VALUES
(1,'Amit',24,'Male',50000,'Pune','2023-01-10',101,'amit@gmail.com'),
(2,'Rahul',28,'Male',70000,'Mumbai','2022-02-15',102,'rahul@gmail.com'),
(3,'Sneha',26,'Female',85000,'Pune','2021-03-20',101,'sneha@gmail.com'),
(4,'Priya',29,'Female',60000,'Delhi','2020-04-12',103,'priya@gmail.com'),
(5,'Karan',27,'Male',75000,'Bangalore','2021-05-16',104,'karan@gmail.com'),
(6,'Neha',25,'Female',95000,'Pune','2024-01-05',101,'neha@gmail.com'),
(7,'Vikas',30,'Male',55000,'Mumbai','2019-06-08',102,'vikas@gmail.com'),
(8,'Pooja',23,'Female',65000,'Pune','2023-08-18',105,'pooja@gmail.com'),
(9,'Ankit',31,'Male',80000,'Delhi','2020-09-25',103,'ankit@gmail.com'),
(10,'Om',22,'Male',45000,'Pune','2024-02-15',101,'om@gmail.com');




select * from Employees;



# basic queries 



select Emp_Name,Salary from Employees;




select Distinct city from Employees;


# where Clause 

select * from Employees 
where Salary > 70000;




select * from Employees 
where City = 'Pune';






## Operators 

select * from Employees 
where Salary > 50000 and City = 'Pune';





select * from Employees 
where City = 'Pune' Or City = 'Mumbai';






Select * from Employees
where Salary Between 50000 and 80000;




select * from Employees
where Dept_ID in(101,103);





select * from Employees 
where Emp_Name like 'A%';




## Functions 

select Count(*) from Employees;


select Sum(Salary) from Employees;



select Avg(Salary) from Employees;




select min(Salary) from Employees;


select max(Salary) from Employees;


select Upper(Emp_Name) from Employees;


select Lower(Emp_Name) from Employees;


select Length(Emp_Name) from Employees;







## group by


select Dept_ID, Count(*) TotalEmployee 
from Employees 
Group By Dept_ID;







## having 

select Dept_ID, Avg(Salary)
from Employees
group by Dept_Id
having Avg(Salary) > 70000;






## Order By 

Select * 
from Employees
order By Salary Desc;





# inner Join 


select e.Emp_Name,
d.Dept_Name,
e.Salary
from Employees e
inner join Departments d 
on e.Dept_ID = d.Dept_ID;







#left Join 

select * 
from Employees e
left join Departments d
on e.Dept_ID = d.Dept_ID;






# right join 

Select *
from Employees e
right join Departments d
on e.Dept_ID = d.Dept_ID;






# suqueies
#employees earning more than average salary 


select *
from employees 
where Salary > 
(
select Avg(Salary)
from Employees
);






##second Highest Salary 


select Max(Salary)
from Employees
where Salary <
(
Select Max(Salary)
from Employees
);







## Exists


SELECT Dept_Name
FROM Departments d
WHERE EXISTS
(
SELECT *
FROM Employees e
WHERE d.Dept_ID=e.Dept_ID
);










## any 


select *
from Employees 
where Salary > 
Any
(
select Salary
from Employees
where Dept_Id = 102 
);








# All 

select * 
from Employees
where Salary >
All
(
Select Salary
from Employees 
where Dept_ID = 102
);









# View 

Create View Employee_View as 
select Emp_Name, Salary
from Employees;






SELECT * FROM Employee_View;






# Index

CREATE INDEX idx_name
ON Employees(Emp_Name);




## Stored Procedure 

DELIMITER $$

CREATE PROCEDURE ShowEmployees()
BEGIN
SELECT * FROM Employees;
END $$

DELIMITER ;




CALL ShowEmployees();






DELIMITER $$

CREATE TRIGGER SalaryCheck
BEFORE INSERT
ON Employees
FOR EACH ROW
BEGIN
IF NEW.Salary<30000 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT='Salary too low';
END IF;
END $$

DELIMITER ;










## Transaction (tcl)


start Transaction;


update Employees
set Salary = Salary+5000
Where Dept_ID = 101;



savepoint sp1;


delete from Employees
where Emp_ID = 10;


Rollback to sp1;

commit;








# DCL 

GRANT SELECT,INSERT
ON Employees
TO user1;



REVOKE INSERT
ON Employees
FROM user1;
