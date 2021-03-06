
USE [DbPraktika]
CREATE TABLE [dbo].[Admin](
	[AdID] [int] NOT NULL,
	[AdPasswd] [nvarchar](18) NOT NULL,
	[AdName] [nvarchar](25) NOT NULL,
	[AdContact] [nvarchar](25) NOT NULL,
	[AdEmail] [nvarchar](50) NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Customer](
	[CID] [int] NOT NULL,
	[CPasswd] [nvarchar](25) NOT NULL,
	[CTitle] [nvarchar](50) NOT NULL,
	[CFname] [nvarchar](25) NOT NULL,
	[CLname] [nvarchar](25) NOT NULL,
	[CIC] [nvarchar](50) NOT NULL,
	[CNationality] [nvarchar](50) NOT NULL,
	[CContact] [nvarchar](50) NOT NULL,
	[CEmail] [nvarchar](50) NULL,
	[CBankAcc] [int] NOT NULL,
	[CBank] [nvarchar](50) NOT NULL,
	[TypeNum] [int] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Invoice](
	[INum] [int] NOT NULL,
	[TotalFee] [money] NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Date] [datetime] NOT NULL,
	[RxNum] [int] NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[INum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Rating](
	[RatingID] [int] NOT NULL,
	[Rating] [float] NOT NULL,
	[RmID] [int] NOT NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[RatingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Reservation](
	[RxNum] [int] NOT NULL,
	[CIN] [nvarchar](50) NOT NULL,
	[COUT] [nvarchar](50) NOT NULL,
	[NON] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CID] [int] NOT NULL,
	[AdID] [int] NOT NULL,
	[RmID] [int] NOT NULL,
 CONSTRAINT [PK_Reservation] PRIMARY KEY CLUSTERED 
(
	[RxNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Room](
	[RmID] [int] NOT NULL,
	[Rmtype] [nvarchar](25) NOT NULL,
	[RmBedding] [smallint] NOT NULL,
	[RmPrice] [int] NOT NULL,
	[RmStatus] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_Room] PRIMARY KEY CLUSTERED 
(
	[RmID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Type](
	[TypeNum] [int] NOT NULL,
	[Ctype] [nchar](10) NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[TypeNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


/*** Создание внешних ключей с каскадным добавлением/удалением ***/
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Type] FOREIGN KEY([TypeNum])
REFERENCES [dbo].[Type] ([TypeNum])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Type]

ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Reservation] FOREIGN KEY([RxNum])
REFERENCES [dbo].[Reservation] ([RxNum])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Reservation]

ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Room] FOREIGN KEY([RmID])
REFERENCES [dbo].[Room] ([RmID])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Room]

ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Admin] FOREIGN KEY([AdID])
REFERENCES [dbo].[Admin] ([AdID])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Admin]

ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Customer] FOREIGN KEY([CID])
REFERENCES [dbo].[Customer] ([CID])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Customer]

ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_Room] FOREIGN KEY([RmID])
REFERENCES [dbo].[Room] ([RmID])
ON UPDATE CASCADE
ON DELETE CASCADE

ALTER TABLE [dbo].[Reservation] CHECK CONSTRAINT [FK_Reservation_Room]

USE [master]

ALTER DATABASE [DbPraktika] SET  READ_WRITE 

