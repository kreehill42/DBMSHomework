DROP DATABASE IF EXISTS PE13;
CREATE DATABASE PE13;
USE PE13;

DROP TABLE IF EXISTS item;
CREATE TABLE item (
  itemID int NOT NULL,
  type char(10) default NULL,
  manufacturer char(20) default NULL,
  model char(20) default NULL,
  leaseRate double default NULL,
  CONSTRAINT item_pk PRIMARY KEY(itemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO item VALUES (1,'Computer','Bell','OfficePro',89),(2,'Computer','Bell','OfficePro',99),(3,'Computer','Bell','OfficePro',119),(4,'Computer','Bell','OfficePro',149),(5,'Truck','Industrial','Box Van',400),(6,'Truck','Industrial','Box Van (Long)',450),(7,'Truck','Industrial','Flat Bed',800),(8,'Truck','Industrial','Semi',1200),(9,'Furniture','Brookstone','Efficency1',20),(10,'Furniture','Brookstone','Efficency2',25),(11,'Furniture','Brookstone','EfficencyPlus',30),(12,'Furniture','Brookstone','Executive',50),(13,'Furniture','Brookstone','ExecutivePlus',60);

DROP TABLE IF EXISTS computer;
CREATE TABLE computer (
  itemID int NOT NULL,
  serialNumber char(20) NOT NULL,
  processorSpeed int NOT NULL,
  memory char(10) NOT NULL,
  dimensions char(10) NOT NULL,
  hardDriveSpace char(10) NOT NULL,
  cdRomSpeed char(10) NOT NULL,
  CONSTRAINT computer_pk PRIMARY KEY(itemID),
  CONSTRAINT computer_itemID_fk FOREIGN KEY(itemID) REFERENCES item(itemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO computer VALUES (1,'abc123',800,'128meg','24x18x6','10gigs','48'),(2,'abc124',800,'128meg','24x18x6','10gigs','48'),(3,'abc234',800,'256meg','24x18x6','20gigs','52'),(4,'abc235',800,'512meg','24x18x6','30gigs','52');

DROP TABLE IF EXISTS furniture;
CREATE TABLE furniture (
  itemID int NOT NULL,
  dimensions char(20) NOT NULL,
  weight int NOT NULL,
  color char(20) NOT NULL,
  CONSTRAINT furniture_pk PRIMARY KEY(itemID),
  CONSTRAINT furniture_itemID_fk FOREIGN KEY(itemID) REFERENCES item(ItemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO furniture VALUES (9,'5x3x3',40,'Brown'),(10,'5x3x3',45,'Brown'),(11,'5x3x3',45,'Black'),(12,'6x4x3',60,'Cherry'),(13,'6x4x3',70,'Cherry');

DROP TABLE IF EXISTS truck;
CREATE TABLE truck (
  itemID int NOT NULL,
  vinNumber char(20) NOT NULL,
  color char(20) NOT NULL,
  milesPerGallon tinyint(4) NOT NULL,
  transmissionType char(10) NOT NULL,
  towingCapacity int NOT NULL,
  numberOfAxles tinyint(4) NOT NULL,
  CONSTRAINT truck_pk PRIMARY KEY(itemID),
  CONSTRAINT vehicle_itemID_fk FOREIGN KEY(itemID) REFERENCES item(itemID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO truck VALUES (5,'12345','White',15,'Auto',6000,2),(6,'12346','White',13,'Auto',8000,2),(7,'12347','Black',10,'Manual',14000,3),(8,'12348','Black',8,'Manual',20000,4);

DROP TABLE IF EXISTS lease;
CREATE TABLE lease (
  leaseNumber int NOT NULL,
  activeDate datetime NOT NULL,
  customerID int NOT NULL,
  term char(20) NOT NULL,
  salesperson char(20) NOT NULL,
  notes text,
  CONSTRAINT lease_pk PRIMARY KEY(leaseNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO lease VALUES (1,'2001-01-01 00:00:00',1,'24 Months','John Smith','Customer always pays on time, follow up call often.');

DROP TABLE IF EXISTS leaseItem;
CREATE TABLE leaseItem (
  leaseNumber int NOT NULL,
  itemID int NOT NULL,
  quantity int NOT NULL,
  CONSTRAINT leaseItem_pk PRIMARY KEY(leaseNumber,itemID),
  CONSTRAINT leaseItem_itemID_fk FOREIGN KEY(itemID) REFERENCES item(itemID),
  CONSTRAINT leaseItem_leaseNumber_fk FOREIGN KEY(leaseNumber) REFERENCES lease(leaseNumber)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO leaseItem VALUES (1,1,20),(1,2,20),(1,3,20),(1,4,10),(1,5,4),(1,6,2),(1,7,1),(1,8,1),(1,9,3),(1,10,10),(1,11,5),(1,12,2),(1,13,2);
