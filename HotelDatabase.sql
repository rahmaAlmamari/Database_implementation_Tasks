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