USE gram_panchayat_db;
USE gram_panchayat_db;
SHOW TABLES;
SELECT * FROM Citizen;
SELECT * FROM Certificate_Type;
SELECT * FROM Panchayat_Office;
SELECT * FROM Certificate_Application;
ALTER TABLE Certificate_Application
DROP COLUMN certificate_name;
ALTER TABLE Certificate_Application
DROP COLUMN office_name;
ALTER TABLE Certificate_Application
ADD COLUMN certificate_id INT;
ALTER TABLE Certificate_Application
ADD COLUMN office_id INT;
UPDATE Certificate_Application ca
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
SET ca.certificate_id = ct.certificate_type_id;
UPDATE Certificate_Application ca
JOIN Panchayat_Office po
ON ca.office_id = po.office_id
SET ca.office_id = po.office_id;

-- If your old Certificate_Application table still has
-- certificate_name and office_name while performing the
-- redesign, use these instead BEFORE dropping the columns:

-- UPDATE Certificate_Application ca
-- JOIN Certificate_Type ct
-- ON ca.certificate_name = ct.certificate_name
-- SET ca.certificate_id = ct.certificate_type_id;

-- UPDATE Certificate_Application ca
-- JOIN Panchayat_Office po
-- ON ca.office_name = po.office_name
-- SET ca.office_id = po.office_id;

-- Verify the populated IDs

SELECT * FROM Certificate_Application;

-- Activity 4: Create Foreign Key Constraints

ALTER TABLE Certificate_Application
ADD CONSTRAINT fk_application_citizen
FOREIGN KEY (citizen_id)
REFERENCES Citizen(citizen_id);

ALTER TABLE Certificate_Application
ADD CONSTRAINT fk_application_certificate
FOREIGN KEY (certificate_id)
REFERENCES Certificate_Type(certificate_type_id);

ALTER TABLE Certificate_Application
ADD CONSTRAINT fk_application_office
FOREIGN KEY (office_id)
REFERENCES Panchayat_Office(office_id);

-- Activity 5: Verify Foreign Key Constraints

SHOW CREATE TABLE Certificate_Application;

-- Activity 6: Test Referential Integrity

-- Attempt 1:
-- Insert application with non-existing citizen_id

INSERT INTO Certificate_Application
(application_id, citizen_id, application_date,
purpose, application_status, fee_paid,
reference_number, certificate_id, office_id)
VALUES
(1010, 999, '2026-07-10',
'Test Application', 'Pending', 30.00,
'GP20260100', 1, 1);

-- Expected: ERROR because citizen_id 999 does not exist.

-- Attempt 2:
-- Insert application with non-existing certificate_id

INSERT INTO Certificate_Application
(application_id, citizen_id, application_date,
purpose, application_status, fee_paid,
reference_number, certificate_id, office_id)
VALUES
(1011, 101, '2026-07-10',
'Test Application', 'Pending', 30.00,
'GP20260101', 999, 1);

-- Expected: ERROR because certificate_id 999 does not exist.

-- Attempt 3:
-- Delete a citizen whose application already exists

DELETE FROM Citizen
WHERE citizen_id = 101;

-- Expected: ERROR because citizen 101 is referenced
-- by Certificate_Application.

-- Attempt 4:
-- Delete a certificate type that is referenced

DELETE FROM Certificate_Type
WHERE certificate_type_id = 1;

-- Expected: ERROR because certificate type 1 is referenced
-- by Certificate_Application.

-- ============================================================
-- PART C – SQL QUERY PRACTICE
-- ============================================================

-- ============================================================
-- LEVEL 0 – BASIC RETRIEVAL QUERIES
-- ============================================================

-- Query 1:
-- Display all records from Citizen

SELECT *
FROM Citizen;

-- Query 2:
-- Display all records from Certificate_Application

SELECT *
FROM Certificate_Application;

-- Query 3:
-- Display names of all citizens in ascending order

SELECT full_name
FROM Citizen
ORDER BY full_name ASC;

-- Query 4:
-- Display all unique villages using DISTINCT

SELECT DISTINCT village_name
FROM Citizen;

-- Query 5:
-- Display all unique certificate types using DISTINCT

SELECT DISTINCT certificate_name
FROM Certificate_Type;

-- Query 6:
-- Display all unique Panchayat Offices using DISTINCT

SELECT DISTINCT office_name
FROM Panchayat_Office;

-- Query 7:
-- Display certificate applications whose status is Pending

SELECT *
FROM Certificate_Application
WHERE application_status = 'Pending';

-- Query 8:
-- Display citizens belonging to Ramapuram village

SELECT *
FROM Citizen
WHERE village_name = 'Ramapuram';

-- Query 9:
-- Display applications submitted during 2026

SELECT *
FROM Certificate_Application
WHERE YEAR(application_date) = 2026;

-- Query 10:
-- Display applications ordered by Application_Date
-- in descending order

SELECT *
FROM Certificate_Application
ORDER BY application_date DESC;

-- Query 11:
-- Display all applications processed by Nuzvid Panchayat Office

SELECT ca.*
FROM Certificate_Application ca
JOIN Panchayat_Office po
ON ca.office_id = po.office_id
WHERE po.office_name LIKE '%Nuzvid%';

-- Query 12:
-- Display names of citizens who applied for
-- an Income Certificate

SELECT DISTINCT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate';

-- ============================================================
-- LEVEL 1 – FOREIGN KEYS & SET OPERATORS
-- ============================================================

-- Query 13:
-- Citizens who applied for either Income Certificate
-- or Residence Certificate using UNION

SELECT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

UNION

SELECT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';

-- Query 14:
-- Certificate applications submitted during
-- January and February using UNION

SELECT *
FROM Certificate_Application
WHERE MONTH(application_date) = 1

UNION

SELECT *
FROM Certificate_Application
WHERE MONTH(application_date) = 2;

-- Query 15:
-- Citizens belonging to Ramapuram and Lakshmipuram
-- using UNION

SELECT full_name
FROM Citizen
WHERE village_name = 'Ramapuram'

UNION

SELECT full_name
FROM Citizen
WHERE village_name = 'Lakshmipuram';

SELECT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

INTERSECT

SELECT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';


SELECT citizen_id
FROM Certificate_Application
WHERE YEAR(application_date) = 2025

INTERSECT

SELECT citizen_id
FROM Certificate_Application
WHERE YEAR(application_date) = 2026;
SELECT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Income Certificate'

EXCEPT
SELECT c.full_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.certificate_name = 'Residence Certificate';
SELECT application_id
FROM Certificate_Application
WHERE YEAR(application_date) = 2026
EXCEPT
SELECT application_id
FROM Certificate_Application
WHERE YEAR(application_date) = 2025;
INSERT INTO Certificate_Application
(application_id, citizen_id, application_date,
purpose, application_status, fee_paid,
reference_number, certificate_id, office_id)
VALUES
(1012, 999, '2026-07-11',
'Invalid citizen test', 'Pending', 30.00,
'GP20260102', 1, 1);
DELETE FROM Citizen
WHERE citizen_id = 101;
SELECT full_name
FROM Citizen
WHERE citizen_id IN
(
SELECT citizen_id
FROM Certificate_Application
);
SELECT full_name
FROM Citizen
WHERE village_name IN
(
SELECT village_name
FROM Citizen
WHERE citizen_id IN
(
SELECT ca.citizen_id
FROM Certificate_Application ca
WHERE ca.certificate_id IN
(
SELECT certificate_type_id
FROM Certificate_Type
WHERE certificate_name = 'Income Certificate'
)
)
);
SELECT full_name
FROM Citizen
WHERE citizen_id NOT IN
(
SELECT citizen_id
FROM Certificate_Application
);
SELECT office_name
FROM Panchayat_Office
WHERE office_id NOT IN
(
SELECT office_id
FROM Certificate_Application
);
SELECT c.full_name
FROM Citizen c
WHERE EXISTS
(
SELECT *
FROM Certificate_Application ca
WHERE ca.citizen_id = c.citizen_id
);
SELECT ct.certificate_name
FROM Certificate_Type ct
WHERE EXISTS
(
SELECT *
FROM Certificate_Application ca
WHERE ca.certificate_id = ct.certificate_type_id
);
SELECT c.full_name
FROM Citizen c
WHERE NOT EXISTS
(
SELECT *
FROM Certificate_Application ca
WHERE ca.citizen_id = c.citizen_id
);
SELECT ct.certificate_name
FROM Certificate_Type ct
WHERE NOT EXISTS
(
SELECT *
FROM Certificate_Application ca
WHERE ca.certificate_id = ct.certificate_type_id
);
SELECT full_name
FROM Citizen
WHERE TIMESTAMPDIFF(
YEAR,
date_of_birth,
CURDATE()
)
>
ANY
(
SELECT TIMESTAMPDIFF(
YEAR,
date_of_birth,
CURDATE()
)
FROM Citizen
WHERE village_name = 'Ramapuram'
);

-- Query 32:
-- Applications whose processing time is greater than
-- ANY application processed by Nuzvid Panchayat Office

SELECT ca.application_id,
ct.certificate_name,
ct.processing_days
FROM Certificate_Application ca
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.processing_days >
ANY
(
SELECT ct2.processing_days
FROM Certificate_Application ca2
JOIN Certificate_Type ct2
ON ca2.certificate_id = ct2.certificate_type_id
JOIN Panchayat_Office po2
ON ca2.office_id = po2.office_id
WHERE po2.office_name LIKE '%Nuzvid%'
);
SELECT full_name
FROM Citizen
WHERE TIMESTAMPDIFF(
YEAR,
date_of_birth,
CURDATE()
)
>
ALL
(
SELECT TIMESTAMPDIFF(
YEAR,
date_of_birth,
CURDATE()
)
FROM Citizen
WHERE village_name = 'Ramapuram'
);
SELECT ca.application_id,
ct.certificate_name,
ct.processing_days
FROM Certificate_Application ca
JOIN Certificate_Type ct
ON ca.certificate_id = ct.certificate_type_id
WHERE ct.processing_days >
ALL
(
SELECT ct2.processing_days
FROM Certificate_Application ca2
JOIN Certificate_Type ct2
ON ca2.certificate_id = ct2.certificate_type_id
JOIN Panchayat_Office po2
ON ca2.office_id = po2.office_id
WHERE po2.office_name LIKE '%Nuzvid%'
);
SELECT c.citizen_id,
c.full_name,
COUNT(ca.application_id) AS total_applications
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
GROUP BY c.citizen_id, c.full_name
ORDER BY total_applications DESC
LIMIT 1;
SELECT po.office_id,
po.office_name,
COUNT(ca.application_id) AS total_applications
FROM Panchayat_Office po
JOIN Certificate_Application ca
ON po.office_id = ca.office_id
GROUP BY po.office_id, po.office_name
ORDER BY total_applications DESC
LIMIT 1;
SELECT ct.certificate_name,
COUNT(ca.application_id) AS total_applications
FROM Certificate_Type ct
JOIN Certificate_Application ca
ON ct.certificate_type_id = ca.certificate_id
GROUP BY ct.certificate_type_id, ct.certificate_name
HAVING COUNT(ca.application_id) > 5;
SELECT village_name
FROM Citizen
WHERE village_name NOT IN
(
SELECT DISTINCT c.village_name
FROM Citizen c
JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
);
SELECT c.citizen_id,
c.full_name
FROM Citizen c
WHERE NOT EXISTS
(
SELECT ct.certificate_type_id
FROM Certificate_Type ct
WHERE ct.is_available = TRUE
AND NOT EXISTS
(
SELECT *
FROM Certificate_Application ca
WHERE ca.citizen_id = c.citizen_id
AND ca.certificate_id = ct.certificate_type_id
)
);
SELECT c.citizen_id,
c.full_name,
COUNT(ca.application_id) AS total_applications
FROM Citizen c
LEFT JOIN Certificate_Application ca
ON c.citizen_id = ca.citizen_id
GROUP BY c.citizen_id, c.full_name
ORDER BY total_applications DESC;