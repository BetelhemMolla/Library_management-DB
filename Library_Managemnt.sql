-- ========================================================
-- Library Management System Database
-- Author: Your Name
-- Description: A full-featured library management database.
-- ========================================================

-- ========================================================
-- DROP TABLES IF THEY EXIST (for easy re-creation)
-- ========================================================
DROP TABLE IF EXISTS BookAuthors;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Authors;

-- ========================================================
-- TABLE 1: Members
-- Stores library members
-- ========================================================
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each member
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

-- ========================================================
-- TABLE 2: Authors
-- Stores book authors
-- ========================================================
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,    -- Unique ID for each author
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

-- ========================================================
-- TABLE 3: Books
-- Stores book information
-- ========================================================
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,      -- Unique ID for each book
    Title VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedYear YEAR,
    CopiesAvailable INT DEFAULT 1
);

-- ========================================================
-- TABLE 4: BookAuthors
-- Many-to-Many relationship between Books and Authors
-- ========================================================
CREATE TABLE BookAuthors (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- ========================================================
-- TABLE 5: Loans
-- Tracks which member borrowed which book and when
-- ========================================================
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE
);

-- ========================================================
-- SAMPLE DATA INSERTION (Optional)
-- ========================================================
-- Members
INSERT INTO Members (FirstName, LastName, Email, Phone)
VALUES ('John', 'Doe', 'john@example.com', '1234567890'),
       ('Jane', 'Smith', 'jane@example.com', '0987654321');

-- Authors
INSERT INTO Authors (FirstName, LastName)
VALUES ('George', 'Orwell'),
       ('J.K.', 'Rowling');

-- Books
INSERT INTO Books (Title, ISBN, PublishedYear, CopiesAvailable)
VALUES ('1984', '9780451524935', 1949, 5),
       ('Harry Potter and the Sorcerer''s Stone', '9780590353427', 1997, 3);

-- BookAuthors
INSERT INTO BookAuthors (BookID, AuthorID)
VALUES (1, 1),  -- 1984 by George Orwell
       (2, 2);  -- Harry Potter by J.K. Rowling

-- Loans
INSERT INTO Loans (MemberID, BookID, LoanDate, ReturnDate)
VALUES (1, 1, '2025-08-01', NULL),
       (2, 2, '2025-08-03', '2025-08-10');

-- ========================================================
-- END OF SQL FILE
-- ========================================================