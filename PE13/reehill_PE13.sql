# File: reehill_PE13.sql
# Name: Korben Reehill
# ISTE230 - Intro to DBs & Data Modeling
# Professor Hardy
# Date: 11/23/25

USE PE13;


# Task 1
# Display model, manufacturer, serial number, processor speed, and memory for computer with itemID=3
SELECT item.model, item.manufacturer, computer.serialNumber, computer.processorSpeed, computer.memory
FROM item JOIN computer
ON item.itemID = computer.itemID
WHERE item.itemID = 3;

# Task 2
# Display leaseNum, salesPerson, itemID, and quantity for any trucks leased
SELECT lease.leaseNumber, lease.salesperson, leaseItem.itemID, leaseItem.quantity
FROM (
    leaseItem RIGHT JOIN truck
    ON leaseItem.itemID = truck.itemID
    )
 JOIN lease
ON lease.leaseNumber = leaseItem.leaseNumber;

# Task 3
# Display all attributes for itemID = 7
SELECT item.itemID, item.type, item.manufacturer, item.model, item.leaseRate, computer.itemID, computer.serialNumber, computer.processorSpeed, computer.memory, computer.dimensions, computer.hardDriveSpace, computer.cdRomSpeed, truck.itemID, truck.vinNumber, truck.color, truck.milesPerGallon, truck.transmissionType, truck.towingCapacity, truck.numberofAxles, furniture.itemID, furniture.dimensions, furniture.weight, furniture.color
FROM(
    (
        (
            item LEFT JOIN computer
            ON item.itemID = computer.itemID
        )
    LEFT JOIN truck
    ON item.itemID = truck.itemID
    )
LEFT JOIN furniture
ON item.itemID = furniture.itemID
)
WHERE item.itemID = 7;

# Done!

