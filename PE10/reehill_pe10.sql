# File: reehill_pe10.sql
# Name: Korben Reehill
# ISTE230 - Intro to DBs and Data Modeling
# Professor Hardy
# Date: 11/12/25
# Practice Exercise #10 - Implementing a Relational Schema using SQL


DROP DATABASE IF EXISTS reehill_pe10;
CREATE DATABASE reehill_pe10;
USE reehill_pe10;

CREATE TABLE person(
    personID INT AUTO_INCREMENT NOT NULL,
    firstName VARCHAR(25),
    lastName VARCHAR(25),
    subtype ENUM('s', 'p', 'n', 'b') NOT NULL,
CONSTRAINT person_pk PRIMARY KEY (personID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC person;

CREATE TABLE department(
    deptNum TINYINT AUTO_INCREMENT,
    name VARCHAR(50),
CONSTRAINT department_pk PRIMARY KEY (deptNum)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC department;

CREATE TABLE insurance_company(
    coID INT AUTO_INCREMENT,
    name VARCHAR(80),
CONSTRAINT insurance_company_pk PRIMARY KEY (coID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC insurance_company;

# Subtype of person
CREATE TABLE staff(
    staffID INT,
    managerID INT,
    stafftype ENUM('s','n', 'd') NOT NULL,
CONSTRAINT staff_staffID_fk FOREIGN KEY (staffID) REFERENCES person(personID),
CONSTRAINT staff_managerID_fk FOREIGN KEY (managerID) REFERENCES staff(staffID),
CONSTRAINT staff_pk PRIMARY KEY (staffID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC staff;

# Subtype of staff
CREATE TABLE doctor(
    doctorID INT,
    mentorID INT,
CONSTRAINT doctor_doctorID_fk FOREIGN KEY (doctorID) REFERENCES staff(staffID),
CONSTRAINT doctor_mentorID_fk FOREIGN KEY (mentorID) REFERENCES doctor(doctorID),
CONSTRAINT doctor_pk PRIMARY KEY (doctorID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC doctor;

# Subtype of staff
CREATE TABLE nurse(
    nurseID INT,
    certification ENUM('LPN', 'RN', 'APRN') NOT NULL,
CONSTRAINT nurse_nurseID_fk FOREIGN KEY (nurseID) REFERENCES staff(staffID),
CONSTRAINT nurse_pk PRIMARY KEY (nurseID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC nurse;

# Subtype of person
CREATE TABLE patient(
    patientID INT,
    doctorID INT,
CONSTRAINT patient_patientID_fk FOREIGN KEY (patientID) REFERENCES person(personID),
CONSTRAINT patient_doctorID_fk FOREIGN KEY (doctorID) REFERENCES doctor(doctorID),
CONSTRAINT patient_pk PRIMARY KEY (patientID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC patient;

# Subtype of staff
CREATE TABLE support_staff(
    supportStaffID INT,
    wage DECIMAL(4, 2) NOT NULL,
CONSTRAINT support_staff_supportStaffID_fk FOREIGN KEY (supportStaffID) REFERENCES staff(staffID),
CONSTRAINT support_staff_pk PRIMARY KEY (supportStaffID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC support_staff;

# Dependent on insurance_company, patient
CREATE TABLE insurance_policy(
    policyNum VARCHAR(25),
    patientID INT,
    insCoID INT,
CONSTRAINT insurance_policy_patientID_fk FOREIGN KEY (patientID) REFERENCES patient(patientID),
CONSTRAINT insurance_policy_insCoID_fk FOREIGN KEY (insCoID) REFERENCES insurance_company(coID),
CONSTRAINT insurance_policy_pk PRIMARY KEY (policyNum, patientID, insCoID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC insurance_policy;

# Dependent on department and staff
CREATE TABLE department_staff(
    deptNum TINYINT,
    staffID INT,
CONSTRAINT department_staff_deptNum_fk FOREIGN KEY (deptNum) REFERENCES department(deptNum),
CONSTRAINT department_staff_staffID_fk FOREIGN KEY (staffID) REFERENCES staff(staffID),
CONSTRAINT department_staff_pk PRIMARY KEY (deptNum, staffID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

DESC department_staff;

