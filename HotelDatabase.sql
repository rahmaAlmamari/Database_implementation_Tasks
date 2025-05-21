CREATE DATABASE HotelManagmenet;

USE HotelManagmenet;


------------------------------------------------------------DDL-------------------------------------------------------------
--Create Branch table
CREATE TABLE Branch (
    Branch_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Branch_Name varchar(255) NOT NULL,
	Location varchar(255) NOT NULL
);

--Create Customer table
CREATE TABLE Customer (
    Customer_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Customer_Name varchar(255) NOT NULL,
	Customer_email varchar(255) NOT NULL
);

--Create Rooms table
CREATE TABLE Rooms (
    Room_Number int PRIMARY KEY identity(1,1) NOT NULL, 
    Room_Type varchar(255) NOT NULL,
	Nightly_Rate int NOT NULL,
	Branch_id int NOT NULL, foreign key(Branch_id) references Branch(Branch_id),
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id)
);

--Create Staff table
CREATE TABLE Staff (
    Staff_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Staff_Name varchar(255) NOT NULL,
	Job_Title varchar(255) NOT NULL,
	Branch_id int NOT NULL, foreign key(Branch_id) references Branch(Branch_id)
);


--Create Booking table
CREATE TABLE Booking (
    Booking_id int PRIMARY KEY identity(1,1) NOT NULL, 
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id),
	Room_Number int NOT NULL, foreign key(Room_Number) references Rooms(Room_Number),
    Check_in_Date Date NOT NULL,
	Check_out_Date Date NOT NULL
);

ALTER TABLE Booking
DROP CONSTRAINT [PK__Booking__35AAE1F8B0A0D1FA];

ALTER TABLE Booking
ADD PRIMARY KEY(Booking_id, Customer_id, Room_Number);

--Create "Staff_Check_Out_Booking" table
CREATE TABLE Booking_Check_Out_Booking (
	Booking_id int NOT NULL, foreign key(Booking_id) references Booking(Booking_id),
	Staff_id int NOT NULL, foreign key(Staff_id) references Staff(Staff_id),
    Check_in Date NOT NULL,
	Check_out Date NOT NULL
);

ALTER TABLE Staff_Check_Out_Booking
ADD PRIMARY KEY(Booking_id, Staff_id);

ALTER TABLE Booking_Check_Out_Booking
DROP CONSTRAINT [PK__Booking___9687CF7DC125A9A4];

ALTER TABLE Booking_Check_Out_Booking
DROP CONSTRAINT [FK__Booking_C__Booki__44FF419A];

ALTER TABLE Staff_Check_Out_Booking
ADD  foreign key(Booking_id, Customer_id, Room_Number) references Booking(Booking_id, Customer_id, Room_Number);

--to change table name from "Booking_Check_Out_Booking" to "Staff_Check_Out_Booking"
EXEC sp_rename "Booking_Check_Out_Booking", "Staff_Check_Out_Booking";

ALTER TABLE Staff_Check_Out_Booking
ADD Customer_id int NOT NULL, Room_Number int NOT NULL;



--Create Customer_Phone_Number table
CREATE TABLE Customer_Phone_Number (
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id),
    Customer_Phone int NOT NULL
);

ALTER TABLE Customer_Phone_Number
ADD PRIMARY KEY(Customer_id, Customer_Phone);


--------------------------------------------------------------------------DML--------------------------------------------------------

--to insert data into Branch table 
INSERT INTO Branch (Branch_Name, Location) VALUES
('Hilton Riyadh Branch', 'Riyadh, Saudi Arabia'),
('Marriott Jeddah Branch', 'Jeddah, Saudi Arabia'),
('Four Seasons Muscat Branch', 'Muscat, Oman'),
('InterContinental Dammam Branch', 'Dammam, Saudi Arabia'),
('Rotana Medina Branch', 'Medina, Saudi Arabia');

SELECT * FROM Branch;

--to insert data into Customer table 
INSERT INTO Customer (Customer_Name, Customer_email) VALUES
('Ahmed Al-Salem', 'ahmed.alsalem@example.com'),
('Layla Al-Harbi', 'layla.harbi@example.com'),
('Faisal Al-Qahtani', 'faisal.q@example.com'),
('Noura Al-Dossari', 'noura.dossari@example.com'),
('Khalid Al-Otaibi', 'khalid.otaibi@example.com');

SELECT * FROM Customer;

--to insert data into Rooms table 
INSERT INTO Rooms (Room_Type, Nightly_Rate, Branch_id, Customer_id) VALUES
('Deluxe Suite', 750, 1, 1),
('Standard Double', 450, 2, 2),
('Executive King', 900, 3, 3),
('Single Room', 300, 4, 4),
('Family Suite', 1100, 5, 5);

SELECT * FROM Rooms;

--to insert data into Staff table 
INSERT INTO Staff (Staff_Name, Job_Title, Branch_id) VALUES
('Sara Al-Mutairi', 'Front Desk Manager', 1),
('Omar Al-Zahrani', 'Housekeeping Supervisor', 2),
('Fatima Al-Qahtani', 'Executive Chef', 3),
('Yousef Al-Dosari', 'Concierge', 4),
('Mona Al-Fahad', 'Guest Services Agent', 5);

SELECT * FROM Staff;

--to insert data into Booking table 
INSERT INTO Booking (Customer_id, Room_Number, Check_in_Date, Check_out_Date) VALUES
(1, 1, '2025-07-01', '2025-07-05'),
(2, 2, '2025-07-02', '2025-07-06'),
(3, 3, '2025-07-03', '2025-07-07'),
(4, 4, '2025-07-04', '2025-07-08'),
(5, 5, '2025-07-05', '2025-07-09');

SELECT * FROM Booking;

--to insert data into Staff_Check_Out_Booking table 
INSERT INTO Staff_Check_Out_Booking (Booking_id, Staff_id, Check_in, Check_out, Customer_id, Room_Number) VALUES
(1, 1, '2025-07-01', '2025-07-05', 1, 1),
(2, 2, '2025-07-02', '2025-07-06', 2, 2),
(3, 3, '2025-07-03', '2025-07-07', 3, 3),
(4, 4, '2025-07-04', '2025-07-08', 4, 4),
(5, 5, '2025-07-05', '2025-07-09', 5, 5);

SELECT * FROM Staff_Check_Out_Booking;

----------------------------------------------------------------------TASK 8-------------------------------------------------
--1. Display hotel ID, name, and the name of its manager. 
SELECT * FROM Branch;
SELECT * FROM Staff;

SELECT B.Branch_id as 'Hotel ID', B.Branch_Name as 'Hotel Name', S.Staff_Name as 'Manager Name'
FROM Branch B, Staff S
WHERE B.Branch_id = S.Branch_id;

--2. Display hotel names and the rooms available under them. 
SELECT * FROM Branch;
SELECT * FROM Rooms;

SELECT  B.Branch_Name as 'Hotel Name', R.Room_Number as 'Rooms Available'
FROM Branch B, Rooms R
WHERE B.Branch_id = R.Branch_id;

--3. Display guest data along with the bookings they made. 
SELECT * FROM Customer;
SELECT * FROM Booking;

SELECT C.*, B.Booking_id, B.Room_Number, B.Check_in_Date, B.Check_out_Date
FROM Customer C, Booking B
WHERE C.Customer_id = B.Customer_id;

--4. Display bookings for hotels in 'Hurghada' or 'Sharm El Sheikh'. 
SELECT * FROM Staff_Check_Out_Booking;
SELECT * FROM Booking;
SELECT * FROM Branch;
SELECT * FROM Staff;

SELECT B.*
FROM Booking B INNER JOIN Staff_Check_Out_Booking SKOB ON B.Booking_id = SKOB.Booking_id 
INNER JOIN Staff S ON S.Staff_id = SKOB.Staff_id
INNER JOIN Branch H ON H.Branch_id = S.Branch_id
WHERE H.Branch_Name = 'Hilton Riyadh Branch';

--5. Display all room records where room type starts with "S" (e.g., "Suite", "Single"). 
SELECT * FROM Rooms WHERE Room_Type LIKE 'S%';

--6. List guests who booked rooms priced between 1500 and 2500 LE. 
SELECT * FROM Rooms;
SELECT * FROM Booking;
SELECT * FROM Customer;

SELECT C.*
FROM Customer C INNER JOIN Rooms R ON C.Customer_id = R.Customer_id
INNER JOIN Booking B ON C.Customer_id = B.Customer_id
WHERE R.Nightly_Rate between 500 and 2500;

--7. Retrieve guest names who have bookings marked as 'Confirmed' in hotel "Hilton Downtown". 
SELECT * FROM Branch;
SELECT * FROM Booking;
SELECT * FROM Customer;
SELECT * FROM Rooms;

SELECT C.Customer_Name
FROM Booking B INNER JOIN Customer C ON C.Customer_id = B.Customer_id 
INNER JOIN Rooms R ON  R.Customer_id = C.Customer_id
INNER JOIN Branch H ON H.Branch_id = R.Branch_id
WHERE H.Location = 'Riyadh, Saudi Arabia';

--8. Find guests whose bookings were handled by staff member "Mona Ali". 
SELECT * FROM Staff;
SELECT * FROM Booking;
SELECT * FROM Customer;
SELECT * FROM Rooms;
SELECT * FROM Branch;

SELECT C.Customer_Name
FROM Booking B INNER JOIN Customer C ON C.Customer_id = B.Customer_id 
INNER JOIN Rooms R ON  R.Customer_id = C.Customer_id
INNER JOIN Branch H ON H.Branch_id = R.Branch_id
INNER JOIN Staff S ON H.Branch_id = S.Branch_id
WHERE S.Staff_Name = 'Sara Al-Mutairi';

--9. Display each guest’s name and the rooms they booked, ordered by room type. 
SELECT * FROM Customer;
SELECT * FROM Rooms;

SELECT C.Customer_Name, R.Room_Number
FROM Customer C, Rooms R
WHERE C.Customer_id = R.Customer_id
ORDER BY R.Room_Type;

--10. For each hotel in 'Cairo', display hotel ID, name, manager name, and contact info. 
SELECT * FROM Branch;
SELECT * FROM Staff;

SELECT B.Branch_id, B.Branch_Name, S.Staff_Name
FROM Branch B, Staff S
WHERE B.Branch_id = S.Branch_id;

--11. Display all staff members who hold 'Manager' positions. 

SELECT * FROM Staff WHERE Branch_id IS NOT NULL;

--12. Display all guests and their reviews, even if some guests haven't submitted any reviews. 
