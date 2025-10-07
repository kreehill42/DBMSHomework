/*
Author: Korben Reehill
Homework 3 -- Basic DDL & DML Part 1
ISTE230.05: Intro to DBs & Data Modeling
Professor Perez-Hardy
*/

# Implement a Single Entity

DROP DATABASE IF EXISTS inventory; -- might want to remove later

CREATE DATABASE inventory;

USE inventory;

CREATE TABLE ITEM(
    itemID VARCHAR(25),
    itemName VARCHAR(25),
    name VARCHAR(25),
    street VARCHAR(25),
    city VARCHAR(25),
    colors VARCHAR(25),
    state CHAR(2),
    zipcode VARCHAR(10),
    cost VARCHAR(10),
    retailPrice VARCHAR(10),
    notes VARCHAR(255),
    description VARCHAR(255),
    returnable CHAR,
    perishable CHAR,
    shelfQty INT UNSIGNED,
    CONSTRAINT itemID_pk PRIMARY KEY (itemID),
    CONSTRAINT qty_chk CHECK (shelfQty BETWEEN 0 AND 50000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC item; -- might want to remove later



