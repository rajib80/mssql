/*
The following extended properties already exist in the AdventureWorks database. There is no need to run the 
script against the database in order for the remaining samples to work.
*/ 
USE [AdventureWorks]
GO

--Script to add an Extended Property to the Table
EXEC sys.sp_addextendedproperty 
@name=N'MS_Description', 
@value=N'Street address information for customers, employees, and vendors.' ,
@level0type=N'SCHEMA', 
@level0name=N'Person', --Schema Name
@level1type=N'TABLE', 
@level1name=N'Address' --Table Name
GO

--Script to add an Extended Property to a column
EXEC sys.sp_addextendedproperty 
@name=N'MS_Description', 
@value=N'First street address line.' ,
@level0type=N'SCHEMA', 
@level0name=N'Person', --Schema Name
@level1type=N'TABLE', 
@level1name=N'Address',--Table Name 
@level2type=N'COLUMN', 
@level2name=N'AddressLine1'--Column Name
GO
