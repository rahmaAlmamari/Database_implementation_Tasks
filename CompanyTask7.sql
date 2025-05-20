USE Company_SD;
--1. Display all the employees Data. 
SELECT * FROM Employee;
--2. Display the employee First name, last name, Salary and Department number.
SELECT Fname, Lname, Salary, Dno FROM Employee;
--3. Display all the projects names, locations and the department which is responsible about it. 
SELECT Pname, Plocation, Dnum FROM Project;
--4. If you know that the company policy is to pay an annual commission for each employee with specific percent 
   --equals 10% of his/her annual salary .Display each employee full name and his annual commission in an 
   --ANNUAL COMM column (alias). 
SELECT (Fname+ ' '+ Lname) as 'Employee Name', ((Salary*12) * (10/100) )as 'ANNUAL COMM' FROM Employee;
--5. Display the employees Id, name who earns more than 1000 LE monthly. 
SELECT SSN, (Fname+ ' '+ Lname) as 'Employee Name' FROM Employee WHERE Salary > 1000;
--Display the employees Id, name who earns more than 10000 LE annually.
SELECT SSN, (Fname+ ' '+ Lname) as 'Employee Name' FROM Employee WHERE Salary*12 > 1000;
--7. Display the names and salaries of the female employees  
SELECT (Fname+ ' '+ Lname) as 'Employee Name', Salary FROM Employee WHERE Sex = 'F';
--8. Display each department id, name which managed by a manager with id equals 968574. 
SELECT Dname as 'Department id', Dname as 'Department Name' FROM Departments WHERE MGRSSN = 968574;
--9. Dispaly the ids, names and locations of  the pojects which controled with department 10. 
SELECT Pnumber as 'Pojects id', Pname as 'Pojects Name', Plocation as 'Pojects Location' FROM Project WHERE Dnum = 10;
--10. Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, 
    --Superssn = 112233, salary=3000. 
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
VALUES ('Rahma', 'Almamari', 102672, '1998-07-27 00:00:00:00', 'Oman', 'F', 3000, 112233, 30);
--11. Insert another employee with personal data your friend as new employee in department number 30, SSN = 
    --102660, but don’t enter any value for salary or supervisor number to him. 
INSERT INTO Employee (Fname, Lname, SSN, Bdate, Address, Sex, Salary, Superssn, Dno)
VALUES ('Shahad', 'Almuqbali', 102660, '1998-06-27 00:00:00:00', 'Oman', 'F', null, null, 30);
--12. Upgrade your salary by 20 % of its last value. 
UPDATE Employee
SET Salary = Salary + ((20*Salary)/100)
WHERE SSN = 102672;