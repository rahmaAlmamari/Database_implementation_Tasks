CREATE DATABASE CollegeManagmenet;

USE CollegeManagmenet;

--Create Department table
CREATE TABLE Department (
    Department_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Department_Name varchar(255) NOT NULL
);

--Create Faculty table
CREATE TABLE Faculty (
    F_id int PRIMARY KEY identity(1,1) NOT NULL, 
    F_Name varchar(255) NOT NULL,
	Salary int CONSTRAINT CHECK_EMPLOYEE_SALARY CHECK (Salary > 0),
	D_id int, foreign key(D_id) references Department(Department_id) 
);

--Create Students table
CREATE TABLE Students (
    S_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Fname varchar(255) NOT NULL,
    Lname varchar(255) NOT NULL,
	DOB Date NOT NULL,
	City varchar(255) NOT NULL,
	S_State varchar(255) NOT NULL,
	Pin_code varchar(255) NOT NULL,
	F_id int, foreign key(F_id) references Faculty(F_id)
);

--Create Faculty_Mobile_Numbers table
CREATE TABLE Faculty_Mobile_Numbers (
	Mobile_Number int NOT NULL,
	F_id int, foreign key(F_id) references Faculty(F_id),
	PRIMARY KEY (F_id, Mobile_Number)
);

--Create Students_Mobile_Numbers table
CREATE TABLE Students_Mobile_Numbers (
	Mobile_Number int NOT NULL,
	S_id int, foreign key(S_id) references Students(S_id),
	PRIMARY KEY (S_id, Mobile_Number)
);

--Create Subject table
CREATE TABLE Subject (
    Subject_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Subject_Name varchar(255) NOT NULL,
	F_id int, foreign key(F_id) references Faculty(F_id) 
);

--Create Hostel table
CREATE TABLE Hostel (
    Hostel_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Hostel_Name varchar(255) NOT NULL,
	Number_of_Seats int NOT NULL,
	S_id int, foreign key(S_id) references Students(S_id) 
);

--Create Course table
CREATE TABLE Course (
    Course_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Course_Name varchar(255) NOT NULL,
	Duration Time NOT NULL,
	D_id int, foreign key(D_id) references Department(Department_id) 
);

--Create Exam table
CREATE TABLE Exam (
    Exam_Code int PRIMARY KEY identity(1,1) NOT NULL, 
    Room varchar(255) NOT NULL,
	Exam_Time Time NOT NULL,
	Exam_Date Date NOT NULL,
	D_id int, foreign key(D_id) references Department(Department_id) 
);

--Create Students_Course table
CREATE TABLE Students_Course (
	S_id int, foreign key(S_id) references Students(S_id), 
	Course_id int, foreign key(Course_id) references Course(Course_id),
	PRIMARY KEY (S_id, Course_id)
);