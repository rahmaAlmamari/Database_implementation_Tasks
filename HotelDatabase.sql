CREATE DATABASE HotelManagmenet;

USE HotelManagmenet;

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


--Create Staff_ table
CREATE TABLE Booking_Check_Out_Booking (
	Booking_id int NOT NULL, foreign key(Booking_id) references Booking(Booking_id),
	Staff_id int NOT NULL, foreign key(Staff_id) references Staff(Staff_id),
    Check_in Date NOT NULL,
	Check_out Date NOT NULL
);

ALTER TABLE Booking_Check_Out_Booking
ADD PRIMARY KEY(Booking_id, Staff_id);

--Create Customer_Phone_Number table
CREATE TABLE Customer_Phone_Number (
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id),
    Customer_Phone int NOT NULL
);

ALTER TABLE Customer_Phone_Number
ADD PRIMARY KEY(Customer_id, Customer_Phone);