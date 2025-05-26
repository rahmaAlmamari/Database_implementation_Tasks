USE ITI;

--1.  Create a scalar function that takes date and returns Month name of that date. 
CREATE FUNCTION GetMonthName ( @inputDate DATE )
RETURNS VARCHAR(50)
AS
BEGIN
    RETURN DATENAME(month, @inputDate);
END;

--call GetMonthName

SELECT dbo.GetMonthName('2025-01-01');

--2.  Create a multi-statements table-valued function that takes 2 integers and returns the values between them. 
CREATE FUNCTION GetNumbersBetween
(
    @Start INT,
    @End INT
)
RETURNS @Result TABLE
(
    Number INT
)
AS
BEGIN
    DECLARE @Current INT;

    -- Ensure correct order (optional: adjust as needed)
    IF @Start < @End
        SET @Current = @Start + 1;
    ELSE
        SET @Current = @End + 1;

    -- Loop until the number before the end
    WHILE @Current < CASE WHEN @Start < @End THEN @End ELSE @Start END
    BEGIN
        INSERT INTO @Result (Number)
        VALUES (@Current);

        SET @Current = @Current + 1;
    END

    RETURN;
END;

--call the GetNumbersBetween
SELECT * FROM GetNumbersBetween(3, 8);

--3.  Create inline function that takes Student No and returns Department Name with Student full name. 
CREATE FUNCTION GetStudentDepartmentInfo
(
    @StudentNo INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        S.St_Fname + ' ' + S.St_Lname AS FullName,
        D.Dept_Name
    FROM 
        Student S
    INNER JOIN 
        Department D ON S.Dept_Id = D.Dept_Id
    WHERE 
        S.St_Id = @StudentNo
);

--call the GetStudentDepartmentInfo
SELECT * FROM Student;
SELECT * FROM GetStudentDepartmentInfo(7);

--4. Create a scalar function that takes Student ID and returns a message to user  
--    a. If first name and Last name are null then display 'First name & last name are null' 
--    b. If First name is null then display 'first name is null' 
--    c. If Last name is null then display 'last name is null' 
--    d. Else display 'First name & last name are not null'

CREATE FUNCTION CheckStudentNameNullStatus
(
    @StudentID INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @FirstName VARCHAR(50);
    DECLARE @LastName VARCHAR(50);
    DECLARE @Message VARCHAR(100);

    SELECT 
        @FirstName = St_Fname,
        @LastName = St_Lname
    FROM 
        Student
    WHERE 
        St_Id = @StudentID;

    IF @FirstName IS NULL AND @LastName IS NULL
        SET @Message = 'First name & last name are null';
    ELSE IF @FirstName IS NULL
        SET @Message = 'First name is null';
    ELSE IF @LastName IS NULL
        SET @Message = 'Last name is null';
    ELSE
        SET @Message = 'First name & last name are not null';

    RETURN @Message;
END;

--call the CheckStudentNameNullStatus
SELECT * FROM Student;
SELECT dbo.CheckStudentNameNullStatus(7) AS Message;
SELECT dbo.CheckStudentNameNullStatus(13) AS Message;
SELECT dbo.CheckStudentNameNullStatus(14) AS Message;

--5. Create inline function that takes integer which represents manager ID and displays department 
--   name, Manager Name and hiring date 
SELECT * FROM Instructor;
SELECT * FROM Department;


CREATE FUNCTION GetManagerDepartmentInfo
(
    @ManagerID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        D.Dept_Name,
        I.Ins_Name AS ManagerName,
        D.Manager_hiredate
    FROM 
        Department D
    INNER JOIN 
        Instructor I ON D.Dept_Id = I.Dept_Id
    WHERE 
        I.Ins_Id = @ManagerID
);

--call GetManagerDepartmentInfo
SELECT * FROM dbo.GetManagerDepartmentInfo(10);


--6. Create multi-statements table-valued function that takes a string 
--   If string='first name' returns student first name 
--   If string='last name' returns student last name  
--   If string='full name' returns Full Name from student table 
--   Note: Use “ISNULL” function 

CREATE FUNCTION dbo.ProcessString
(
    @StringToProcess VARCHAR(20)
)
RETURNS @FinalResult TABLE
(
    StudentName VARCHAR(100)
)
AS
BEGIN
    IF @StringToProcess = 'first name'
    BEGIN
        INSERT INTO @FinalResult (StudentName)
        SELECT ISNULL(St_Fname, 'N/A')
        FROM Student;
    END
    ELSE IF @StringToProcess = 'last name'
    BEGIN
        INSERT INTO @FinalResult (StudentName)
        SELECT ISNULL(St_Lname, 'N/A')
        FROM Student;
    END
    ELSE IF @StringToProcess = 'full name'
    BEGIN
        INSERT INTO @FinalResult (StudentName)
        SELECT ISNULL(St_Fname, 'N/A') + ' ' + ISNULL(St_Lname, 'N/A')
        FROM Student;
    END
    ELSE
    BEGIN
        INSERT INTO @FinalResult (StudentName)
        VALUES ('Wrong entered input');
    END

    RETURN;
END;


----call GetManagerDepartmentInfo
SELECT * FROM dbo.ProcessString('first name');

DROP FUNCTION dbo.ProcessString;

--Use company DB 
--7. Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 
--   and increases it by 20% if Salary >=3000.
USE CompanyManagmenet;

DECLARE @EmpID INT;
DECLARE @Salary DECIMAL(10, 2);

-- Declare the cursor
DECLARE SalaryCursor CURSOR FOR
SELECT SSN, Salary
FROM Employee;

-- Open the cursor
OPEN SalaryCursor;

-- Fetch the first row
FETCH NEXT FROM SalaryCursor INTO @EmpID, @Salary;

-- Loop through the result set
WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Salary < 3000
    BEGIN
        UPDATE Employee
        SET Salary = Salary * 1.10
        WHERE SSN = @EmpID;
    END
    ELSE
    BEGIN
        UPDATE Employee
        SET Salary = Salary * 1.20
        WHERE SSN = @EmpID;
    END

    FETCH NEXT FROM SalaryCursor INTO @EmpID, @Salary;
END

-- Clean up
CLOSE SalaryCursor;
DEALLOCATE SalaryCursor;

SELECT * FROM Employee;

