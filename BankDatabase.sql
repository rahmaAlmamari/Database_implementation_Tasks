CREATE DATABASE BankManagmenet;

USE BankManagmenet;

--Create Branch table
CREATE TABLE Branch (
    Branch_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Branch_Address varchar(255) NOT NULL
);

--Create Employee table
CREATE TABLE Employee (
    Employee_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Employee_Name varchar(255) NOT NULL,
	Employee_Position varchar(255) NOT NULL,
	Branch_id int NOT NULL, foreign key(Branch_id) references Branch(Branch_id)
);

--Create Customer table
CREATE TABLE Customer (
    Customer_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Customer_Name varchar(255) NOT NULL,
	Customer_Address varchar(255) NOT NULL,
	Action_Type varchar(255) NOT NULL,
	Employee_id int NOT NULL, foreign key(Employee_id) references Employee(Employee_id)
);

--Create Loans table
CREATE TABLE Loans (
    Loans_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Issue_Date Date NOT NULL,
	Amount int NOT NULL,
	Loans_Type varchar(255) NOT NULL,
	Employee_id int NOT NULL, foreign key(Employee_id) references Employee(Employee_id),
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id)
);

--Create Account table
CREATE TABLE Account (
    Account_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Date_of_Creation Date NOT NULL,
	Account_Number int NOT NULL,
	Account_Balance int NOT NULL,
	Account_Type varchar(255) NOT NULL,
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id)
);

--Create Transactions table
CREATE TABLE Transactions (
    Transactions_id int PRIMARY KEY identity(1,1) NOT NULL, 
    Transactions_Date Date NOT NULL,
	Transactions_Amount int NOT NULL,
	Account_id int NOT NULL, foreign key(Account_id) references Account(Account_id)
);

--Create Customer_Phone_Number table
CREATE TABLE Customer_Phone_Number (
    Customer_Phone int NOT NULL,
	Customer_id int NOT NULL, foreign key(Customer_id) references Customer(Customer_id)
);

ALTER TABLE Customer_Phone_Number
ADD PRIMARY KEY(Customer_id, Customer_Phone);

--Create Branch_Phone_Number table
CREATE TABLE Branch_Phone_Number (
    Branch_Phone int NOT NULL,
	Branch_id int NOT NULL, foreign key(Branch_id) references Branch(Branch_id)
);

ALTER TABLE Branch_Phone_Number
ADD PRIMARY KEY(Branch_id, Branch_Phone);


--Create Transactions_Type table
CREATE TABLE Transactions_Type (
    T_Type varchar(255) NOT NULL,
	Transactions_id int NOT NULL, foreign key(Transactions_id) references Transactions(Transactions_id)
);

ALTER TABLE Transactions_Type
ADD PRIMARY KEY(Transactions_id, T_Type);