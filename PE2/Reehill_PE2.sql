/*
Author: Korben Reehill
ISTE230.05 : Intro to Databases & Data Modeling
Professor Hardy
Practice Exercise #2 - Creating a Database with a Table
*/

DROP DATABASE IF EXISTS KCRPE2;

CREATE DATABASE KCRPE2;
SHOW DATABASES;

USE KCRPE2;

DROP TABLE IF EXISTS BOOK;
CREATE TABLE BOOK(
    title VARCHAR(50),
    isbn13Number CHAR(13),
    author VARCHAR(255),
    numberOfPages INT,
    releaseDate DATE,
    CONSTRAINT isbn_pk PRIMARY KEY (isbn13Number)
)ENGINE = InnoDB DEFAULT CHARSET = "utf8";