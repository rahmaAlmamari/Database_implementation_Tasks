CREATE DATABASE MoviePlatformDatabase;

USE MoviePlatformDatabase;

-- Create Users table
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE,
    SubscriptionType VARCHAR(20)  -- Free, Basic, Premium
);

-- Create Movies table
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(100),
    Genre VARCHAR(50),
    ReleaseYear INT,
    DurationMinutes INT
);

-- Create WatchHistory table
CREATE TABLE WatchHistory (
    WatchID INT PRIMARY KEY,
    UserID INT,
    MovieID INT,
    WatchDate DATE,
    WatchDuration INT,  -- in minutes
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Insert sample data into Users
INSERT INTO Users (UserID, FullName, Email, JoinDate, SubscriptionType) VALUES
(1, 'Ali Al Hinai', 'ali@example.com', '2024-01-01', 'Premium'),
(2, 'Noor Al Busaidi', 'noor@example.com', '2024-02-15', 'Basic'),
(3, 'Hassan Al Rawahi', 'hassan@example.com', '2024-03-10', 'Free'),
(4, 'Muna Al Lawati', 'muna@example.com', '2024-04-05', 'Premium'),
(5, 'Salim Al Zadjali', 'salim@example.com', '2024-05-01', 'Basic');

-- Insert sample data into Movies
INSERT INTO Movies (MovieID, Title, Genre, ReleaseYear, DurationMinutes) VALUES
(1, 'The Silent Ocean', 'Sci-Fi', 2023, 120),
(2, 'Omani Roots', 'Documentary', 2022, 90),
(3, 'Fast Track', 'Action', 2024, 130),
(4, 'Code & Coffee', 'Drama', 2023, 110),
(5, 'The Last Byte', 'Thriller', 2023, 105);

-- Insert sample data into WatchHistory
INSERT INTO WatchHistory (WatchID, UserID, MovieID, WatchDate, WatchDuration) VALUES
(1, 1, 1, '2025-05-10', 120),
(2, 2, 2, '2025-05-11', 80),
(3, 3, 3, '2025-05-12', 60),
(4, 4, 1, '2025-05-12', 90),
(5, 5, 5, '2025-05-13', 105);

---------------------------------------------TASK 9-----------------------------
--Beginner Level (Basic Practice) 
--1. Total Number of Users 
SELECT COUNT(*) AS TotalUsers FROM Users;

--2. Average Duration of All Movies 
SELECT AVG(DurationMinutes) AS AverageMovieDuration FROM Movies;

--3. Total Watch Time 
SELECT SUM(WatchDuration) AS TotalWatchTime FROM WatchHistory;

--4. Number of Movies per Genre 
SELECT Genre, COUNT(*) AS NumberOfMovies FROM Movies
GROUP BY Genre;

--5. Earliest User Join Date 
SELECT MIN(JoinDate) AS EarliestJoinDate FROM Users;

--6. Latest Movie Release Year 
SELECT MAX(ReleaseYear) AS LatestReleaseYear FROM Movies;

--Intermediate Level (Deeper Insights) 
--4. Number of Users Per Subscription Type 
SELECT SubscriptionType, COUNT(*) AS NumberOfUsers
FROM Users
GROUP BY SubscriptionType;

--5. Total Watch Time per User 
SELECT U.FullName, SUM(W.WatchDuration) AS TotalWatchTime
FROM Users U
JOIN WatchHistory W ON U.UserID = W.UserID
GROUP BY U.FullName;

--6. Average Watch Duration per Movie 
SELECT M.Title, AVG(W.WatchDuration) AS AverageWatchDuration
FROM Movies M
JOIN WatchHistory W ON M.MovieID = W.MovieID
GROUP BY M.Title;

--7. Average Watch Time per Subscription Type 
SELECT U.SubscriptionType, AVG(W.WatchDuration) AS AverageWatchTime
FROM Users U
JOIN WatchHistory W ON U.UserID = W.UserID
GROUP BY U.SubscriptionType;

--8. Number of Views per Movie (Including Zero) 
SELECT M.Title, COUNT(W.WatchID) AS NumberOfViews
FROM Movies M
LEFT JOIN WatchHistory W ON M.MovieID = W.MovieID
GROUP BY M.Title;

--9. Average Movie Duration per Release Year 
SELECT ReleaseYear, AVG(DurationMinutes) AS AverageDuration
FROM Movies
GROUP BY ReleaseYear;


