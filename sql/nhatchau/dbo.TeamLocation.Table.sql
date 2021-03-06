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
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamLocation](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NULL,
	[TeamID] [int] NULL,
	[StartDate] [datetime] NULL,
	[OutDate] [datetime] NULL,
 CONSTRAINT [PK_TeamLocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TeamLocation] ON 

INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (1, 2, 2, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (2, 2, 4, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (3, 2, 3, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (4, 3, 1, NULL, NULL)
INSERT [dbo].[TeamLocation] ([Id], [LocationID], [TeamID], [StartDate], [OutDate]) VALUES (5, 3, 5, NULL, NULL)
SET IDENTITY_INSERT [dbo].[TeamLocation] OFF
ALTER TABLE [dbo].[TeamLocation]  WITH CHECK ADD  CONSTRAINT [FK_TeamLocation_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([Id])
GO
ALTER TABLE [dbo].[TeamLocation] CHECK CONSTRAINT [FK_TeamLocation_Location]
GO
ALTER TABLE [dbo].[TeamLocation]  WITH CHECK ADD  CONSTRAINT [FK_TeamLocation_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[TeamLocation] CHECK CONSTRAINT [FK_TeamLocation_Team]
GO
