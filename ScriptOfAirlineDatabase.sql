USE [master]
GO
/****** Object:  Database [AirlineManagmenet]    Script Date: 5/25/2025 11:15:55 AM ******/
CREATE DATABASE [AirlineManagmenet]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AirlineManagmenet', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AirlineManagmenet.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AirlineManagmenet_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\AirlineManagmenet_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [AirlineManagmenet] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AirlineManagmenet].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AirlineManagmenet] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET ARITHABORT OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AirlineManagmenet] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AirlineManagmenet] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AirlineManagmenet] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AirlineManagmenet] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET RECOVERY FULL 
GO
ALTER DATABASE [AirlineManagmenet] SET  MULTI_USER 
GO
ALTER DATABASE [AirlineManagmenet] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AirlineManagmenet] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AirlineManagmenet] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AirlineManagmenet] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AirlineManagmenet] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AirlineManagmenet] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'AirlineManagmenet', N'ON'
GO
ALTER DATABASE [AirlineManagmenet] SET QUERY_STORE = ON
GO
ALTER DATABASE [AirlineManagmenet] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [AirlineManagmenet]
GO
/****** Object:  Table [dbo].[Airplane]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airplane](
	[Airplane_id] [int] IDENTITY(1,1) NOT NULL,
	[Total_Number_of_Seats] [int] NOT NULL,
	[Airplane_Type_Name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Airplane_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airplane_Type]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airplane_Type](
	[Airplane_Type_Name] [varchar](255) NOT NULL,
	[Company] [varchar](255) NOT NULL,
	[Max_Seats] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Airplane_Type_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airport]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport](
	[Airport_code] [int] IDENTITY(1,1) NOT NULL,
	[Airport_Name] [varchar](255) NOT NULL,
	[City] [varchar](255) NOT NULL,
	[State] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Airport_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Airport_Airplane_Type]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airport_Airplane_Type](
	[Airport_code] [int] NOT NULL,
	[Airplane_Type_Name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Airport_code] ASC,
	[Airplane_Type_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fare]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fare](
	[Code] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [int] NOT NULL,
	[Restrictions] [varchar](255) NOT NULL,
	[Flight_Number] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Code] ASC,
	[Flight_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flight]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight](
	[Flight_Number] [int] IDENTITY(1,1) NOT NULL,
	[Airline] [varchar](255) NOT NULL,
	[Weekdays] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Flight_Number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Flight_Leg]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Flight_Leg](
	[Leg_Number] [int] IDENTITY(1,1) NOT NULL,
	[Scheduled_dep_time] [time](7) NOT NULL,
	[Scheduled_arr_time] [time](7) NOT NULL,
	[Airport_code] [int] NOT NULL,
	[Flight_Number] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Leg_Number] ASC,
	[Airport_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Leg_Instance]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Leg_Instance](
	[Leg_Instance_Date] [date] NOT NULL,
	[Dep_time] [time](7) NOT NULL,
	[Arr_time] [time](7) NOT NULL,
	[Number_of_Available_Seats] [int] NOT NULL,
	[Airport_code] [int] NOT NULL,
	[Airplane_id] [int] NOT NULL,
	[Leg_Number] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Leg_Instance_Date] ASC,
	[Airplane_id] ASC,
	[Airport_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 5/25/2025 11:15:55 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seat](
	[Seat_Number] [int] NOT NULL,
	[C_phone] [int] NOT NULL,
	[C_Name] [varchar](255) NOT NULL,
	[Leg_Instance_Date] [date] NOT NULL,
	[Airport_code] [int] NOT NULL,
	[Airplane_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Seat_Number] ASC,
	[Leg_Instance_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Airplane] ON 

INSERT [dbo].[Airplane] ([Airplane_id], [Total_Number_of_Seats], [Airplane_Type_Name]) VALUES (1, 180, N'Airbus A320')
INSERT [dbo].[Airplane] ([Airplane_id], [Total_Number_of_Seats], [Airplane_Type_Name]) VALUES (2, 350, N'Airbus A350')
INSERT [dbo].[Airplane] ([Airplane_id], [Total_Number_of_Seats], [Airplane_Type_Name]) VALUES (3, 189, N'Boeing 737')
INSERT [dbo].[Airplane] ([Airplane_id], [Total_Number_of_Seats], [Airplane_Type_Name]) VALUES (4, 396, N'Boeing 777')
INSERT [dbo].[Airplane] ([Airplane_id], [Total_Number_of_Seats], [Airplane_Type_Name]) VALUES (5, 132, N'Embraer E195')
SET IDENTITY_INSERT [dbo].[Airplane] OFF
GO
INSERT [dbo].[Airplane_Type] ([Airplane_Type_Name], [Company], [Max_Seats]) VALUES (N'Airbus A320', N'Airbus', 180)
INSERT [dbo].[Airplane_Type] ([Airplane_Type_Name], [Company], [Max_Seats]) VALUES (N'Airbus A350', N'Airbus', 350)
INSERT [dbo].[Airplane_Type] ([Airplane_Type_Name], [Company], [Max_Seats]) VALUES (N'Boeing 737', N'Boeing', 189)
INSERT [dbo].[Airplane_Type] ([Airplane_Type_Name], [Company], [Max_Seats]) VALUES (N'Boeing 777', N'Boeing', 396)
INSERT [dbo].[Airplane_Type] ([Airplane_Type_Name], [Company], [Max_Seats]) VALUES (N'Embraer E195', N'Embraer', 132)
GO
SET IDENTITY_INSERT [dbo].[Airport] ON 

INSERT [dbo].[Airport] ([Airport_code], [Airport_Name], [City], [State]) VALUES (1, N'Muscat International Airport', N'Muscat', N'Muscat Governorate')
INSERT [dbo].[Airport] ([Airport_code], [Airport_Name], [City], [State]) VALUES (2, N'King Khalid International Airport', N'Riyadh', N'Riyadh Region')
INSERT [dbo].[Airport] ([Airport_code], [Airport_Name], [City], [State]) VALUES (3, N'King Abdulaziz International Airport', N'Jeddah', N'Makkah Region')
INSERT [dbo].[Airport] ([Airport_code], [Airport_Name], [City], [State]) VALUES (4, N'King Fahd International Airport', N'Dammam', N'Eastern Province')
INSERT [dbo].[Airport] ([Airport_code], [Airport_Name], [City], [State]) VALUES (5, N'Prince Mohammad bin Abdulaziz International Airport', N'Medina', N'Medina Region')
INSERT [dbo].[Airport] ([Airport_code], [Airport_Name], [City], [State]) VALUES (6, N'Abha International Airport', N'Abha', N'Asir Region')
SET IDENTITY_INSERT [dbo].[Airport] OFF
GO
INSERT [dbo].[Airport_Airplane_Type] ([Airport_code], [Airplane_Type_Name]) VALUES (1, N'Airbus A320')
INSERT [dbo].[Airport_Airplane_Type] ([Airport_code], [Airplane_Type_Name]) VALUES (2, N'Boeing 737')
INSERT [dbo].[Airport_Airplane_Type] ([Airport_code], [Airplane_Type_Name]) VALUES (3, N'Airbus A350')
INSERT [dbo].[Airport_Airplane_Type] ([Airport_code], [Airplane_Type_Name]) VALUES (4, N'Boeing 777')
INSERT [dbo].[Airport_Airplane_Type] ([Airport_code], [Airplane_Type_Name]) VALUES (5, N'Embraer E195')
GO
SET IDENTITY_INSERT [dbo].[Fare] ON 

INSERT [dbo].[Fare] ([Code], [Amount], [Restrictions], [Flight_Number]) VALUES (1, 450, N'Non-refundable, no date change', 1)
INSERT [dbo].[Fare] ([Code], [Amount], [Restrictions], [Flight_Number]) VALUES (2, 600, N'Refundable with fee, date change allowed', 2)
INSERT [dbo].[Fare] ([Code], [Amount], [Restrictions], [Flight_Number]) VALUES (3, 350, N'Non-refundable, baggage not included', 3)
INSERT [dbo].[Fare] ([Code], [Amount], [Restrictions], [Flight_Number]) VALUES (4, 800, N'Fully refundable, includes meals and baggage', 4)
INSERT [dbo].[Fare] ([Code], [Amount], [Restrictions], [Flight_Number]) VALUES (5, 500, N'Non-refundable, date change allowed with fee', 5)
SET IDENTITY_INSERT [dbo].[Fare] OFF
GO
SET IDENTITY_INSERT [dbo].[Flight] ON 

INSERT [dbo].[Flight] ([Flight_Number], [Airline], [Weekdays]) VALUES (1, N'Saudia', 127)
INSERT [dbo].[Flight] ([Flight_Number], [Airline], [Weekdays]) VALUES (2, N'Qatar Airways', 62)
INSERT [dbo].[Flight] ([Flight_Number], [Airline], [Weekdays]) VALUES (3, N'Emirates', 65)
INSERT [dbo].[Flight] ([Flight_Number], [Airline], [Weekdays]) VALUES (4, N'Oman Air', 4)
INSERT [dbo].[Flight] ([Flight_Number], [Airline], [Weekdays]) VALUES (5, N'Etihad Airways', 28)
SET IDENTITY_INSERT [dbo].[Flight] OFF
GO
SET IDENTITY_INSERT [dbo].[Flight_Leg] ON 

INSERT [dbo].[Flight_Leg] ([Leg_Number], [Scheduled_dep_time], [Scheduled_arr_time], [Airport_code], [Flight_Number]) VALUES (1, CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), 1, 1)
INSERT [dbo].[Flight_Leg] ([Leg_Number], [Scheduled_dep_time], [Scheduled_arr_time], [Airport_code], [Flight_Number]) VALUES (2, CAST(N'12:15:00' AS Time), CAST(N'14:45:00' AS Time), 2, 2)
INSERT [dbo].[Flight_Leg] ([Leg_Number], [Scheduled_dep_time], [Scheduled_arr_time], [Airport_code], [Flight_Number]) VALUES (3, CAST(N'09:30:00' AS Time), CAST(N'13:00:00' AS Time), 3, 3)
INSERT [dbo].[Flight_Leg] ([Leg_Number], [Scheduled_dep_time], [Scheduled_arr_time], [Airport_code], [Flight_Number]) VALUES (4, CAST(N'16:00:00' AS Time), CAST(N'18:30:00' AS Time), 4, 4)
INSERT [dbo].[Flight_Leg] ([Leg_Number], [Scheduled_dep_time], [Scheduled_arr_time], [Airport_code], [Flight_Number]) VALUES (5, CAST(N'06:45:00' AS Time), CAST(N'09:15:00' AS Time), 5, 5)
SET IDENTITY_INSERT [dbo].[Flight_Leg] OFF
GO
INSERT [dbo].[Leg_Instance] ([Leg_Instance_Date], [Dep_time], [Arr_time], [Number_of_Available_Seats], [Airport_code], [Airplane_id], [Leg_Number]) VALUES (CAST(N'2025-06-01' AS Date), CAST(N'08:00:00' AS Time), CAST(N'10:00:00' AS Time), 150, 1, 1, 1)
INSERT [dbo].[Leg_Instance] ([Leg_Instance_Date], [Dep_time], [Arr_time], [Number_of_Available_Seats], [Airport_code], [Airplane_id], [Leg_Number]) VALUES (CAST(N'2025-06-02' AS Date), CAST(N'12:30:00' AS Time), CAST(N'14:45:00' AS Time), 140, 2, 2, 2)
INSERT [dbo].[Leg_Instance] ([Leg_Instance_Date], [Dep_time], [Arr_time], [Number_of_Available_Seats], [Airport_code], [Airplane_id], [Leg_Number]) VALUES (CAST(N'2025-06-03' AS Date), CAST(N'09:15:00' AS Time), CAST(N'11:45:00' AS Time), 175, 3, 3, 3)
INSERT [dbo].[Leg_Instance] ([Leg_Instance_Date], [Dep_time], [Arr_time], [Number_of_Available_Seats], [Airport_code], [Airplane_id], [Leg_Number]) VALUES (CAST(N'2025-06-04' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:20:00' AS Time), 190, 4, 4, 4)
INSERT [dbo].[Leg_Instance] ([Leg_Instance_Date], [Dep_time], [Arr_time], [Number_of_Available_Seats], [Airport_code], [Airplane_id], [Leg_Number]) VALUES (CAST(N'2025-06-05' AS Date), CAST(N'06:45:00' AS Time), CAST(N'09:00:00' AS Time), 120, 5, 5, 5)
GO
INSERT [dbo].[Seat] ([Seat_Number], [C_phone], [C_Name], [Leg_Instance_Date], [Airport_code], [Airplane_id]) VALUES (1, 92478345, N'Ahmed Al-Saadi', CAST(N'2025-06-01' AS Date), 1, 1)
INSERT [dbo].[Seat] ([Seat_Number], [C_phone], [C_Name], [Leg_Instance_Date], [Airport_code], [Airplane_id]) VALUES (2, 96651234, N'Sara Al-Harbi', CAST(N'2025-06-02' AS Date), 2, 2)
INSERT [dbo].[Seat] ([Seat_Number], [C_phone], [C_Name], [Leg_Instance_Date], [Airport_code], [Airplane_id]) VALUES (3, 96651234, N'Mohammed Al-Qahtani', CAST(N'2025-06-03' AS Date), 3, 3)
INSERT [dbo].[Seat] ([Seat_Number], [C_phone], [C_Name], [Leg_Instance_Date], [Airport_code], [Airplane_id]) VALUES (4, 96651234, N'Layla Al-Otaibi', CAST(N'2025-06-04' AS Date), 4, 4)
INSERT [dbo].[Seat] ([Seat_Number], [C_phone], [C_Name], [Leg_Instance_Date], [Airport_code], [Airplane_id]) VALUES (5, 96651234, N'Faisal Al-Dossari', CAST(N'2025-06-05' AS Date), 5, 5)
GO
ALTER TABLE [dbo].[Airplane]  WITH CHECK ADD FOREIGN KEY([Airplane_Type_Name])
REFERENCES [dbo].[Airplane_Type] ([Airplane_Type_Name])
GO
ALTER TABLE [dbo].[Airport_Airplane_Type]  WITH CHECK ADD FOREIGN KEY([Airplane_Type_Name])
REFERENCES [dbo].[Airplane_Type] ([Airplane_Type_Name])
GO
ALTER TABLE [dbo].[Fare]  WITH CHECK ADD FOREIGN KEY([Flight_Number])
REFERENCES [dbo].[Flight] ([Flight_Number])
GO
ALTER TABLE [dbo].[Flight_Leg]  WITH CHECK ADD FOREIGN KEY([Airport_code])
REFERENCES [dbo].[Airport] ([Airport_code])
GO
ALTER TABLE [dbo].[Flight_Leg]  WITH CHECK ADD FOREIGN KEY([Flight_Number])
REFERENCES [dbo].[Flight] ([Flight_Number])
GO
ALTER TABLE [dbo].[Leg_Instance]  WITH CHECK ADD FOREIGN KEY([Airplane_id])
REFERENCES [dbo].[Airplane] ([Airplane_id])
GO
ALTER TABLE [dbo].[Leg_Instance]  WITH CHECK ADD FOREIGN KEY([Leg_Number], [Airport_code])
REFERENCES [dbo].[Flight_Leg] ([Leg_Number], [Airport_code])
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD FOREIGN KEY([Leg_Instance_Date], [Airplane_id], [Airport_code])
REFERENCES [dbo].[Leg_Instance] ([Leg_Instance_Date], [Airplane_id], [Airport_code])
GO
USE [master]
GO
ALTER DATABASE [AirlineManagmenet] SET  READ_WRITE 
GO
