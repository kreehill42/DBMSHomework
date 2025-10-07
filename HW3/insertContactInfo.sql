-- Updated 09/5/2022
-- Inserts record into contactInfo
-- Please notice not every attribute/field listed has a value
-- Number of attribute names is 8
-- Number of values is 7

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
