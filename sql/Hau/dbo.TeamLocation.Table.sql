USE [EquipmentManageSystem]
GO
/****** Object:  Table [dbo].[TeamLocation]    Script Date: 6/25/2018 3:28:25 PM ******/
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
