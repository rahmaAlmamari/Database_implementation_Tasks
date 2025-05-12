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



