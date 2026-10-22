
CREATE DATABASE company; 
GO

USE company; 
GO
CREATE TABLE Floors (
    Number INT PRIMARY KEY,
    NumOfBlocks INT,
    Manager_ID INT, 
    HiringDate DATE
);
CREATE TABLE Employees (
    Emp_ID INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(255),
    DOB DATE,
    Salary DECIMAL(10, 2),
    Bonus DECIMAL(10, 2),
    FloorNum INT,
    SuperID INT,
    FOREIGN KEY (FloorNum) REFERENCES Floors(Number),
    FOREIGN KEY (SuperID) REFERENCES Employees(Emp_ID)
);
ALTER TABLE Floors 
ADD CONSTRAINT FK_Floor_Manager 
FOREIGN KEY (Manager_ID) REFERENCES Employees(Emp_ID);
CREATE TABLE Users (
    SSN VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Emp_ID INT,
    FOREIGN KEY (Emp_ID) REFERENCES Employees(Emp_ID)
);
CREATE TABLE User_Phones (
    UserSSN VARCHAR(20),
    Phone VARCHAR(20),
    PRIMARY KEY (UserSSN, Phone),
    FOREIGN KEY (UserSSN) REFERENCES Users(SSN)
);
CREATE TABLE Shelf (
    Code VARCHAR(20) PRIMARY KEY,
    FloorNum INT,
    FOREIGN KEY (FloorNum) REFERENCES Floors(Number)
);
CREATE TABLE Categories (
    ID INT PRIMARY KEY,
    CatName VARCHAR(100)
);
CREATE TABLE Publishers (
    ID INT PRIMARY KEY,
    Name VARCHAR(100)
);
CREATE TABLE Authors (
    ID INT PRIMARY KEY,
    Name VARCHAR(100)
);
CREATE TABLE Books (
    ID INT PRIMARY KEY,
    Title VARCHAR(200),
    ShelfCode VARCHAR(20),
    CatID INT,
    PublishID INT,
    FOREIGN KEY (ShelfCode) REFERENCES Shelf(Code),
    FOREIGN KEY (CatID) REFERENCES Categories(ID),
    FOREIGN KEY (PublishID) REFERENCES Publishers(ID)
);
CREATE TABLE Book_Authors (
    BookID INT,
    AuthorId INT,
    PRIMARY KEY (BookID, AuthorId),
    FOREIGN KEY (BookID) REFERENCES Books(ID),
    FOREIGN KEY (AuthorId) REFERENCES Authors(ID)
);
CREATE TABLE Borrow (
    EmpId INT,
    BookId INT,
    UserSSN VARCHAR(20),
    DateBorrowed DATE,
    DueDate DATE,
    Amount DECIMAL(10, 2),
    PRIMARY KEY (BookId, UserSSN, DateBorrowed),
    FOREIGN KEY (EmpId) REFERENCES Employees(Emp_ID),
    FOREIGN KEY (BookId) REFERENCES Books(ID),
    FOREIGN KEY (UserSSN) REFERENCES Users(SSN)
);
INSERT INTO Floors (Number, NumOfBlocks, HiringDate) VALUES 
(1, 10, '2020-01-15'),
(2, 15, '2021-03-20'),
(3, 8, '2022-06-10');
INSERT INTO Categories (ID, CatName) VALUES 
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics');
INSERT INTO Publishers (ID, Name) VALUES 
(1, 'O Reilly'),
(2, 'Pearson'),
(3, 'Springer');
INSERT INTO Authors (ID, Name) VALUES 
(1, 'Robert Martin'),
(2, 'Thomas Cormen'),
(3, 'Donald Knuth');
INSERT INTO Employees (Emp_ID, FName, LName, Phone, Email, Salary, FloorNum) VALUES 
(101, 'Ahmed', 'Ali', '010111', 'ahmed@company.com', 5000, 1),
(102, 'Sara', 'John', '010222', 'sara@company.com', 6000, 2),
(103, 'Mona', 'Zaki', '010333', 'mona@company.com', 5500, 3);
UPDATE Floors SET Manager_ID = 101 WHERE Number = 1;
UPDATE Floors SET Manager_ID = 102 WHERE Number = 2;
UPDATE Floors SET Manager_ID = 103 WHERE Number = 3;
