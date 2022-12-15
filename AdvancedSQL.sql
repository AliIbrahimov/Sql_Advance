CREATE DATABASE Library
USE Library
CREATE TABLE Books(
Id int PRIMARY KEY IDENTITY,
[Name] varchar(30),
AuthorId int,
[PageCount] int CHECK([PageCount]>10)
)
CREATE TABLE Authors(
Id int PRIMARY KEY IDENTITY,
[Name] varchar(25),
Surname varchar(25)
)
CREATE VIEW BookInfo
As
select bk.Id,bk.Name,bk.PageCount,a.Name + ' ' + a.Surname as FullName from Books bk
JOIN Authors a
ON bk.AuthorId = a.Id

SELECT * FROM BookInfo
CREATE PROCEDURE SelectAuthoor @Name nvarchar(25), @FullName nvarchar(25)
AS
SELECT bk.Id,bk.Name, bk.PageCount,a.Name + ' ' + a.Surname as FullName FROM Books bk 
JOIN Authors a
ON bk.AuthorId=a.ID
WHERE a.Name = @Name OR a.Name + ' ' + a.Surname = @FullName
drop procedure SelectAuthoor
EXEC SelectAuthoor @Name = 'Victor', @FullName = 'Cingiz Abdullayev';

--Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz
CREATE VIEW AuthorInfo
AS
SELECT b.AuthorId, a.Name + ' ' + a.Surname as FullName, 
COUNT(b.Name) AS BooksCount,
MAX(b.PageCount) AS MaxPageCount
FROM Authors a
JOIN Books b 
ON a.ID = b.AuthorId
GROUP BY a.Name,a.Surname,b.AuthorId;
drop view AuthorInfo
SELECT * FROM AuthorInfo

CREATE PROCEDURE InsertAuthor (
@name varchar(30),
@surname varchar(30)
)
AS
INSERT INTO Authors(Name,Surname)
VALUES(@name,@surname)

CREATE PROCEDURE [Update] (
@id int,
@name varchar(30),
@surname varchar(30)
)
AS
UPDATE Authors
SET Name = @name,
Surname = @surname WHERE ID=@id

CREATE PROCEDURE DeleteAuthor (
@id int,
@name varchar(30),
@surname varchar(30)
)
AS
DELETE FROM Authors WHERE ID=@id

