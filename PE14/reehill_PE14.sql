/*
File: reehill_PE14.sql
Name: Korben Reehill
ISTE230 -- Intro to DBs & Data Modeling
Professor Hardy
PE14 -- Queries & Functions
*/
USE book;



/*
Task 1
Display the reviewer's name, book title, and rating for books
that have a rating between 5 and 7. Sort the results by rating
in descending order and then by title in ascending order.
*/
SELECT reviewer.name AS "Review Name", book.title AS "Book Title", bookReview.rating AS "Rating"
FROM (
    book JOIN bookReview
    ON book.isbn = bookReview.isbn
) JOIN reviewer
ON bookReview.reviewerID = reviewer.reviewerID
WHERE bookReview.rating BETWEEN 5 AND 7
ORDER BY bookReview.rating DESC, book.title ASC;


/*
Task 2
List the owners and the books they own. List owners even if
they do not own a book. List the owner's first and last name
and the book's title.
*/
SELECT owner.firstName AS "FirstName", owner.lastName AS "LastName", book.title AS "Title"
FROM (
    owner LEFT JOIN ownersBook
    ON owner.ownerID = ownersBook.ownerID
) LEFT JOIN book
ON ownersBook.isbn = book.isbn;


/*
Task 3
Show the publisher name and location, count of their ISBN numbers,
length of the longest title, and length of the shortest titles
for books published by publishers that have 'read' in the
publisher's name (MUST USE INSTR()) and have published MORE than
one book
*/
SELECT CONCAT(publisher.name, " in ", publisher.city, ", ", publisher.stateCode) AS "Publisher Name and Location", COUNT(book.isbn) AS "# Books", MAX(LENGTH(book.title)) AS "Longest Title", MIN(LENGTH(book.title)) AS "Shortest Title"
FROM book JOIN publisher
ON book.publisherID = publisher.publisherID
WHERE INSTR(LOWER(publisher.name), "read") != 0 
GROUP BY publisher.name, publisher.city, publisher.stateCode
HAVING COUNT(CASE WHEN (book.publisherID = publisher.publisherID) THEN 1 ELSE NULL END) > 1;

/*
Task 4
Show the title and its average rating, rounded to the nearest
whole number, and the first 20 characters of the book's
description, for all books that have 'THE' in the title in
descending order by average rank and title. Make sure that case
does not impact your results. Your output should match the
display given below.
*/
SELECT book.title AS "Title", TRUNCATE(AVG(bookReview.rating), 0) AS "Avg Rating", CONCAT(SUBSTR(book.description, 1, 20),"...") AS "Description Excerpt"
FROM book LEFT JOIN bookReview
ON book.isbn = bookReview.isbn
WHERE INSTR(UPPER(book.title), "THE") != 0
GROUP BY book.title, book.description, bookReview.rating
ORDER BY bookReview.rating DESC, book.title DESC;

