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



