CREATE DATABASE Library
USE Library
CREATE TABLE Books(
Id int PRIMARY KEY IDENTITY,
[Name] varchar(30),
AuthorId int,
[PageCount] int CHECK([PageCount]>10)
)
drop table Books
INSERT INTO Books([Name],AuthorId,PageCount)
VALUES
('Book1',1,234),
('Book2',3,331),
('Book1',2,134),
('Book1',4,443)
CREATE TABLE Authors(
Id int PRIMARY KEY IDENTITY,
[Name] varchar(25),
Surname varchar(25)
)
INSERT INTO Authors([Name],Surname)
VALUES
('Khalid','Huseyni'),
('Victor','Hugo'),
('Calil','Mammadguluzade'),
('Jack','London')
CREATE VIEW BookInfo
As
select bk.Id,bk.Name,bk.PageCount,a.Name + ' ' + a.Surname as FullName from Books bk
JOIN Authors a
ON bk.AuthorId = a.Id

SELECT * FROM BookInfo
drop view BookInfo
CREATE PROCEDURE SelectAuthoor @Name nvarchar(25), @FullName nvarchar(25)
AS
SELECT * FROM Authors WHERE Name = @Name OR Name + Surname = @FullName
drop procedure SelectAuthoor
EXEC SelectAuthoor @Name = 'Victor', @FullName = '';



--Authors-lari Id,FullName,BooksCount,MaxPageCount seklinde qaytaran view yaradirsiniz
CREATE VIEW AuthorInfo
As
SELECT a.Id, CONCAT(a.Name, ' ', a.Surname) AS FullName, 
COUNT(b.Id) AS BooksCount,
MAX(b.PageCount) AS MaxPageCount
FROM Authors a
JOIN Books b ON a.Id = b.AuthorId
GROUP BY a.Id;

