CREATE DATABASE AirlineManagmenet;

USE AirlineManagmenet;

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

--Create Seat table
CREATE TABLE Seat (
    Seat_Number int PRIMARY KEY NOT NULL,
	C_phone int NOT NULL,
	C_Name varchar(255) NOT NULL,
	Leg_Instance_Date Date NOT NULL, foreign key(Leg_Instance_Date) references Leg_Instance(Leg_Instance_Date)
);

--Create Fare table
CREATE TABLE Fare (
    Code int PRIMARY KEY identity(1,1) NOT NULL,
	Amount int NOT NULL,
	Restrictions varchar(255) NOT NULL,
	Flight_Number int NOT NULL, foreign key(Flight_Number) references Flight(Flight_Number)
);

--Create Airport_Airplane_Type table
CREATE TABLE Airport_Airplane_Type (
	Airport_code int NOT NULL, foreign key(Airport_code) references Airport(Airport_code),
	Airplane_Type_Name varchar NOT NULL, foreign key(Airplane_Type_Name) references Airplane_Type(Airplane_Type_Name)
);

--to add PRIMARY KEY to Airport_Airplane_Type
ALTER TABLE Airport_Airplane_Type
ADD PRIMARY KEY(Airport_code, Airplane_Type_Name);