# Date updated:  12/08/2020

-- Drops the conman database if it exists

DROP DATABASE IF EXISTS pe4;
CREATE DATABASE pe4;
USE pe4;


-- Creates the contactInfo table

/* Since the database is dropped if it exists,
   there is no reason to drop the table */

CREATE TABLE contactInfo(
contactID INT                   Comment "This will be the Primary Key",
firstName VARCHAR(15),
middleInitial CHAR(1),
lastName VARCHAR(25),
email VARCHAR(40),
url VARCHAR(55),
birthday date,
notes VARCHAR(255),
CONSTRAINT contactInfo_pk PRIMARY KEY(contactID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Inserts the initial DATABASE

INSERT INTO contactInfo
(contactID,
firstName,
middleInitial,
lastName,
email,
url,
birthday,
notes)
VALUES
(1,
'David',
'C',
'Munson',
'munson@rit.edu',
'http://www.rit.edu/president',
NULL,
'Started as President of RIT on July 1, 2017.');
