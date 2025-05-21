CREATE DATABASE AirlineManagmenet;

USE AirlineManagmenet;

----------------------------------------------------------------------DDL-------------------------------------------------------------

--Create Airport table
CREATE TABLE Airport (
    Airport_code int PRIMARY KEY identity(1,1) NOT NULL, 
    Airport_Name varchar(255) NOT NULL,
	City varchar(255) NOT NULL,
	State varchar(255) NOT NULL
);

--Create Airplane_Type table
CREATE TABLE Airplane_Type (
    Airplane_Type_Name varchar PRIMARY KEY NOT NULL, 
    Company varchar(255) NOT NULL,
    Max_Seats int NOT NULL
);

--to change the reange of primary key "Airplane_Type_Name"

---- 1. DROP the constraint and column which linked to it 

-------------Airplane table

ALTER TABLE Airplane
DROP CONSTRAINT FK__Airplane__Airpla__3D5E1FD2;

ALTER TABLE Airplane
DROP COLUMN Airplane_Type_Name;

---------- Airport_Airplane_Type table
-------------- has two constraint

ALTER TABLE Airport_Airplane_Type
DROP CONSTRAINT FK__Airport_A__Airpl__5629CD9C;

ALTER TABLE Airport_Airplane_Type
DROP CONSTRAINT PK__Airport___7F5E3ED26B24AB32;

ALTER TABLE Airport_Airplane_Type
DROP COLUMN Airplane_Type_Name;

---- 2. add the change you want in "Airplane_Type_Name"
ALTER TABLE Airplane_Type
ALTER COLUMN Airplane_Type_Name VARCHAR (255) NOT NULL;

----- 3. add the constraint and column agina from where you delete it 
ALTER TABLE Airplane
ADD Airplane_Type_Name varchar(255) NOT NULL, foreign key(Airplane_Type_Name) references Airplane_Type(Airplane_Type_Name);

ALTER TABLE Airport_Airplane_Type
ADD Airplane_Type_Name varchar(255) NOT NULL, foreign key(Airplane_Type_Name) references Airplane_Type(Airplane_Type_Name);


--Create Flight table
CREATE TABLE Flight (
    Flight_Number int PRIMARY KEY identity(1,1) NOT NULL, 
    Airline varchar(255) NOT NULL,
    Weekdays int NOT NULL
);

--Create Airplane table
CREATE TABLE Airplane (
    Airplane_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Total_Number_of_Seats int NOT NULL,
	Airplane_Type_Name varchar NOT NULL, foreign key(Airplane_Type_Name) references Airplane_Type(Airplane_Type_Name),
);


--DROP TABLE Flight_Leg;

--Create Flight_Leg table
CREATE TABLE Flight_Leg (
    Leg_Number int PRIMARY KEY identity(1,1) NOT NULL,
	Scheduled_dep_time Time NOT NULL,
	Scheduled_arr_time Time NOT NULL,
	Airport_code int NOT NULL, foreign key(Airport_code) references Airport(Airport_code),
	Flight_Number int NOT NULL, foreign key(Flight_Number) references Flight(Flight_Number)
);

--to modify the primary key to composite primary key (Airport_code,Leg_Number,Flight_Number) -----
--1. drop the constraints linked to  primary key 
ALTER TABLE Leg_Instance
DROP CONSTRAINT FK__Leg_Insta__Leg_N__4D94879B;
--2. drop the primary key constraint
ALTER TABLE Flight_Leg
DROP CONSTRAINT PK__Flight_L__BBAF174FC2A1A0C0;
--3. add primary key as composite primary key (Airport_code,Leg_Number,Flight_Number)
ALTER TABLE Flight_Leg
ADD PRIMARY KEY(Leg_Number, Airport_code);

ALTER TABLE Flight_Leg
DROP CONSTRAINT [PK__Flight_L__F5BC1F74E8114F99];


--DROP TABLE Leg_Instance;

--Create Leg_Instance table
CREATE TABLE Leg_Instance (
    Leg_Instance_Date Date PRIMARY KEY NOT NULL,
    Dep_time Time NOT NULL,
	Arr_time Time NOT NULL,
	Number_of_Available_Seats int NOT NULL,
	Airport_code int NOT NULL, foreign key(Airport_code) references Airport(Airport_code),
	Airplane_id int NOT NULL, foreign key(Airplane_id) references Airplane(Airplane_id),
	Leg_Number int NOT NULL, foreign key(Leg_Number) references Flight_Leg(Leg_Number)
);

--to modify the primary key to composite primary key (Leg_Instance_Date, Airplane_id, Airport_code) -----
--1. drop the constraints linked to  primary key 
ALTER TABLE Seat
DROP CONSTRAINT [FK__Seat__Leg_Instan__5070F446];
--2. drop the primary key constraint
ALTER TABLE Leg_Instance
DROP CONSTRAINT [PK__Leg_Inst__5F1ED4C2A662BBDC];
--3. add primary key as composite primary key (Leg_Instance_Date,Airplane_id,Airport_code)
ALTER TABLE Leg_Instance
ADD PRIMARY KEY(Leg_Instance_Date,Airplane_id,Airport_code);

--to Foreign key composite to Leg_Number 
ALTER TABLE Leg_Instance
DROP CONSTRAINT [FK__Leg_Insta__Airpo__4BAC3F29];

ALTER TABLE Leg_Instance
ADD FOREIGN KEY (Leg_Number, Airport_code)
    REFERENCES Flight_Leg(Leg_Number, Airport_code);

ALTER TABLE Leg_Instance
ADD FOREIGN KEY (Airplane_id)
    REFERENCES Airplane(Airplane_id);



--Create Seat table
CREATE TABLE Seat (
    Seat_Number int PRIMARY KEY NOT NULL,
	C_phone int NOT NULL,
	C_Name varchar(255) NOT NULL,
	Leg_Instance_Date Date NOT NULL, foreign key(Leg_Instance_Date) references Leg_Instance(Leg_Instance_Date)
);

ALTER TABLE Seat
DROP CONSTRAINT [PK__Seat__D8AE52AF36E990FF];

ALTER TABLE Seat
ADD PRIMARY KEY(Seat_Number, Leg_Instance_Date);

ALTER TABLE Seat 
ADD Airport_code int NOT NULL, Airplane_id int NOT NULL;

ALTER TABLE Seat
ADD FOREIGN KEY (Leg_Instance_Date,Airplane_id,Airport_code)
    REFERENCES Leg_Instance(Leg_Instance_Date,Airplane_id,Airport_code);



--Create Fare table
CREATE TABLE Fare (
    Code int PRIMARY KEY identity(1,1) NOT NULL,
	Amount int NOT NULL,
	Restrictions varchar(255) NOT NULL,
	Flight_Number int NOT NULL, foreign key(Flight_Number) references Flight(Flight_Number)
);

ALTER TABLE Fare
DROP CONSTRAINT [PK__Fare__A25C5AA6763239A9];

ALTER TABLE Fare
ADD PRIMARY KEY(Code, Flight_Number);


--Create Airport_Airplane_Type table
CREATE TABLE Airport_Airplane_Type (
	Airport_code int NOT NULL, foreign key(Airport_code) references Airport(Airport_code),
	Airplane_Type_Name varchar NOT NULL, foreign key(Airplane_Type_Name) references Airplane_Type(Airplane_Type_Name)
);

--to add PRIMARY KEY to Airport_Airplane_Type
ALTER TABLE Airport_Airplane_Type
ADD PRIMARY KEY(Airport_code, Airplane_Type_Name);

------------------------------------------------------------------------DML-----------------------------------------------------------------------------

--insert data to Airport table 
INSERT INTO Airport (Airport_Name, City, State) VALUES
('Muscat International Airport', 'Muscat', 'Muscat Governorate'),
('King Khalid International Airport', 'Riyadh', 'Riyadh Region'),
('King Abdulaziz International Airport', 'Jeddah', 'Makkah Region'),
('King Fahd International Airport', 'Dammam', 'Eastern Province'),
('Prince Mohammad bin Abdulaziz International Airport', 'Medina', 'Medina Region'),
('Abha International Airport', 'Abha', 'Asir Region');

SELECT * FROM Airport;

--insert data to Airplane_Type table 
INSERT INTO Airplane_Type (Airplane_Type_Name, Company, Max_Seats) VALUES
('Boeing 737', 'Boeing', 189),
('Airbus A320', 'Airbus', 180),
('Boeing 777', 'Boeing', 396),
('Airbus A350', 'Airbus', 350),
('Embraer E195', 'Embraer', 132);

SELECT * FROM Airplane_Type;

--insert data to Flight table 
INSERT INTO Flight (Airline, Weekdays) VALUES
('Saudia', 127),          -- Daily (binary 1111111)
('Qatar Airways', 62),    -- Monday to Friday (binary 0111110)
('Emirates', 65),         -- Sunday and Saturday (binary 1000001)
('Oman Air', 4),          -- Tuesday only (binary 0000100)
('Etihad Airways', 28);   -- Wednesday to Friday (binary 0011100)

SELECT * FROM Flight;

--insert data to Airplane table 
INSERT INTO Airplane (Total_Number_of_Seats, Airplane_Type_Name) VALUES
(180, 'Airbus A320'),
(350, 'Airbus A350'),
(189, 'Boeing 737'),
(396, 'Boeing 777'),
(132, 'Embraer E195');

SELECT * FROM Airplane;

--insert data to Flight_Leg table 
INSERT INTO Flight_Leg (Scheduled_dep_time, Scheduled_arr_time, Airport_code, Flight_Number) VALUES
('08:00:00', '10:00:00', 1, 1),
('12:15:00', '14:45:00', 2, 2),
('09:30:00', '13:00:00', 3, 3),
('16:00:00', '18:30:00', 4, 4),
('06:45:00', '09:15:00', 5, 5);

SELECT * FROM Flight_Leg;

--insert data to Leg_Instance table 
INSERT INTO Leg_Instance (Leg_Instance_Date, Dep_time, Arr_time, Number_of_Available_Seats, Airport_code, Airplane_id, Leg_Number) VALUES
('2025-06-01', '08:00:00', '10:00:00', 150, 1, 1, 1),
('2025-06-02', '12:30:00', '14:45:00', 140, 2, 2, 2),
('2025-06-03', '09:15:00', '11:45:00', 175, 3, 3, 3),
('2025-06-04', '16:00:00', '18:20:00', 190, 4, 4, 4),
('2025-06-05', '06:45:00', '09:00:00', 120, 5, 5, 5);

SELECT * FROM Leg_Instance;

--insert data to Seat table 
INSERT INTO Seat (Seat_Number, C_phone, C_Name, Leg_Instance_Date, Airport_code, Airplane_id) VALUES
(1, 92478345, 'Ahmed Al-Saadi', '2025-06-01', 1, 1),
(2, 96651234, 'Sara Al-Harbi', '2025-06-02', 2, 2),
(3, 96651234, 'Mohammed Al-Qahtani', '2025-06-03', 3, 3),
(4, 96651234, 'Layla Al-Otaibi', '2025-06-04', 4, 4),
(5, 96651234, 'Faisal Al-Dossari', '2025-06-05', 5, 5);

SELECT * FROM Seat;

--insert data to Fare table 
INSERT INTO Fare (Amount, Restrictions, Flight_Number) VALUES
(450, 'Non-refundable, no date change', 1),
(600, 'Refundable with fee, date change allowed', 2),
(350, 'Non-refundable, baggage not included', 3),
(800, 'Fully refundable, includes meals and baggage', 4),
(500, 'Non-refundable, date change allowed with fee', 5);

SELECT * FROM Fare;

--insert data to Airport_Airplane_Type table 
INSERT INTO Airport_Airplane_Type (Airport_code, Airplane_Type_Name) VALUES
(1, 'Airbus A320'),      -- Muscat International Airport
(2, 'Boeing 737'),       -- King Khalid International Airport
(3, 'Airbus A350'),      -- King Abdulaziz International Airport
(4, 'Boeing 777'),       -- King Fahd International Airport
(5, 'Embraer E195');     -- Prince Mohammad bin Abdulaziz International Airport

SELECT * FROM Airport_Airplane_Type;

-----------------------------------------------------------------------TASK 8-------------------------------------------------------
--1. Display each flight leg's ID, schedule, and the name of the airplane assigned to it. 
SELECT * FROM Flight_Leg;
SELECT * FROM Airplane;

SELECT FL.Leg_Number as 'Flight Leg ID', FL.Scheduled_arr_time as 'Schedule Arr', FL.Scheduled_dep_time as 'Schedule Dep', AP.Airplane_id as 'Airplane Assigned To'
FROM Flight_Leg FL, Airplane AP
WHERE AP.Airplane_id = FL.Airport_code;

--2. Display all flight numbers and the names of the departure and arrival airports.
SELECT * FROM Flight;
SELECT * FROM Airport;
SELECT * FROM Flight_Leg;

SELECT F.Flight_Number, AP.Airport_Name
FROM Flight F INNER JOIN Flight_Leg FL ON F.Flight_Number = FL.Flight_Number INNER JOIN Airport AP ON AP.Airport_code = FL.Airport_code;

--3. Display all reservation data with the name and phone of the customer who made each booking. 
SELECT * FROM Seat;

--4. Display IDs and locations of flights departing from 'CAI' or 'DXB'. 
SELECT * FROM Flight_Leg;
SELECT * FROM Flight;

--5. Display full data of flights whose names start with 'A'. 
SELECT * FROM Flight;

SELECT * FROM Flight WHERE Flight.Airline LIKE '%s';

--6. List customers who have bookings with total payment between 3000 and 5000. 
--7. Retrieve all passengers on 'Flight 110' who booked more than 2 seats. 
SELECT * FROM Flight;
SELECT * FROM Seat;
SELECT * FROM Flight_Leg;
SELECT * FROM Airport;

SELECT S.C_Name as 'Customer Name', S.C_phone as 'Customer Phone'
FROM Flight F INNER JOIN Flight_Leg FL ON F.Flight_Number = FL.Flight_Number 
INNER JOIN Airport AP ON AP.Airport_code = FL.Airport_code 
INNER JOIN Seat S ON AP.Airport_code = S.Airport_code
WHERE F.Flight_Number = 1;

--8. Find names of passengers whose booking was handled by agent "Youssef Hamed". 
--9. Display each passenger’s name and the flights they booked, ordered by flight date. 
SELECT * FROM Flight;
SELECT * FROM Seat;
SELECT * FROM Flight_Leg;
SELECT * FROM Airport;

SELECT S.C_Name as 'Customer Name', F.Flight_Number as 'Flight Number'
FROM Flight F INNER JOIN Flight_Leg FL ON F.Flight_Number = FL.Flight_Number 
INNER JOIN Airport AP ON AP.Airport_code = FL.Airport_code 
INNER JOIN Seat S ON AP.Airport_code = S.Airport_code
ORDER BY S.Leg_Instance_Date;

--10. For each flight departing from 'Cairo', display the flight number, departure time, and airline name. 
SELECT * FROM Flight;
SELECT * FROM Flight_Leg;

SELECT F.Flight_Number, FL.Scheduled_dep_time, FL.Scheduled_arr_time, F.Airline
FROM Flight F, Flight_Leg FL
WHERE F.Flight_Number = FL.Flight_Number;

--11. Display all staff members who are assigned as supervisors for flights. 
--12. Display all bookings and their related passengers, even if some bookings are unpaid. 
