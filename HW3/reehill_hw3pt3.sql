/*
Author: Korben Reehill
Homework 3 -- Basic DDL & DML Part 2
ISTE230.05: Intro to DBs & Data Modeling
Professor Perez-Hardy
*/

/*
Task 1 - Add New Data into contactInfo Table
Add data in Appendix A to contactInfo table
Add a record for yourself
Results in total 5 records
Show the contents of the database using a select command
*/
INSERT INTO contactInfo
(contactID, firstName, middleInitial, lastName, email, url, birthday, notes)
VALUES 
(3, 'Eli', 'T', 'Wallowby', 'etwallowby@concor.com', 'www.concor.com/~wallowby', '1956-03-26', 'All meetings must be scheduled through his assistant.'),
(4, 'Eve', 'C', 'Sampson', 'esampson@concor.com', NULL, '1972-05-11', 'Very helpful.'),
(5, 'Carson', 'B', 'Campbell', 'cbc232@mvch.org', NULL, '1955-01-05', 'Wife: Lisa Kids: Lucas, Lucy, and Lucinda.'),
(2, 'Korben', 'C', 'Reehill', 'kcr5563@rit.edu', NULL, '2005-05-17', NULL);

SELECT *
FROM contactInfo;

/*
Task 2 - Add an attribute to the contactInfo table
Add an attribute called 'nickname' to the contactInfo table
VARCHAR(20), does not have to have a value
DEFAULT 'To Be Determined'
DESC table
*/
ALTER TABLE contactInfo
ADD COLUMN nickname VARCHAR(20) DEFAULT 'To Be Determined';

DESC contactInfo;

/*
Task 3 - Add constraints to the contactInfo table
Modify firstName & lastName attributes so that value is required
DESC table
*/
ALTER TABLE contactInfo
MODIFY COLUMN firstName VARCHAR(15) NOT NULL,
MODIFY COLUMN lastName VARCHAR(25) NOT NULL;

DESC contactInfo;

/*
Task 4 - Update an existing record
UPDATE record for Munson -- give him 'Dave' nickname
SELECT him name to prove change implemented
*/
UPDATE contactInfo
SET nickname='Dave'
WHERE contactID=1;

SELECT nickname, firstName, lastName
FROM contactInfo
WHERE contactID=1;


/*
Task 5 - Delete records
Single statement that will delete the record with
url: www.concor.com/~wallowby
Show the final contents of the table with the appropriate SELECT cmd
*/

DELETE
FROM contactInfo
WHERE url='www.concor.com/~wallowby';

SELECT *
FROM contactInfo;
