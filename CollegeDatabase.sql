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

----------------------------------------------------------------

----INSERT DATA TO Department TABLE 

INSERT INTO Department (Department_Name)
VALUES
('Human Resources'),
('Finance'),
('Engineering'),
('Marketing'),
('IT Support');

SELECT * FROM Department;

----INSERT DATA TO Faculty TABLE 
INSERT INTO Faculty (F_Name, Salary, D_id)
VALUES
('Dr. Alice Morgan', 75000, 1),
('Dr. Brian Lee', 82000, 2),
('Dr. Clara Evans', 79000, 3),
('Dr. Daniel Chen', 81000, 4),
('Dr. Emma Stone', 77000, 5);

SELECT * FROM Faculty;

----INSERT DATA TO Students TABLE 
INSERT INTO Students (Fname, Lname, DOB, City, S_State, Pin_code, F_id)
VALUES
('James', 'Walker', '2002-03-15', 'New York', 'NY', '10001', 1),
('Sophia', 'Mitchell', '2001-07-22', 'Chicago', 'IL', '60601', 2),
('Liam', 'Anderson', '2003-01-10', 'San Francisco', 'CA', '94102', 3),
('Olivia', 'Turner', '2002-11-05', 'Austin', 'TX', '73301', 4),
('Noah', 'Campbell', '2001-09-30', 'Seattle', 'WA', '98101', 5);

SELECT * FROM Students;

----INSERT DATA TO Faculty_Mobile_Numbers TABLE 
INSERT INTO Faculty_Mobile_Numbers (Mobile_Number, F_id) VALUES
(99235645, 1),
(91234567, 2),
(90011223, 3),
(98877665, 4),
(99887766, 5);

--I input "9988776655" --> 10 number as Mobile_Number column which has data type int and when I run the insertion I get this error 
--"Arithmetic overflow error converting expression to data type int." which mean that the input is bigger than the data type range so I 
-- I change the input value for Mobile_Number column to 88877665 --> 9 number

SELECT * FROM Faculty_Mobile_Numbers;

----INSERT DATA TO Students_Mobile_Numbers TABLE 
INSERT INTO Students_Mobile_Numbers (Mobile_Number, S_id) VALUES
(99235005, 1),
(91234567, 2),
(90077223, 3),
(98877115, 4),
(99457766, 5);

SELECT * FROM Students_Mobile_Numbers;

----INSERT DATA TO Subject TABLE 
INSERT INTO Subject (Subject_Name, F_id) VALUES
('Mathematics', 1),
('Physics', 2),
('Chemistry', 3),
('Computer Science', 4),
('English Literature', 5);

SELECT * FROM Subject;

----INSERT DATA TO Hostel TABLE 
INSERT INTO Hostel (Hostel_Name, Number_of_Seats, S_id) VALUES
('A-Block', 100, 1),
('B-Block', 120, 2),
('A-Block', 90, 3),
('D-Block', 110, 4),
('C-Block', 80, 5);

SELECT * FROM Hostel;

--to delete all the data in the table without deleting the table
TRUNCATE TABLE Hostel;

----INSERT DATA TO Course TABLE 
INSERT INTO Course (Course_Name, Duration, D_id) VALUES
('BSc Mathematics', '03:00:00', 1),
('BSc Physics', '03:00:00', 2),
('BSc Chemistry', '03:00:00', 3),
('BSc Computer Science', '03:00:00', 4),
('BA English', '03:00:00', 5);

SELECT * FROM Course;

----INSERT DATA TO Exam TABLE 
INSERT INTO Exam (Room, Exam_Time, Exam_Date, D_id) VALUES
('Room A101', '09:00:00', '2025-06-01', 1),
('Room B202', '11:00:00', '2025-06-02', 2),
('Room C303', '13:00:00', '2025-06-03', 3),
('Room D404', '10:30:00', '2025-06-04', 4),
('Room E505', '14:00:00', '2025-06-05', 5);

SELECT * FROM Exam;

----INSERT DATA TO Students_Course TABLE 
-- Student 1 in Courses 1, 2, 3
INSERT INTO Students_Course (S_id, Course_id) VALUES (1, 1);
INSERT INTO Students_Course (S_id, Course_id) VALUES (1, 2);
INSERT INTO Students_Course (S_id, Course_id) VALUES (1, 3);

-- Student 2 in Courses 2, 3, 4
INSERT INTO Students_Course (S_id, Course_id) VALUES (2, 2);
INSERT INTO Students_Course (S_id, Course_id) VALUES (2, 3);
INSERT INTO Students_Course (S_id, Course_id) VALUES (2, 4);

-- Student 3 in Courses 3, 4, 5
INSERT INTO Students_Course (S_id, Course_id) VALUES (3, 3);
INSERT INTO Students_Course (S_id, Course_id) VALUES (3, 4);
INSERT INTO Students_Course (S_id, Course_id) VALUES (3, 5);

-- Student 4 in Courses 1, 4, 5
INSERT INTO Students_Course (S_id, Course_id) VALUES (4, 1);
INSERT INTO Students_Course (S_id, Course_id) VALUES (4, 4);
INSERT INTO Students_Course (S_id, Course_id) VALUES (4, 5);

-- Student 5 in Courses 1, 2, 5
INSERT INTO Students_Course (S_id, Course_id) VALUES (5, 1);
INSERT INTO Students_Course (S_id, Course_id) VALUES (5, 2);
INSERT INTO Students_Course (S_id, Course_id) VALUES (5, 5);


SELECT * FROM Students_Course;

--------------------------------------------------------------TASK 8------------------------------------------------------------
--1. Display the department ID, name, and the full name of the faculty managing it. 
SELECT * FROM Department;
SELECT * FROM Faculty;

SELECT D.*, F.F_Name as 'Faculty_Name'
FROM Department D, Faculty F
WHERE D.Department_id = F.D_id;

--2. Display each program's name and the name of the department offering it. 
SELECT * FROM Department;
SELECT * FROM Course;

SELECT C.Course_Name, D.Department_Name
FROM Department D, Course C
WHERE D.Department_id = C.D_id;

--3. Display the full student data and the full name of their faculty advisor. 
SELECT * FROM Students;
SELECT * FROM Faculty;

SELECT S.*, F.F_Name as 'Faculty_Name'
FROM Students S, Faculty F
WHERE F.F_id = S.F_id;

--4. Display class IDs, course titles, and room locations for classes in buildings 'A' or 'B'. 
--SELECT * FROM Course;
--SELECT * FROM Exam;
--SELECT * FROM Subject;

--5. Display full data about courses whose titles start with "I" (e.g., "Introduction to..."). 
SELECT * FROM Course;
INSERT INTO Course (Course_Name, Duration, D_id) VALUES ('Introduction to life', '03:00:00.0000000', 1);
SELECT * FROM Course WHERE Course_Name LIKE 'I%';

--6. Display names of students in program ID 3 whose GPA is between 2.5 and 3.5. 
SELECT * FROM Course;
SELECT * FROM Students;
SELECT * FROM Department;
SELECT * FROM Faculty;

SELECT (S.Fname + ' ' + S.Lname) as 'Student Name'
FROM Students S INNER JOIN Faculty F ON F.F_id = S.F_id INNER JOIN Department D ON D.Department_id = F.D_id INNER JOIN  Course C ON D.Department_id = C.D_id
WHERE C.Course_id = 3;

--7. Retrieve student names in the Engineering program who earned grades ≥ 90 in the "Database" course. 
--SELECT * FROM Course;
--SELECT * FROM Students;
--SELECT * FROM Subject;

--8. Find names of students who are advised by "Dr. Ahmed Hassan". 
SELECT * FROM Students;
SELECT * FROM Faculty;


SELECT (S.Fname + ' ' + S.Lname) as 'Student Name'
FROM Students S INNER JOIN Faculty F
ON F.F_id = S.F_id
WHERE F.F_Name = 'Dr. Alice Morgan';

--9. Retrieve each student's name and the titles of courses they are enrolled in, ordered by course title. 
SELECT * FROM Students;
SELECT * FROM Subject;
SELECT * FROM Faculty;

SELECT (S.Fname + ' ' + S.Lname) as 'Student Name', SU.Subject_Name as 'Subject Name'
FROM Students S INNER JOIN Faculty F ON F.F_id = S.F_id INNER JOIN Subject SU ON F.F_id = SU.F_id
ORDER BY SU.Subject_Name;

--10. For each class in Building 'Main', retrieve class ID, course name, department name, and faculty name teaching the class. 
--11. Display all faculty members who manage any department. 
SELECT * FROM Department;
SELECT * FROM Faculty;

SELECT F.F_Name as 'Faculty', D.Department_Name as 'Department They Manage'
FROM Department D, Faculty F
WHERE D.Department_id = F.D_id;

--12. Display all students and their advisors' names, even if some students don’t have advisors yet. 
SELECT * FROM Students;
SELECT * FROM Faculty;

SELECT (S.Fname + ' ' + S.Lname) as 'Student Name', F.F_Name as 'Faculty'
FROM Students S, Faculty F
WHERE F.F_id = S.F_id;

-------------------------------------------------------TASK 9-------------------------------------------------
--6.  Count total number of students in the Student table. 
SELECT count(S_id) as 'Total Number of Students' FROM Students;

--7. Count number of students per city (group by City in Student).
SELECT * FROM Students;
SELECT count(S_id) as 'Total Number of Students Per City' FROM Students GROUP BY City;
--8. Count students per course using Enrols (group by CourseID). 
SELECT * FROM Students;
SELECT * FROM Course;
SELECT * FROM Students_Course;
SELECT count(S.S_id) as 'Total Number of Students Per Course' 
FROM Students S INNER JOIN Students_Course SC ON S.S_id = SC.S_id
INNER JOIN Course C ON C.Course_id = SC.Course_id
GROUP BY C.Course_id;
--9. Count number of courses per department using Course (group by DepartmentID). 
SELECT * FROM Course;
SELECT * FROM Department;

SELECT count(C.Course_id) as 'Number of Courses Per Department'
FROM Department D INNER JOIN Course C ON D.Department_id = C.D_id
GROUP BY D.Department_id;
--10.  Count number of students assigned to each hostel (group by HostelID). 
SELECT * FROM Students;
SELECT * FROM Hostel;

SELECT count(S.S_id) as 'Number of Students Per Hostel'
FROM Students S INNER JOIN Hostel H ON S.S_id = H.S_id
GROUP BY H.Hostel_id;