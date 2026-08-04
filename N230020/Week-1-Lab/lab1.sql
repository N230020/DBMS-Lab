DROP DATABASE IF EXISTS gram_panchayat_db;

CREATE DATABASE gram_panchayat_db;

USE gram_panchayat_db;

CREATE TABLE citizen(
citizen_id INT PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
date_of_birth DATE NOT NULL,
gender VARCHAR(10) NOT NULL,
mobile_number VARCHAR(15) UNIQUE NOT NULL,
occupation VARCHAR(50),
village_name VARCHAR(50) NOT NULL,
is_active BOOLEAN NOT NULL
);

CREATE TABLE certificate_type(
certificate_type_id INT PRIMARY KEY,
certificate_name VARCHAR(100) UNIQUE NOT NULL,
description VARCHAR(200) NOT NULL,
processing_days INT NOT NULL,
application_fee DECIMAL(8,2) NOT NULL,
is_available BOOLEAN NOT NULL
);

CREATE TABLE certificate_application(
application_id INT PRIMARY KEY,
citizen_id INT NOT NULL,
certificate_name VARCHAR(100) NOT NULL,
application_date DATE NOT NULL,
purpose VARCHAR(200) NOT NULL,
application_status VARCHAR(30) NOT NULL,
fee_paid DECIMAL(8,2) NOT NULL,
reference_number VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE panchayat_office(
office_id INT PRIMARY KEY,
office_name VARCHAR(100) NOT NULL,
village_name VARCHAR(50) NOT NULL,
pincode VARCHAR(6) NOT NULL,
contact_number VARCHAR(15) UNIQUE,
office_email VARCHAR(100) UNIQUE,
opening_time TIME NOT NULL,
is_operational BOOLEAN NOT NULL
);

INSERT INTO citizen(citizen_id,full_name,date_of_birth,gender,mobile_number,occupation,village_name,is_active)
VALUES
(101,'Ravi Kumar','1995-06-15','Male','9876500001','Farmer','Ramapuram',TRUE),
(102,'Lakshmi Devi','1988-11-22','Female','9876500002','Tailor','Ramapuram',TRUE),
(103,'Suresh Babu','1992-03-10','Male','9876500003','Shopkeeper','Seethampeta',TRUE),
(104,'Anjali Rao','2000-08-05','Female','9876500004','Student','Ramapuram',TRUE),
(105,'Kiran Kumar','1985-01-18','Male','9876500005','Electrician','Seethampeta',TRUE),
(106,'Meena Kumari','1998-12-30','Female','9876500006','Teacher','Lakshmipuram',FALSE);

INSERT INTO certificate_type(certificate_type_id,certificate_name,description,processing_days,application_fee,is_available)
VALUES
(1,'Residence Certificate','Certifies the declared place of residence',7,30.00,TRUE),
(2,'Birth Record Request','Request for a locally maintained birth record',5,20.00,TRUE),
(3,'Death Record Request','Request for a locally maintained death record',5,20.00,TRUE),
(4,'Family Member Certificate','Records declared family-member information',10,40.00,TRUE),
(5,'Property Certificate','Certificate related to locally maintained property records',15,50.00,TRUE),
(6,'No-Dues Certificate','Indicates applicable local dues status',7,25.00,FALSE);

INSERT INTO certificate_application(application_id,citizen_id,certificate_name,application_date,purpose,application_status,fee_paid,reference_number)
VALUES
(1001,101,'Residence Certificate    ','2026-07-01','Bank account documentation','Submitted',30.00,'GP20260001'),
(1002,102,'Family Member Certificate','2026-07-02','Welfare scheme application','Under Review',40.00,'GP20260002'),
(1003,103,'Property Certificate','2026-07-03','Property documentation','Submitted',50.00,'GP20260003'),
(1004,104,'Residence Certificate','2026-07-04','College admission','Approved',30.00,'GP20260004'),
(1005,105,'No-Dues Certificate','2026-07-05','Local service requirement','Under Review',25.00,'GP20260005'),
(1006,106,'Birth Record Request','2026-07-06','Personal documentation','Rejected',20.00,'GP20260006');

INSERT INTO panchayat_office(office_id,office_name,village_name,pincode,contact_number,office_email,opening_time,is_operational)
VALUES
(1,'Ramapuram Gram Panchayat','Ramapuram','521101','0866000001','ramapuram@gp.example','09:00:00',TRUE),
(2,'Seethampeta Gram Panchayat','Seethampeta','521102','0866000002','seethampeta@gp.example','09:30:00',TRUE),
(3,'Lakshmipuram Gram Panchayat','Lakshmipuram','521103','0866000003','lakshmipuram@gp.example','09:00:00',TRUE),
(4,'Krishnapuram Gram Panchayat','Krishnapuram','521104','0866000004','krishnapuram@gp.example','10:00:00',TRUE),
(5,'Venkatapuram Gram Panchayat','Venkatapuram','521105','0866000005','venkatapuram@gp.example','09:30:00',TRUE),
(6,'Gopalapuram Gram Panchayat','Gopalapuram','521106','0866000006','gopalapuram@gp.example','09:00:00',FALSE);

INSERT INTO citizen(citizen_id,full_name,date_of_birth,gender,mobile_number,occupation,village_name,is_active)
VALUES
(107,'Ramesh Kumar','1996-05-12','Male','9876500007','Engineer','Krishnapuram',TRUE);

INSERT INTO certificate_type(certificate_type_id,certificate_name,description,processing_days,application_fee,is_available)
VALUES
(7,'Income Certificate','Certifies annual income',10,35.00,TRUE);

UPDATE certificate_application
SET application_status='Under Review'
WHERE application_id=1001;

UPDATE certificate_application
SET application_status='Approved'
WHERE application_id=1002;

UPDATE citizen
SET occupation='Electrical Technician'
WHERE citizen_id=105;

UPDATE certificate_type
SET processing_days=12
WHERE certificate_type_id=5;

UPDATE certificate_type
SET is_available=TRUE
WHERE certificate_type_id=6;

DELETE FROM citizen
WHERE citizen_id=107;

ALTER TABLE citizen
ADD address VARCHAR(200);

ALTER TABLE certificate_application
ADD issued_date DATE;

ALTER TABLE certificate_application
MODIFY purpose VARCHAR(500);

ALTER TABLE panchayat_office
ADD closing_time TIME;

/*CREATE TABLE temporary_request(
request_id INT PRIMARY KEY,
request_name VARCHAR(100) NOT NULL,
request_date DATE NOT NULL
);

INSERT INTO temporary_request(request_id,request_name,request_date)
VALUES
(1,'Water Connection','2026-07-01'),
(2,'Street Light Repair','2026-07-02'),
(3,'Road Maintenance','2026-07-03');

SELECT * FROM temporary_request;

TRUNCATE TABLE temporary_request;

DROP TABLE temporary_request;*/
SELECT * FROM citizen;
SELECT * FROM certificate_type;
SELECT * FROM certificate_application;
SELECT * FROM panchayat_office;