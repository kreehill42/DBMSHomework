/*
File: reehill_hw8.sql
Name: Korben Reehill
ISTE230 - Intro to DBs and Data Modeling
Professor Hardy
Date: 12/8/2025
Homework 8: Relational Algebra, Subqueries, and Joins
*/

USE jobsV2;



/*
Task 1
Write a SQL statement that will accomplish the equivalent of the
following theoretical relational algebra statement:
(EMPLOYER[stateCode]) + (QUARTER[location])
*/
SELECT stateCode
FROM employer
UNION
SELECT location
FROM quarter;



/*
Task 2
Write a SQL statement that will accomplish the equivalent of a
theoretical relational algebra equijoin between employer and interview
with a projection of companyName, division, stateCode, and 
salaryOffered.
(Hint: make sure you are joining on the entire primary key/foreign key
relationships)
*/
SELECT employer.companyName, employer.division, employer.stateCode, interview.salaryOffered
FROM employer JOIN interview
ON employer.companyName = interview.companyName AND employer.division = interview.division;


/*
Task 3
Write a SQL statement that accomplishes the equivalent of the
following theoretical relational algebra statement: STATE-EMPLOYER
*/
SELECT *
FROM state
WHERE stateCode NOT IN (
    SELECT stateCode
    FROM employer
);


/*
Task 4
Write a SQL statement that performs the equivalent of the following
theoretical relational algebra statement:
INTERVIEW[companyName, minHrsOffered]
*/
SELECT DISTINCT companyName, minHrsOffered
FROM interview;


/*
Task 5
Write a SQL statement that accomplishes a theoretical relational
algebra selection from the state table that includes all of the
tuples/records that have a vowel as the 3rd letter of the description
*/
SELECT *
FROM state
WHERE description RLIKE '^..[aAeEiIoOuU]';


/*
Task 6
Write a SQL statement that will show the quarter code, location,
and state description for locations in the quarter table that are
also found in state.
*/
SELECT quarter.qtrCode, quarter.location, state.description
FROM quarter JOIN state
ON quarter.location = state.stateCode;



/*
Task 7
Write a SQL statement that will show the description for ALL states
as well as the ompanynames of employers located each state.
*/
SELECT state.description, employer.companyName
FROM state LEFT JOIN employer
ON state.stateCode = employer.stateCode;

