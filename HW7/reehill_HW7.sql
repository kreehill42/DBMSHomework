# File: reehill_HW7.sql
# Name: Korben Reehill
# ISTE230 - Intro to DBs and Data Modeling
# Professor Hardy
# Date: 11/17/25
# Homework #7 - Implementing a Relational Schema using SQL

DROP DATABASE IF EXISTS reehill_ACMEOnline;
CREATE DATABASE reehill_ACMEOnline;
USE reehill_ACMEOnline;

# CREATING TABLES & IMPLEMENTING SCHEMA
# Simple Tables

CREATE TABLE category(
    categoryName VARCHAR(35),
    shippingPerPound DECIMAL(4, 2),
    offersAllowed ENUM('y', 'n') NOT NULL,
CONSTRAINT category_pk PRIMARY KEY (categoryName)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC category;


CREATE TABLE item(
    itemNumber INT UNSIGNED AUTO_INCREMENT,
    itemName VARCHAR(35) NOT NULL,
    description VARCHAR(255),
    model VARCHAR(50) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    categoryName VARCHAR(35),
    # if the value for categoryName is changed in CATEGORY, the change should be reflected here as well
CONSTRAINT item_categoryName_fk FOREIGN KEY (categoryName) REFERENCES category(categoryName) ON UPDATE CASCADE,
CONSTRAINT item_pk PRIMARY KEY (itemNumber)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC item;


CREATE TABLE offer(
    offerCode VARCHAR(15),
    discountAmt VARCHAR(35) NOT NULL,
    minAmount DECIMAL(4, 2) NOT NULL,
    expirationDate DATE NOT NULL,
CONSTRAINT offer_pk PRIMARY KEY (offerCode)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC offer;

# Customer Tables
CREATE TABLE customer(
    customerID INT UNSIGNED AUTO_INCREMENT,
    customerName VARCHAR(50) NOT NULL,
    address VARCHAR(150) NOT NULL,
    email VARCHAR(80),
    customerType ENUM('b', 'h', 'n'),
CONSTRAINT customer_pk PRIMARY KEY (customerID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC customer;

# Dependent Tables

CREATE TABLE ordered(
    orderID INT UNSIGNED AUTO_INCREMENT,
    totalCost DECIMAL(10, 2),
    customerID INT UNSIGNED,
    offerCode VARCHAR(15),
CONSTRAINT ordered_customerID_fk FOREIGN KEY (customerID) REFERENCES customer(customerID) ON UPDATE CASCADE,
CONSTRAINT ordered_offerCode_fk FOREIGN KEY (offerCode) REFERENCES offer(offerCode) ON UPDATE CASCADE,
CONSTRAINT ordered_pk PRIMARY KEY (orderID)
# if the customerID of a customer is changed, that should reflect here
# if the offercode of an offer is changed, that should reflect here
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC ordered;


CREATE TABLE line_item(
    itemNumber INT UNSIGNED,
    orderID INT UNSIGNED,
    quantity TINYINT UNSIGNED,
    shippingAmount DECIMAL(6, 2),
CONSTRAINT line_item_itemNumber_fk FOREIGN KEY (itemNumber) REFERENCES item(itemNumber) ON UPDATE CASCADE,
CONSTRAINT line_item_orderID_fk FOREIGN KEY (orderID) REFERENCES ordered(orderID) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT line_item_pk PRIMARY KEY (itemNumber, orderID)
# if an orderID in ORDERED is changed, then should change here too
# if the itemNUmber of an ITEM is change, then...
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC line_item;


CREATE TABLE business(
    customerID INT UNSIGNED,
    paymentTerms VARCHAR(50) NOT NULL,
CONSTRAINT business_customerID_fk FOREIGN KEY (customerID) REFERENCES customer(customerID) ON UPDATE CASCADE,
CONSTRAINT business_pk PRIMARY KEY (customerID)
# if customerID changes in Customer, should change here
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC business;

CREATE TABLE home(
    customerID INT UNSIGNED,
    creditCardNum CHAR(16) NOT NULL,
    cardExpiration CHAR(6) NOT NULL,
CONSTRAINT home_customerID_fk FOREIGN KEY (customerID) REFERENCES customer(customerID) ON UPDATE CASCADE,
CONSTRAINT home_pk PRIMARY KEY (customerID)
# if customerID changed in customer, should change here
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC home;


CREATE TABLE purchase_contact(
    contactName VARCHAR(50),
    contactPhone CHAR(12) NOT NULL,
    customerID INT UNSIGNED,
CONSTRAINT purchase_contact_customerID_fk FOREIGN KEY (customerID) REFERENCES business(customerID) ON UPDATE CASCADE,
CONSTRAINT purchase_contact_pk PRIMARY KEY (contactName)
# when customerID of a BUSINESS is changed, should here too
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC purchase_contact;


CREATE TABLE guarantee(
    orderID INT UNSIGNED,
    customerID INT UNSIGNED,
    url VARCHAR(50),
    refundAmount DECIMAL(12, 2),
CONSTRAINT guarantee_orderID_fk FOREIGN KEY (orderID) REFERENCES ordered(orderID) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT guarantee_customerID_fk FOREIGN KEY (customerID) REFERENCES home(customerID) ON UPDATE CASCADE,
CONSTRAINT guarantee PRIMARY KEY (orderID, customerID)
# when orderID changed or deleted, shouuld be reflected in guarantee
# when customerID is changed, should be here too
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC guarantee;





# INSERTING INFO
INSERT INTO category (categoryName, shippingPerPound, offersAllowed)
VALUES
("Books", 0.99, 'y'),
("Home", 1.99, 'y'),
("Jewelry", 0.99, 'n'),
("Toys", 0.99, 'y');


INSERT INTO item (itemName, description, model, price, categoryName)
VALUES
("Cabbage Patch Doll", "Baby boy doll", "Boy", 39.95, "Toys"),
("The Last Lecture", "Written by Randy Pausch", "Hardcover", 9.95, "Books"),
("Keurig Beverage Maker", "Keurig Platinum Edition Beverage Maker in Red", "Platinum Edition", 299.95, "Home"),
("1ct diamond ring in white gold", "diamond is certified vvs, D, round", "64gt32", 4000.00, "Jewelry");


INSERT INTO offer(offerCode, discountAmt, minAmount, expirationDate)
VALUES
("345743213", "20% off", 20.00, "2013-12-31"),
("4567890123", "30% off", 30.00, "2013-12-31");


# INSERTION AND TRANSACTIONS

# JANINE JEFFERS TRANSACTION
START TRANSACTION;
INSERT INTO customer(customerName, address, email, customerType)
VALUES ("Janine Jeffers", "152 Lomb Memorial Dr., Rochester, NY 14623", "jxj1234@rit.edu", 'h');

INSERT INTO home(customerID, creditCardNum, cardExpiration)
VALUES((SELECT customerID FROM customer WHERE customerName="Janine Jeffers"), "1234567890123456", "012014");

INSERT INTO ordered(customerID, offerCode, totalCost)
VALUES((SELECT customerID FROM customer WHERE customerName="Janine Jeffers"), "4567890123", 4919.75);

INSERT INTO line_item(orderID, itemNumber, quantity, shippingAmount)
VALUES
((SELECT orderID FROM ordered WHERE orderID=1), (SELECT itemNumber FROM item WHERE itemNumber=4), 1, .99),
((SELECT orderID FROM ordered WHERE orderID=1), (SELECT itemNumber FROM item WHERE itemNumber=2), 2, 3.99);

INSERT INTO line_item(orderID, itemNumber, quantity)
VALUES((SELECT orderID FROM ordered WHERE orderID=1), (SELECT itemNumber FROM item WHERE itemNumber=3), 3);

COMMIT;

# JOEY JOHN BARBER SHOP TRANSACTION
START TRANSACTION;
INSERT INTO customer(customerName, address, email, customerType)
VALUES ("Joey John Barber Shop", "15 John St., Rochester, NY 14623", "jj1978@hotmail.com", 'b');

INSERT INTO business(customerID, paymentTerms)
VALUES((SELECT customerID FROM customer WHERE customerName="Joey John Barber Shop"), "30/90 days");

INSERT INTO ordered(customerID, offerCode, totalCost)
VALUES((SELECT customerID FROM customer WHERE customerName="Joey John Barber Shop"), "345743213", 299.95);

INSERT INTO line_item(orderID, itemNumber, quantity)
VALUES((SELECT orderID FROM ordered WHERE orderID=2), (SELECT itemNumber FROM item WHERE itemNumber=3), 1);

INSERT INTO purchase_contact(customerID, contactName, contactPhone)
VALUES((SELECT customerID FROM business WHERE customerID=(SELECT customerID FROM customer WHERE customerName="Joey John Barber Shop")), "Joey James", "585-475-1234");

COMMIT;

