USE Company_SD;
--------------------------------Task 7----------------------------------------------------------------------
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
--------------------------------------------------------Task 8-----------------------------------------------------------
--1. Display the department ID, department name, manager ID, and the full name of the manager. 
SELECT * FROM Departments;

SELECT D.Dnum as 'Department ID', D.Dname as 'Department Name', D.MGRSSN as 'Manager ID', (E.Fname + ' '+ E.Lname) as 'Manager Name'
FROM Departments D, Employee E
WHERE E.SSN = D.MGRSSN;

--2. Display the names of departments and the names of the projects they control. 
SELECT * FROM Departments;
SELECT * FROM Project;

SELECT D.Dname as 'Department Name', P.Pname as 'Project Name' 
FROM Departments D, Project P
WHERE D.Dnum = P.Dnum;

--3. Display full data of all dependents, along with the full name of the employee they depend on. 
SELECT * FROM Dependent;
--SELECT * FROM Employee;

SELECT D.* , (E.Fname + ' '+ E.Lname) as 'Employee Name'
FROM Dependent D, Employee E
WHERE E.SSN = D.ESSN;

--4. Display the project ID, name, and location of all projects located in Cairo or Alex. 
SELECT * FROM Project;

SELECT Pnumber as 'Project ID', Pname as 'Project Name', Plocation as 'Location'
FROM Project 
WHERE City = 'Cairo' or City = 'Alex';

--5. Display all project data where the project name starts with the letter 'A'. 
SELECT * FROM Project;

SELECT *
FROM Project 
WHERE Pname Like 'A%';

--6. Display the IDs and names of employees in department 30 with a salary between 1000 and 2000 LE. 
SELECT * FROM Employee;

SELECT SSN, (Fname + ' '+ Lname) as 'Employee Name'
FROM Employee 
WHERE Dno = 30 and Salary between 1000 and 2000;

--7. Retrieve the names of employees in department 10 who work ≥ 10 hours/week on the "AL Rabwah" project. 
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Works_for;

SELECT (E.Fname + ' '+ E.Lname) as 'Employee Name'
FROM Employee E INNER JOIN Works_for W ON E.SSN = W.ESSn
INNER JOIN Project P ON P.Pnumber = W.Pno 
WHERE E.Dno = 10 and P.Pname = 'AL Rabwah' and W.Hours >= 10;

--8. Find the names of employees who are directly supervised by "Kamel Mohamed". 
SELECT * FROM Employee;

SELECT (E.Fname + ' '+ E.Lname) as 'Employee Name'
FROM Employee E INNER JOIN Employee S
ON S.SSN = E.Superssn 
WHERE(S.Fname + ' '+ S.Lname)  = 'Kamel Mohamed';

--9. Retrieve the names of employees and the names of the projects they work on, sorted by project name. 
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Works_for;

SELECT (E.Fname + ' '+ E.Lname) as 'Employee Name', P.Pname as 'Projects Name'
FROM Employee E  INNER JOIN Works_for W ON E.SSN = W.ESSn INNER JOIN Project P ON P.Pnumber = W.Pno 
ORDER BY P.Pname;

--10. For each project located in Cairo, display the project number, controlling department name, manager's last name, 
    --address, and birthdate. 
SELECT * FROM Employee;
SELECT * FROM Project;
SELECT * FROM Departments;

SELECT P.Pnumber as 'Project Number',  D.Dname as 'Department Name', E.Lname as 'Manager Last Name', E.Address as 'Address', E.Bdate as 'Birthdate'
FROM Departments D INNER JOIN Project P ON D.Dnum = P.Dnum INNER JOIN Employee E ON E.SSN = D.MGRSSN
WHERE P.City = 'Cairo';

--11. Display all data of managers in the company. 
SELECT * FROM Employee;

SELECT M.*
FROM Employee E, Employee M
WHERE M.SSN = E.Superssn;

--12. Display all employees and their dependents, even if some employees have no dependents. 
SELECT * FROM Employee;
SELECT * FROM Dependent;

SELECT E.* , D.Dependent_name as 'Dependent Name'
FROM Employee E LEFT OUTER JOIN Dependent D
ON E.SSN = D.ESSN;