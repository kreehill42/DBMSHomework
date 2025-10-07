/*
Author: Korben Reehill
ISTE230 Section 05
Professor Hardy
Practice Exercise #3 - Basic Queries to a Table
Date: 09/18/25
*/

USE sakilav2;

# Task 1 - Select title & length from films w/ "fun" in description & <= 120 mins
SELECT title, length
FROM film
WHERE description LIKE '%fun%' AND length <= 120;

# Task 2 - Select Titles ending in a vowel
SELECT title
FROM film
WHERE title LIKE '%a' OR title LIKE '%e' OR title LIKE '%i' OR title LIKE '%o' OR title LIKE '%u';

# Task 3 - Select titles between 120 and 180 minutes
SELECT title
FROM film
WHERE length >= 120 AND length <= 180;


/*
Task 4 - Select titles and lengths of films where
'river' is in the title
rating is either 'pg' or 'pg-13'
*/
SELECT title, length
FROM film
WHERE title LIKE '%river%' AND (rating = 'PG' OR rating = 'PG-13');


# Task 5 - Select film titles released after 2012 longer than 160 minutes
SELECT title
FROM film
WHERE releaseYear > 2012 AND length > 160;

/*
Task 6 - Select name, replacement cost, and rating
from movies without 'a' as the second letter in the title and have a 19.99 replacement cost
*/
SELECT title, replacementCost, rating
FROM film
WHERE title NOT LIKE '_a%' AND replacementCost = 19.99;

/*
Task 7- Select titles of descriptionless movies
*/
SELECT title
FROM film
WHERE description IS NULL;

/*
Task 8 - Select Replacement cost for film 'Town Ark'
*/
SELECT replacementCost
FROM film
WHERE title = 'Town Ark';

/*
Task 9 - Select titles of 'G' rated movies from 2006
or movies rated PG released in 2010
*/
SELECT title
FROM film
WHERE (rating = 'G' AND releaseYear = 2006) OR (rating = 'PG' AND releaseYear = 2010);

/*
Task 10 -Show all data except desc for films not released in 2006 or 2010
*/
SELECT filmID, title, releaseYear, length, replacementCost, rating
FROM film
WHERE releaseYear != 2006 AND releaseYear != 2010;

/*
Task 11 - In one statement, change the replacement cost of all films released in 2006 to 5.59
*/
UPDATE film
SET replacementCost = 5.59 -- this sets the value :(
WHERE releaseYear = 2006; -- this compares values :(

/*
Task 12 - In one statement, change the replacement cost of 2006 films to 10.00
*/
UPDATE film
SET replacementCost = 10.00
WHERE releaseYear = 2006;

/*
Task 13 - Remove all films < 60mins & rated PG in one statement
*/
DELETE
FROM film
WHERE length < 60 AND rating = 'PG';



