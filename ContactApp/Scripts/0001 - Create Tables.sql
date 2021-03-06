IF OBJECT_ID(N'[dbo].[Contact]', 'U') IS NULL
	CREATE TABLE [dbo].[Contact]
	(
	[Id] [uniqueidentifier] NOT NULL,
	[FirstName] [varchar] (64) NOT NULL,
	[LastName] [varchar] (64) NOT NULL,
	[FullName] AS (([FirstName]+' ')+[LastName]),
	[Company] [varchar] (64) NULL,
	[Title] [varchar] (64) NULL,
	[Email] [varchar] (256) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL,
	[Timestamp] [timestamp] NOT NULL
	)
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_Contact]', 'PK') AND parent_object_id = OBJECT_ID(N'[dbo].[Contact]', 'U'))
	ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [PK_Contact] PRIMARY KEY CLUSTERED  ([Id])
GO

IF OBJECT_ID(N'[dbo].[Phone]', 'U') IS NULL
	CREATE TABLE [dbo].[Phone]
	(
	[Id] [uniqueidentifier] NOT NULL,
	[ContactId] [uniqueidentifier] NOT NULL,
	[Number] [varchar] (32) NOT NULL,
	[Label] [varchar] (8) NULL,
	[Ordinal] [int] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[UpdatedOn] [datetime] NULL
	)
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PK_Phone]', 'PK') AND parent_object_id = OBJECT_ID(N'[dbo].[Phone]', 'U'))
	ALTER TABLE [dbo].[Phone] ADD CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED  ([Id])
GO

IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Phone_Contact]','F') AND parent_object_id = OBJECT_ID(N'[dbo].[Phone]', 'U'))
	ALTER TABLE [dbo].[Phone] ADD CONSTRAINT [FK_Phone_Contact] FOREIGN KEY ([ContactId]) REFERENCES [dbo].[Contact] ([Id]) ON DELETE CASCADE
GO

IF OBJECT_ID(N'[dbo].[SchemaVersions]', 'U') IS NULL
	CREATE TABLE [dbo].[SchemaVersions]
	(
	[Id] [int] NOT NULL IDENTITY(1, 1),
	[ScriptName] [nvarchar] (255) NOT NULL,
	[Applied] [datetime] NOT NULL
	)
GO
