--Create database ---> CREATE DATABASE DatabaseName;
CREATE DATABASE CompanyManagmenet;

--Use database ---> USE DatabaseName;
USE CompanyManagmenet;

--Create table --->

--Create Employee table
CREATE TABLE Employee (
    SSN int PRIMARY KEY identity(1,1) NOT NULL, -- identity --> mean it increint by it's own --> identity(start, amount of increint)
    Fname varchar(255) NOT NULL,
	Minit varchar(255), --medil name
    Lname varchar(255) NOT NULL,
	Bdate Date NOT NULL,
	EAddress varchar(255) NOT NULL,
	Sex varchar(255) NOT NULL, --gender
	Salary int CONSTRAINT CHECK_EMPLOYEE_SALARY CHECK (Salary > 0),
	Super_ssn int, foreign key(Super_ssn) references Employee(SSN) --to set foreign key foreign key(colunmName in the child table) references TableName(colunmName in the main table)
);

--Create Department table
CREATE TABLE Department (
    Dnumber int PRIMARY KEY identity(1,1) NOT NULL,
    Dname varchar(255) NOT NULL,
	Mgr_start_date Date NOT NULL,
	Mgr_ssn int, foreign key(Mgr_ssn) references Employee(SSN) 
);

--Create Project table
CREATE TABLE Project (
    Pnumber int PRIMARY KEY identity(1,1) NOT NULL,
    Dname varchar(255) NOT NULL,
	Plocation varchar(255) NOT NULL,
	Dnum int, foreign key(Dnum) references Department(Dnumber) 
);


--Create Dpart_Location table
CREATE TABLE Dpart_Location (
	Dlocation varchar(255) NOT NULL,
	Dnumber int, foreign key(Dnumber) references Department(Dnumber),
	PRIMARY KEY (Dnumber, Dlocation)
);

--Create Works_On table
CREATE TABLE Works_On (
	Essn int, foreign key(Essn) references Employee(SSN),
	Pno int, foreign key(Pno) references Project(Pnumber),
	PRIMARY KEY (Essn, Pno),
	Hours int NOT NULL
);

--Create Dependent table
CREATE TABLE Dependent (
    Dependent_Name varchar(255) NOT NULL,
	Relationship varchar(255) NOT NULL,
	Bdate Date NOT NULL,
	Sex varchar(255) NOT NULL, --gender
	Essn int, foreign key(Essn) references Employee(SSN),
	PRIMARY KEY (Essn, Dependent_Name)
);


--to alter table
ALTER TABLE Employee
ADD Dno int foreign key(Dno) references Department(Dnumber);

--To add a new CONSTRAINT to column
ALTER TABLE Employee
ALTER COLUMN Dno INT NOT NULL


----------------------------------------------------------------------------------------------------------------------------

--INSERT DATA TO Department TABLE
INSERT INTO Department (Dname,Mgr_start_date, Mgr_ssn)
VALUES
('Human Resources', '2020-01-15', NULL),
('Finance', '2019-03-10', NULL),
('Engineering', '2018-07-01', NULL),
('Marketing', '2021-06-20', NULL),
('IT Support', '2022-02-05', NULL);

SELECT * FROM Department;

SELECT * FROM Employee;

--INSERT DATA TO Employee TABLE super_SSN record
INSERT INTO Employee (Fname, Minit, Lname, Bdate, EAddress, Sex, Salary, Super_ssn, Dno)
VALUES 
('John', 'A', 'Smith', '1985-04-12', '123 Elm St', 'M', 55000, NULL, 2);
--INSERT DATA TO Employee TABLE 
INSERT INTO Employee (Fname, Minit, Lname, Bdate, EAddress, Sex, Salary, Super_ssn, Dno)
VALUES 
('Jane', 'B', 'Doe', '1990-08-23', '456 Oak St', 'F', 60000, 15, 3),
('Alice', 'C', 'Johnson', '1987-02-15', '789 Maple St', 'F', 62000, 15, 4),
('Bob', 'D', 'Brown', '1992-11-05', '101 Pine St', 'M', 58000, 15, 2),
('Eve', 'E', 'Davis', '1995-06-30', '202 Birch St', 'F', 54000, 15, 6);

UPDATE Department 
SET Mgr_ssn = 15;

----INSERT DATA TO Project TABLE 
INSERT INTO Project (Dname, Plocation, Dnum)
VALUES
('Recruitment System', 'New York', 2),
('Budget Tracker', 'Chicago', 3),
('AI Research', 'San Francisco', 4),
('Brand Campaign', 'Los Angeles', 5),
('Tech Support Portal', 'Houston', 6);

SELECT * FROM Project;

----INSERT DATA TO Dpart_Location TABLE 
INSERT INTO Dpart_Location (Dlocation, Dnumber)
VALUES
('New York', 2),
('Chicago', 3),
('San Francisco', 4),
('Los Angeles', 5),
('Houston', 6);

INSERT INTO Dpart_Location (Dlocation, Dnumber)
VALUES ('Boston', 2); -- Additional location for department 2

SELECT * FROM Dpart_Location;

----INSERT DATA TO Works_On TABLE 
INSERT INTO Works_On (Essn, Pno, Hours)
VALUES
(15, 1, 20),
(16, 2, 25),
(17, 3, 30),
(18, 4, 15),
(19, 5, 10);

SELECT * FROM Works_On;