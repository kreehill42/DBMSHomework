/*
Author: Korben Reehill
Homework 3 -- Basic DDL & DML Part 2
ISTE230.05: Intro to DBs & Data Modeling
Professor Perez-Hardy
*/

# Querying the WORLD Database

USE world;

/*
Task 1 -- Who is the head of state for
'United States'?
*/
SELECT headOfState AS "Head of State"
FROM Country
WHERE name='United States';

/*
Task 2 -- Using a single statement, change where
the head of state is listed as 'Donald J. Trump' to the
name of the past President...
*/
UPDATE Country
SET headOfState='Joseph R. Biden'
WHERE name='United States';

SELECT headOfState
FROM Country
WHERE name='United States';

/*
Task #3 -- Show the name of the countries
that doe not have an independence year specified
*/
SELECT name
FROM Country
WHERE indepYear IS NULL;

/*
Task #4 -- Show the name and continent of countries
that have a population of 1 billion or more and
a life expentancy between 70-80
*/
SELECT name, continent
FROM Country
WHERE (population>=1000000000) AND (lifeExpectancy BETWEEN 70 AND 80);

/*
Task #5 -- List the countries located in the
continents of 'North America' and 'South America'
*/
SELECt name
FROM Country
WHERE continent IN ('North America', 'South America');




