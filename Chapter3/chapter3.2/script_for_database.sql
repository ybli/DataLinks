USE [master]
GO
/****** Object:  Database [面向过程的时空数据库]    Script Date: 2020/1/8 14:46:48 ******/
CREATE DATABASE [面向过程的时空数据库]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'面向过程的时空数据库', FILENAME = N'E:\Software\SQL Server 2014\MSSQL12.MSSQLSERVER\MSSQL\DATA\面向过程的时空数据库.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'面向过程的时空数据库_log', FILENAME = N'E:\Software\SQL Server 2014\MSSQL12.MSSQLSERVER\MSSQL\DATA\面向过程的时空数据库_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [面向过程的时空数据库] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [面向过程的时空数据库].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [面向过程的时空数据库] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET ARITHABORT OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [面向过程的时空数据库] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [面向过程的时空数据库] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET  DISABLE_BROKER 
GO
ALTER DATABASE [面向过程的时空数据库] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [面向过程的时空数据库] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET RECOVERY FULL 
GO
ALTER DATABASE [面向过程的时空数据库] SET  MULTI_USER 
GO
ALTER DATABASE [面向过程的时空数据库] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [面向过程的时空数据库] SET DB_CHAINING OFF 
GO
ALTER DATABASE [面向过程的时空数据库] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [面向过程的时空数据库] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [面向过程的时空数据库] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'面向过程的时空数据库', N'ON'
GO
USE [面向过程的时空数据库]
GO
/****** Object:  Table [dbo].[ESTPObjects]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ESTPObjects](
	[STE_ID] [int] IDENTITY(1,1) NOT NULL,
	[STE_Name] [varchar](max) NULL,
	[STE_STime] [datetime] NULL,
	[STE_ETime] [datetime] NULL,
	[STE_Des] [text] NULL,
	[STE_Type] [nvarchar](max) NULL,
	[STE_LOC] [nvarchar](max) NULL,
	[STPGID] [varchar](max) NULL,
 CONSTRAINT [PK_ESTPObjects] PRIMARY KEY CLUSTERED 
(
	[STE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ESTPProcess]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ESTPProcess](
	[STP_ID] [int] IDENTITY(1,1) NOT NULL,
	[STE_ID] [int] NULL,
	[STP_Name] [varchar](max) NULL,
	[STP_STime] [datetime] NULL,
	[STP_ETime] [datetime] NULL,
	[STP_Des] [text] NULL,
	[STP_Type] [varchar](max) NULL,
	[STOGID] [varchar](max) NOT NULL,
 CONSTRAINT [PK_ESTPProcess] PRIMARY KEY CLUSTERED 
(
	[STP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ESTPStateObjects]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ESTPStateObjects](
	[STO_ID] [int] IDENTITY(1,1) NOT NULL,
	[STP_ID] [int] NULL,
	[STO_Name] [varchar](max) NULL,
	[STO_STime] [datetime] NULL,
	[STO_ETime] [datetime] NULL,
	[SSGID] [varchar](max) NULL,
 CONSTRAINT [PK_ESTPStateObjects] PRIMARY KEY CLUSTERED 
(
	[STO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ground_State_Snapshots]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ground_State_Snapshots](
	[SS_ID] [int] IDENTITY(1,1) NOT NULL,
	[SS_Type] [varchar](50) NOT NULL,
	[STO_ID] [int] NULL,
	[STE_ID] [int] NULL,
	[Event_Name] [varchar](max) NULL,
	[Event_Des] [text] NULL,
	[JT_Time] [datetime] NULL,
	[SB_Data] [int] NULL,
	[DS_data] [int] NULL,
	[HBE_Data] [int] NULL,
	[RE_Data] [int] NULL,
	[DIF_Data] [int] NULL,
	[DIE_Data] [int] NULL,
	[IPO_Data] [int] NULL,
 CONSTRAINT [PK_Ground_State_Snapshots] PRIMARY KEY CLUSTERED 
(
	[SS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Modified_Snapshots]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Modified_Snapshots](
	[SS_ID] [int] IDENTITY(1,1) NOT NULL,
	[SS_Type] [varchar](50) NULL,
	[STO_ID] [int] NULL,
	[STE_ID] [int] NULL,
	[Change_ID] [int] NULL,
	[Layer_ID] [int] NULL,
	[Layer_Name] [varchar](max) NULL,
	[Change_Des] [text] NULL,
	[C_Time] [datetime] NULL,
	[C_SB_Data] [int] NULL,
	[C_DS_data] [int] NULL,
	[C_HBE_Data] [int] NULL,
	[C_RE_Data] [int] NULL,
	[C_DIF_Data] [int] NULL,
	[C_DIE_Data] [int] NULL,
	[C_IPO_Data] [int] NULL,
 CONSTRAINT [PK_Modified_Snapshot] PRIMARY KEY CLUSTERED 
(
	[SS_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SP_Data_Objects]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SP_Data_Objects](
	[STDO_ID] [int] IDENTITY(1,1) NOT NULL,
	[STO_Type] [int] NULL,
	[STO_Name] [varchar](max) NULL,
	[STO_T] [datetime] NULL,
	[STO_Des] [text] NULL,
	[STO_Entity] [geometry] NULL,
 CONSTRAINT [PK_SP_Data_Objects] PRIMARY KEY CLUSTERED 
(
	[STDO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SP_Data_Objects_Changes]    Script Date: 2020/1/8 14:46:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SP_Data_Objects_Changes](
	[C_STDO_ID] [int] IDENTITY(1,1) NOT NULL,
	[Existence] [bit] NULL,
	[STDO_ID] [int] NULL,
	[STO_Type] [int] NULL,
	[STO_Name] [varchar](max) NULL,
	[STO_T] [datetime] NULL,
	[CSTO_Entity] [geometry] NULL,
 CONSTRAINT [PK_SP_Data_Objects_Changes] PRIMARY KEY CLUSTERED 
(
	[C_STDO_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ESTPProcess]  WITH CHECK ADD  CONSTRAINT [FK_ESTPProcess_ESTPObjects] FOREIGN KEY([STE_ID])
REFERENCES [dbo].[ESTPObjects] ([STE_ID])
GO
ALTER TABLE [dbo].[ESTPProcess] CHECK CONSTRAINT [FK_ESTPProcess_ESTPObjects]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_ESTPObjects] FOREIGN KEY([STE_ID])
REFERENCES [dbo].[ESTPObjects] ([STE_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_ESTPObjects]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_ESTPStateObjects] FOREIGN KEY([STO_ID])
REFERENCES [dbo].[ESTPStateObjects] ([STO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_ESTPStateObjects]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects] FOREIGN KEY([SB_Data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects1] FOREIGN KEY([DS_data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects1]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects2] FOREIGN KEY([HBE_Data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects2]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects3] FOREIGN KEY([RE_Data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects3]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects4] FOREIGN KEY([DIF_Data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects4]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects5] FOREIGN KEY([DIE_Data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects5]
GO
ALTER TABLE [dbo].[Ground_State_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects6] FOREIGN KEY([IPO_Data])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[Ground_State_Snapshots] CHECK CONSTRAINT [FK_Ground_State_Snapshots_SP_Data_Objects6]
GO
ALTER TABLE [dbo].[Modified_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Modified_Snapshots_ESTPObjects] FOREIGN KEY([STE_ID])
REFERENCES [dbo].[ESTPObjects] ([STE_ID])
GO
ALTER TABLE [dbo].[Modified_Snapshots] CHECK CONSTRAINT [FK_Modified_Snapshots_ESTPObjects]
GO
ALTER TABLE [dbo].[Modified_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Modified_Snapshots_ESTPStateObjects] FOREIGN KEY([STO_ID])
REFERENCES [dbo].[ESTPStateObjects] ([STO_ID])
GO
ALTER TABLE [dbo].[Modified_Snapshots] CHECK CONSTRAINT [FK_Modified_Snapshots_ESTPStateObjects]
GO
ALTER TABLE [dbo].[Modified_Snapshots]  WITH CHECK ADD  CONSTRAINT [FK_Modified_Snapshots_Ground_State_Snapshots] FOREIGN KEY([Change_ID])
REFERENCES [dbo].[Ground_State_Snapshots] ([SS_ID])
GO
ALTER TABLE [dbo].[Modified_Snapshots] CHECK CONSTRAINT [FK_Modified_Snapshots_Ground_State_Snapshots]
GO
ALTER TABLE [dbo].[SP_Data_Objects_Changes]  WITH CHECK ADD  CONSTRAINT [FK_SP_Data_Objects_Changes_SP_Data_Objects] FOREIGN KEY([STDO_ID])
REFERENCES [dbo].[SP_Data_Objects] ([STDO_ID])
GO
ALTER TABLE [dbo].[SP_Data_Objects_Changes] CHECK CONSTRAINT [FK_SP_Data_Objects_Changes_SP_Data_Objects]
GO
USE [master]
GO
ALTER DATABASE [面向过程的时空数据库] SET  READ_WRITE 
GO
