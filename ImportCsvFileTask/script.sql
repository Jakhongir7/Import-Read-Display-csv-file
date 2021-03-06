USE [master]
GO
/****** Object:  Database [employee_database]    Script Date: 13.07.2021 17:24:05 ******/
CREATE DATABASE [employee_database]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'employee_database', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\employee_database.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'employee_database_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\employee_database_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [employee_database] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [employee_database].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [employee_database] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [employee_database] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [employee_database] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [employee_database] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [employee_database] SET ARITHABORT OFF 
GO
ALTER DATABASE [employee_database] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [employee_database] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [employee_database] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [employee_database] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [employee_database] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [employee_database] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [employee_database] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [employee_database] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [employee_database] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [employee_database] SET  DISABLE_BROKER 
GO
ALTER DATABASE [employee_database] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [employee_database] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [employee_database] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [employee_database] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [employee_database] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [employee_database] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [employee_database] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [employee_database] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [employee_database] SET  MULTI_USER 
GO
ALTER DATABASE [employee_database] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [employee_database] SET DB_CHAINING OFF 
GO
ALTER DATABASE [employee_database] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [employee_database] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [employee_database] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [employee_database] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [employee_database] SET QUERY_STORE = OFF
GO
USE [employee_database]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 13.07.2021 17:24:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Payroll_Number] [varchar](50) NOT NULL,
	[Forename] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Date_of_Birth] [datetime] NOT NULL,
	[Telephone] [varchar](50) NOT NULL,
	[Mobile] [varchar](50) NOT NULL,
	[Address] [varchar](200) NOT NULL,
	[Address_2] [varchar](100) NOT NULL,
	[Postcode] [varchar](50) NOT NULL,
	[EMail_Home] [varchar](200) NOT NULL,
	[Start_Date] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table]    Script Date: 13.07.2021 17:24:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[Id] [varchar](50) NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[Country] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [employee_database] SET  READ_WRITE 
GO
