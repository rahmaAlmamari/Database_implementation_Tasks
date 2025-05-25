CREATE DATABASE SubqueryDatabaseTask;
USE SubqueryDatabaseTask;
--Tables -- Trainees Table 
CREATE TABLE Trainees ( 
TraineeID INT PRIMARY KEY, 
FullName VARCHAR(100), 
Email VARCHAR(100), 
Program VARCHAR(50), 
GraduationDate DATE 
); 
-- Job Applicants Table 
CREATE TABLE Applicants ( 
ApplicantID INT PRIMARY KEY, 
FullName VARCHAR(100), 
Email VARCHAR(100), 
Source VARCHAR(20), -- e.g., "Website", "Referral" 
AppliedDate DATE 
); 
--Sample Data -- Insert into Trainees 
INSERT INTO Trainees VALUES 
(1, 'Layla Al Riyami', 'layla.r@example.com', 'Full Stack .NET', '2025-04-30'), 
(2, 'Salim Al Hinai', 'salim.h@example.com', 'Outsystems', '2025-03-15'), 
(3, 'Fatma Al Amri', 'fatma.a@example.com', 'Database Admin', '2025-05-01'); -- Insert into Applicants 
INSERT INTO Applicants VALUES 
(101, 'Hassan Al Lawati', 'hassan.l@example.com', 'Website', '2025-05-02'), 
(102, 'Layla Al Riyami', 'layla.r@example.com', 'Referral', '2025-05-05'), -- same person as trainee 
(103, 'Aisha Al Farsi', 'aisha.f@example.com', 'Website', '2025-04-28');

---------------------------------------------Practice Scenario: Training & Job Application System-----------------------------
--Part 1: UNION Practice 
--1. List all unique people who either trained or applied for a job. 
--    o Show their full names and emails. 
--    o Use UNION (not UNION ALL) to avoid duplicates. 
SELECT FullName, Email
FROM Trainees
UNION
SELECT FullName, Email
FROM Applicants;

--2. Now use UNION ALL. What changes in the result? 
--    o Explain why one name appears twice. 
SELECT FullName, Email
FROM Trainees
UNION all
SELECT FullName, Email
FROM Applicants;

--it show the result with duplaicat 


--3. Find people who are in both tables. 
--    o You must use INTERSECT if supported, or simulate it using INNER JOIN on Email. 
SELECT Email
FROM Trainees
INTERSECT
SELECT Email
FROM Applicants;