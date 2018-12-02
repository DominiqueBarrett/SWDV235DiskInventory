USE DiskInventory;
GO

 IF OBJECT_ID('Disks_SP') IS NOT NULL
   DROP PROC Disks_SP
 GO

CREATE PROCEDURE [dbo].[Disks_SP]
      @Action VARCHAR(10),
       @DiskID INT = NULL,
       @DiskTypeID INT = NULL,
       @DiskStatusID INT = NULL,
       @GenreID INT = NULL,
       @DiskName VARCHAR(100) = NULL,
       @ReleasedDate DATETIME = NULL
AS
BEGIN
      SET NOCOUNT ON;
 
      --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT DiskID, DiskTypeID, DiskStatusID, GenreID, DiskName, ReleasedDate
            FROM Disks
      END
 
      --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO Disks(DiskTypeID, DiskStatusID, GenreID, DiskName, ReleasedDate)
            VALUES (@DiskTypeID, @DiskStatusID, @GenreID, @DiskName, @ReleasedDate)
      END
 
      --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
            UPDATE Disks
            SET DiskTypeID = @DiskTypeID, DiskStatusID = @DiskStatusID, GenreID = @GenreID, DiskName = @DiskName, ReleasedDate = @ReleasedDate
            WHERE DiskID = @DiskID
      END
 
      --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM Disks
            WHERE DiskID = @DiskID
      END
END
GO

 IF OBJECT_ID('Borrower_SP') IS NOT NULL
   DROP PROC Borrower_SP
 GO

CREATE PROCEDURE [dbo].[Borrower_SP]
      @Action VARCHAR(10),
       @BorrowerID INT = NULL,
       @FirstName VARCHAR(100) = NULL,
       @LastName VARCHAR(100) = NULL,
       @PhoneNumber VARCHAR(100) = NULL
AS
BEGIN
      SET NOCOUNT ON;
 
      --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT BorrowerID, FirstName, LastName, PhoneNumber
            FROM Borrower
      END
 
      --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO Borrower(FirstName, LastName, PhoneNumber)
            VALUES (@FirstName, @LastName, @PhoneNumber)
      END
 
      --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
            UPDATE Borrower
            SET FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber
            WHERE BorrowerID = @BorrowerID
      END
 
      --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM Borrower
            WHERE BorrowerID = @BorrowerID
      END
END
GO

 IF OBJECT_ID('Artist_SP') IS NOT NULL
   DROP PROC Artist_SP
 GO

CREATE PROCEDURE [dbo].[Artist_SP]
      @Action VARCHAR(10),
       @ArtistID INT = NULL,
       @ArtistTypeID INT = NULL,
       @FirstName VARCHAR(100) = NULL,
       @LastName VARCHAR(100) = NULL,
       @GroupName VARCHAR(100) = NULL
AS
BEGIN
      SET NOCOUNT ON;
 
      --SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT ArtistID, ArtistTypeID, FirstName, LastName, GroupName
            FROM Artist
      END
 
      --INSERT
    IF @Action = 'INSERT'
      BEGIN
            INSERT INTO Artist(ArtistTypeID, FirstName, LastName, GroupName)
            VALUES (@ArtistTypeID, @FirstName, @LastName, @GroupName)
      END
 
      --UPDATE
    IF @Action = 'UPDATE'
      BEGIN
            UPDATE Artist
            SET ArtistTypeID = @ArtistTypeID, FirstName = @FirstName, LastName = @LastName, GroupName = @GroupName
            WHERE ArtistID = @ArtistID
      END
 
      --DELETE
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM Artist
            WHERE ArtistID = @ArtistID
      END
END
GO

IF OBJECT_ID('DiskHasBorrower_SP') IS NOT NULL
  DROP PROC DiskHasBorrower_SP
GO

CREATE PROC DiskHasBorrower_SP
       @BorrowerID INT,
       @DiskID INT,
       @BorrowedDate DATETIME,
	   @ReturnedDate DATETIME
AS
    INSERT DiskHasBorrower
    VALUES (
			@BorrowerID,
			@DiskID,
			@BorrowedDate,
			@ReturnedDate
			);
GO

IF OBJECT_ID('DiskOnLoan_SP') IS NOT NULL
  DROP PROC DiskOnLoan_SP
GO

CREATE PROC DiskOnLoan_SP
AS
SELECT *
FROM Disks
WHERE DiskID NOT IN (
	SELECT DiskID
	FROM DiskHasBorrower
	WHERE ReturnedDate IS NULL OR ReturnedDate >= GETDATE()
)



GO

GRANT EXECUTE ON OBJECT::Disks_SP  
    TO SAplus;  
GO
GRANT EXECUTE ON OBJECT::Borrower_SP  
    TO SAplus;  
GO
GRANT EXECUTE ON OBJECT::Artist_SP  
    TO SAplus;  
GO

GRANT EXECUTE ON OBJECT::DiskHasBorrower_SP  
    TO SAplus;  
GO
GRANT EXECUTE ON OBJECT::DiskOnLoan_SP  
    TO SAplus; 
GO 

SELECT *
FROM Disks
WHERE DiskID NOT IN (
	SELECT DiskID
	FROM DiskHasBorrower
	WHERE ReturnedDate IS NULL OR ReturnedDate >= GETDATE()
)