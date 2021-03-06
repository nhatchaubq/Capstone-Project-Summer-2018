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
/****** Object:  Table [dbo].[TeamAccount]    Script Date: 6/22/2018 4:01:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamAccount](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TeamID] [int] NULL,
	[AccountID] [int] NULL,
	[TeamRoleID] [int] NULL,
 CONSTRAINT [PK_TeamAccount] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[TeamAccount] ON 

INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (1, 1, 3, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (2, 1, 5, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (3, 1, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (4, 2, 5, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (5, 2, 3, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (6, 5, 12, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (7, 5, 13, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (8, 4, 14, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (9, 4, 9, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (10, 4, 10, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (11, 3, 11, 1)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (12, 3, 7, 2)
INSERT [dbo].[TeamAccount] ([Id], [TeamID], [AccountID], [TeamRoleID]) VALUES (13, 3, 9, 2)
SET IDENTITY_INSERT [dbo].[TeamAccount] OFF
ALTER TABLE [dbo].[TeamAccount]  WITH CHECK ADD  CONSTRAINT [FK_TeamAccount_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[TeamAccount] CHECK CONSTRAINT [FK_TeamAccount_Account]
GO
ALTER TABLE [dbo].[TeamAccount]  WITH CHECK ADD  CONSTRAINT [FK_TeamAccount_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[TeamAccount] CHECK CONSTRAINT [FK_TeamAccount_Team]
GO
ALTER TABLE [dbo].[TeamAccount]  WITH CHECK ADD  CONSTRAINT [FK_TeamAccount_TeamRoles] FOREIGN KEY([TeamRoleID])
REFERENCES [dbo].[TeamRoles] ([Id])
GO
ALTER TABLE [dbo].[TeamAccount] CHECK CONSTRAINT [FK_TeamAccount_TeamRoles]
GO
