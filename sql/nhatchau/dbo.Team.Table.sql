/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4206)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [EquipmentManageSystem]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (1, N'xay dung abc', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (2, N'TeamA', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (3, N'TeamB', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (4, N'TeamC', NULL)
INSERT [dbo].[Team] ([Id], [Name], [CreatedDate]) VALUES (5, N'TeamD', NULL)
SET IDENTITY_INSERT [dbo].[Team] OFF
