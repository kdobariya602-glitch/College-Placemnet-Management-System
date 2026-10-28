/*
  Run this against Astra_Pms_db (the database used by connection string "dbcon" in Web.config)
  to create the login table for the new TPO panel and seed one default TPO account.

  How to run:
    1. Open the project in Visual Studio.
    2. View > SQL Server Object Explorer (or Server Explorer) > find Astra_Pms_db.mdf.
    3. Right click the database > New Query, paste this script, and execute (F5).
       (Or open App_Data\Astra_Pms_db.mdf in SSMS and run it there.)
*/

IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TPO_Login_tbl')
BEGIN
    CREATE TABLE TPO_Login_tbl (
        Id       INT IDENTITY(1,1) PRIMARY KEY,
        Name     NVARCHAR(100)  NULL,
        Email    NVARCHAR(150)  NOT NULL,
        Password NVARCHAR(100)  NOT NULL
    );
END
GO

-- Default TPO login: tpo@university.edu / tpo123
IF NOT EXISTS (SELECT * FROM TPO_Login_tbl WHERE Email = 'tpo@university.edu')
BEGIN
    INSERT INTO TPO_Login_tbl (Name, Email, Password)
    VALUES ('Placement Officer', 'tpo@university.edu', 'tpo123');
END
GO
