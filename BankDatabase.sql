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

-----------------------------------------------------DML---------------------------------
INSERT INTO Branch (Branch_Address) VALUES 
('123 Main St'), 
('456 Elm St'), 
('789 Oak St'), 
('101 Pine St'), 
('202 Maple St');

SELECT * FROM Branch;

INSERT INTO Employee (Employee_Name, Employee_Position, Branch_id) VALUES 
('Alice Johnson', 'Manager', 1),
('Bob Smith', 'Teller', 1),
('Charlie Brown', 'Clerk', 2),
('Diana Prince', 'Loan Officer', 3),
('Ethan Hunt', 'Security', 4);

SELECT * FROM Employee;

INSERT INTO Customer (Customer_Name, Customer_Address, Action_Type, Employee_id) VALUES 
('John Doe', '101 A St', 'Open Account', 1),
('Jane Roe', '102 B St', 'Loan Inquiry', 2),
('Mark Twain', '103 C St', 'Deposit', 3),
('Lucy Heart', '104 D St', 'Withdrawal', 4),
('Tom Ford', '105 E St', 'Close Account', 5);

SELECT * FROM Customer;

INSERT INTO Loans (Issue_Date, Amount, Loans_Type, Employee_id, Customer_id) VALUES 
('2025-01-10', 10000, 'Home', 1, 1),
('2025-02-15', 5000, 'Car', 2, 2),
('2025-03-01', 15000, 'Business', 3, 3),
('2025-03-20', 7000, 'Education', 4, 4),
('2025-04-05', 2000, 'Personal', 5, 5);

SELECT * FROM Loans;

INSERT INTO Account (Date_of_Creation, Account_Number, Account_Balance, Account_Type, Customer_id) VALUES 
('2024-01-01', 10001, 5000, 'Savings', 1),
('2024-01-15', 10002, 12000, 'Current', 2),
('2024-02-01', 10003, 8000, 'Savings', 3),
('2024-02-20', 10004, 1500, 'Current', 4),
('2024-03-05', 10005, 3000, 'Fixed Deposit', 5);

SELECT * FROM Account;

INSERT INTO Transactions (Transactions_Date, Transactions_Amount, Account_id) VALUES 
('2025-05-01', 200, 1),
('2025-05-02', 500, 2),
('2025-05-03', 300, 3),
('2025-05-04', 150, 4),
('2025-05-05', 700, 5);

SELECT * FROM Transactions;

INSERT INTO Customer_Phone_Number (Customer_Phone, Customer_id) VALUES 
(912345678, 1),
(923456789, 2),
(934567890, 3),
(945678901, 4),
(956789012, 5);

SELECT * FROM Customer_Phone_Number;

INSERT INTO Branch_Phone_Number (Branch_Phone, Branch_id) VALUES 
(24111111, 1),
(24222222, 2),
(24333333, 3),
(24444444, 4),
(24555555, 5);

SELECT * FROM Branch_Phone_Number;

INSERT INTO Transactions_Type (T_Type, Transactions_id) VALUES 
('Deposit', 1),
('Withdrawal', 2),
('Transfer', 3),
('Deposit', 4),
('Withdrawal', 5);

SELECT * FROM Transactions_Type;
