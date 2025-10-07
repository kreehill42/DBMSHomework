/*
Author: Korben Reehill
ISTE230 Section 05
Professor Hardy
Practice Exercise #4 - Altering a Table
Date: 09/18/25
*/

USE pe4;

/*
    Task #1 - Change Existing Attributes
*/
ALTER TABLE contactinfo
MODIFY COLUMN firstName VARCHAR(15) NOT NULL DEFAULT 'UNKNOWN',
MODIFY COLUMN lastName VARCHAR(30) NOT NULL DEFAULT 'UNKNOWN';

DESC contactinfo;


/*
    Task #2 - Add a Record
*/
INSERT INTO contactinfo
(contactID) VALUES (2);

SELECT contactID, firstName, lastName
FROM contactinfo;


/*
    Task #3 - Add a New Attribute
*/
ALTER TABLE contactinfo
ADD COLUMN owes DECIMAL(6,2);

DESC contactinfo;

/*
    Task #4 - Imagine a New Identifier
    ----------------------------------
    If removing contactID, I would choose to use the contact's email as an identifier.
    Email services require the addresses to be unique to the individual,
    all contacts should have an email, and they're still stored, single attributes,
    making for a perfect choice for a primary key.
*/


