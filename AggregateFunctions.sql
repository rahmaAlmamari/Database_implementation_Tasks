
Create Database  GTR;
 USE GTR;

 --Create Employee table
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    gender VARCHAR(10),
    department VARCHAR(50),
    salary INT
);

-- Insert data into Employee table
INSERT INTO Employee VALUES
(1, 'Aarav', 'Male', 'IT', 50000),
(2, 'Divya', 'Female', 'HR', 45000),
(3, 'Gaurav', 'Male', 'IT', 55000),
(4, 'Aarav', 'Male', 'Finance', 60000),
(5, 'Divya', 'Female', 'HR', 48000),
(6, 'Priya', 'Female', 'Finance', 52000),
(7, 'Rahul', 'Male', 'IT', NULL);

-- Create Student table
CREATE TABLE Student (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    subject VARCHAR(50),
    year INT,
    grade CHAR(1)
);

-- Insert data into Student table
INSERT INTO Student VALUES
(1, 'John', 'Mathematics', 1, 'A'),
(2, 'Emily', 'Science', 3, 'B'),
(3, 'Michael', 'English', 2, 'A'),
(4, 'Jessica', 'Mathematics', 1, 'B'),
(5, 'David', 'Science', 3, 'C'),
(6, 'Sarah', 'English', 2, 'A'),
(7, 'Robert', 'Mathematics', 2, 'B');


-----------------------------------------------------------------Aggregate Functions --------------------------------------------
--1. Count the Total Number of Employees 
SELECT * FROM Employee;

SELECT count(*) as 'Total Number of Employees' FROM Employee;
--2. Calculate the Total Salary (ignoring NULL values) 
SELECT * FROM Employee;

SELECT SUM(salary) as 'Total Salary of Employees' FROM Employee;
--3. Find the Average Salary 
SELECT * FROM Employee;

SELECT AVG(salary) as 'Average Salary of Employees' FROM Employee;
--4. Find the Highest and Lowest Salary 
SELECT * FROM Employee;

SELECT MIN(salary) as 'Lowest Salary of Employees', MAX(salary) as 'Highest Salary of Employees'  FROM Employee;

------------------------------------------------------------GROUP BY ---------------------------------------------------------
--Example 1: Group By Single Column (Employee name with total salary) 
SELECT * FROM Employee;

SELECT SUM(salary) as 'Total Salary of Employees' FROM Employee GROUP BY name;
--Example 2: Group By Multiple Columns (Student subject and year) 
SELECT * FROM Student;

SELECT year, subject FROM Student GROUP BY subject, year;

--------------------------------------------------------------------------HAVING -------------------------------------------------------------------
--Example 1: Departments with total salary ≥ 100,000 
SELECT * FROM Employee;

SELECT SUM(salary)as 'Total Salary', department  FROM Employee GROUP BY department HAVING SUM(salary) >= 100000;
--Example 2: Subjects with more than 1 student in any year 
SELECT * FROM Student;

SELECT count (subject) as 'Studen number in the subject' FROM Student GROUP BY year HAVING count(id) > 1;