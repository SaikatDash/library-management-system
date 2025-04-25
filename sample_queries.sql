-- Sample Queries for Library Management System

-- Add a new book
INSERT INTO books (title, author, genre, available_copies)
VALUES ('The Alchemist', 'Paulo Coelho', 'Fiction', 5);

-- Add a new member
INSERT INTO members (name, email, join_date)
VALUES ('Alice Johnson', 'alice@email.com', CURDATE());

-- Issue a book
INSERT INTO issued_books (book_id, member_id, issue_date, return_date)
VALUES (1, 2, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));

-- View all issued books
SELECT m.name, b.title, i.issue_date, i.return_date
FROM issued_books i
JOIN members m ON i.member_id = m.member_id
JOIN books b ON i.book_id = b.book_id;

-- Additional Sample Books
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 2', 'Author 2', 'Genre 2', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 3', 'Author 3', 'Genre 3', 5);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 4', 'Author 4', 'Genre 4', 6);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 5', 'Author 5', 'Genre 0', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 6', 'Author 6', 'Genre 1', 5);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 7', 'Author 7', 'Genre 2', 6);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 8', 'Author 8', 'Genre 3', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 9', 'Author 9', 'Genre 4', 5);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 10', 'Author 10', 'Genre 0', 6);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 11', 'Author 11', 'Genre 1', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 12', 'Author 12', 'Genre 2', 5);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 13', 'Author 13', 'Genre 3', 6);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 14', 'Author 14', 'Genre 4', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 15', 'Author 15', 'Genre 0', 5);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 16', 'Author 16', 'Genre 1', 6);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 17', 'Author 17', 'Genre 2', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 18', 'Author 18', 'Genre 3', 5);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 19', 'Author 19', 'Genre 4', 6);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 20', 'Author 20', 'Genre 0', 7);
INSERT INTO books (title, author, genre, available_copies) VALUES ('Book 21', 'Author 21', 'Genre 1', 5);

-- Additional Sample Members
INSERT INTO members (name, email, join_date) VALUES ('Member 2', 'member2@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 3', 'member3@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 4', 'member4@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 5', 'member5@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 6', 'member6@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 7', 'member7@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 8', 'member8@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 9', 'member9@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 10', 'member10@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 11', 'member11@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 12', 'member12@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 13', 'member13@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 14', 'member14@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 15', 'member15@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 16', 'member16@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 17', 'member17@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 18', 'member18@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 19', 'member19@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 20', 'member20@library.com', CURDATE());
INSERT INTO members (name, email, join_date) VALUES ('Member 21', 'member21@library.com', CURDATE());


-- ANALYTICAL QUERIES FOR BETTER UNDERSTANDING --

-- 1. Count of books by genre
SELECT genre, COUNT(*) AS total_books
FROM books
GROUP BY genre;

-- 2. Members who have borrowed the most books
SELECT m.name, COUNT(i.issue_id) AS books_borrowed
FROM issued_books i
JOIN members m ON i.member_id = m.member_id
GROUP BY m.name
ORDER BY books_borrowed DESC
LIMIT 5;

-- 3. Books that are currently available (available_copies > 0)
SELECT title, available_copies
FROM books
WHERE available_copies > 0;

-- 4. Books that are overdue (return_date < CURDATE() AND actual_return_date IS NULL)
SELECT m.name AS member_name, b.title, i.issue_date, i.return_date
FROM issued_books i
JOIN books b ON i.book_id = b.book_id
JOIN members m ON i.member_id = m.member_id
WHERE i.return_date < CURDATE() AND i.actual_return_date IS NULL;

-- 5. Total fine amount collected
SELECT SUM(f.fine_amount) AS total_fines_collected
FROM fines f;

-- 6. Most frequently issued books
SELECT b.title, COUNT(i.book_id) AS times_issued
FROM issued_books i
JOIN books b ON i.book_id = b.book_id
GROUP BY b.title
ORDER BY times_issued DESC
LIMIT 5;

-- 7. Members who have never borrowed a book
SELECT m.name
FROM members m
LEFT JOIN issued_books i ON m.member_id = i.member_id
WHERE i.issue_id IS NULL;

-- 8. Number of books issued per day
SELECT issue_date, COUNT(*) AS total_issues
FROM issued_books
GROUP BY issue_date
ORDER BY issue_date DESC;
