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
/****** Object:  Table [dbo].[ProjectTeams]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProjectTeams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProjectID] [int] NOT NULL,
	[TeamID] [int] NULL,
	[JoinDate] [datetime] NULL,
	[OutDate] [datetime] NULL,
 CONSTRAINT [PK_ProjectTeams] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ProjectTeams] ON 

INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (1, 1, 2, CAST(N'2018-06-05T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (4, 2, 3, CAST(N'2018-06-08T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (5, 3, 2, CAST(N'2018-03-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (6, 4, 4, CAST(N'2018-01-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[ProjectTeams] ([Id], [ProjectID], [TeamID], [JoinDate], [OutDate]) VALUES (7, 5, 5, CAST(N'2018-01-01T00:00:00.000' AS DateTime), CAST(N'2018-05-01T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[ProjectTeams] OFF
