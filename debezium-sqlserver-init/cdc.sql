USE [testDB]
GO

INSERT INTO [dbo].[customers]
           ([first_name]
           ,[last_name]
           ,[email])
     VALUES
           ('John'
           ,'Doe'
           ,'john@email.com')
GO

USE [testDB]
GO

UPDATE [dbo].[customers]
   SET 
      [last_name] = 'Doe1'
      ,[email] = 'john.doe@email.com'
 WHERE [id] = 1005
GO


USE [testDB]
GO

DELETE FROM [dbo].[customers]
      WHERE [id] = 1005
GO



