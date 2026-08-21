Use gram_panchayat_db;
show tables;

USE gram_panchayat_db;

-- LEVEL 1

-- Task 1
SELECT COUNT(*) AS total_applications
FROM Certificate_Application;

-- Task 2
SELECT COUNT(*) AS total_citizens
FROM Citizen;

-- Task 3
SELECT COUNT(DISTINCT certificate_name) AS different_certificate_types
FROM Certificate_Application;

-- Task 4
SELECT MIN(application_date) AS earliest_application_date
FROM Certificate_Application;

-- Task 5
SELECT MAX(application_date) AS latest_application_date
FROM Certificate_Application;


-- LEVEL 2

-- Task 1
SELECT application_status, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY application_status;

-- Task 2
SELECT certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY certificate_name;

-- Task 3
SELECT p.office_name, COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Citizen c
ON ca.citizen_id = c.citizen_id
INNER JOIN Panchayat_Office p
ON c.village_name = p.village_name
GROUP BY p.office_name;

-- Task 4
SELECT village_name, COUNT(*) AS total_citizens
FROM Citizen
GROUP BY village_name;

-- Task 5
SELECT application_date, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY application_date;

-- Task 6
SELECT ca.certificate_name, p.office_name,
       COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Citizen c
ON ca.citizen_id = c.citizen_id
INNER JOIN Panchayat_Office p
ON c.village_name = p.village_name
GROUP BY ca.certificate_name, p.office_name;

-- Task 7
SELECT ct.certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Certificate_Type ct
ON ca.certificate_name = ct.certificate_name
GROUP BY ct.certificate_name;

-- Task 8
SELECT p.office_name, COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Citizen c
ON ca.citizen_id = c.citizen_id
INNER JOIN Panchayat_Office p
ON c.village_name = p.village_name
GROUP BY p.office_name;


-- LEVEL 3

-- Task 1
SELECT certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY certificate_name
HAVING COUNT(*) > 2;

-- Task 2
SELECT p.office_name, COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Citizen c
ON ca.citizen_id = c.citizen_id
INNER JOIN Panchayat_Office p
ON c.village_name = p.village_name
GROUP BY p.office_name
HAVING COUNT(*) > 2;

-- Task 3
SELECT certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY certificate_name
ORDER BY COUNT(*) DESC;

-- Task 4
SELECT p.office_name, COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Citizen c
ON ca.citizen_id = c.citizen_id
INNER JOIN Panchayat_Office p
ON c.village_name = p.village_name
GROUP BY p.office_name
ORDER BY COUNT(*) ASC;

-- Task 5
SELECT certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY certificate_name
HAVING COUNT(*) > 2
ORDER BY COUNT(*) DESC;

-- Task 6
SELECT ca.certificate_name, p.office_name,
       COUNT(*) AS total_applications
FROM Certificate_Application ca
INNER JOIN Citizen c
ON ca.citizen_id = c.citizen_id
INNER JOIN Panchayat_Office p
ON c.village_name = p.village_name
GROUP BY ca.certificate_name, p.office_name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Task 7
SELECT application_status, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY application_status
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Task 8
SELECT application_status, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY application_status
ORDER BY COUNT(*) ASC
LIMIT 1;