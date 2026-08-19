USE gram_panchayat_db;
SHOW TABLES;


SELECT c.full_name, ct.certificate_name
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name;

SELECT c.full_name, po.office_name
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN panchayat_office po
ON c.village_name = po.village_name;

SELECT ca.application_id, c.full_name, ca.application_status
FROM certificate_application ca
INNER JOIN citizen c
ON ca.citizen_id = c.citizen_id;

SELECT c.full_name, ct.certificate_name, ca.application_date
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name;

SELECT c.full_name, ct.certificate_name, po.office_name,
       ca.application_status
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name
INNER JOIN panchayat_office po
ON c.village_name = po.village_name;

SELECT c.full_name, ct.certificate_name, po.office_name
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name
INNER JOIN panchayat_office po
ON c.village_name = po.village_name
WHERE ct.certificate_name = 'Income Certificate';

SELECT ca.application_id, c.citizen_id, c.full_name,
       po.office_name, ca.application_date, ca.application_status
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN panchayat_office po
ON c.village_name = po.village_name
WHERE po.office_name = 'Nuzvid';

SELECT ca.application_id, ct.description, ca.application_status
FROM certificate_application ca
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name;

SELECT c.full_name, c.village_name, ct.certificate_name,
       po.office_name, ca.application_date
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name
INNER JOIN panchayat_office po
ON c.village_name = po.village_name;
/*10*/
SELECT c.citizen_id, c.full_name, c.village_name,
       ct.certificate_type_id, ct.certificate_name,
       po.office_id, po.office_name,
       ca.application_id, ca.application_date,
       ca.application_status, ca.purpose,
       ca.fee_paid, ca.reference_number
FROM citizen c
INNER JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
INNER JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name
INNER JOIN panchayat_office po
ON c.village_name = po.village_name; 

/*11*/
SELECT c.citizen_id, c.full_name, ca.application_id,
       ca.application_date, ca.application_status
FROM citizen c
LEFT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id;

/*12*/
SELECT ct.certificate_type_id, ct.certificate_name,
       ca.application_id, ca.citizen_id
FROM certificate_application ca
RIGHT JOIN certificate_type ct
ON ca.certificate_name = ct.certificate_name;

/*13*/
SELECT c.citizen_id, c.full_name, ca.application_id,
       ca.application_date, ca.application_status
FROM citizen c
LEFT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id
UNION
SELECT c.citizen_id, c.full_name, ca.application_id,
       ca.application_date, ca.application_status
FROM citizen c
RIGHT JOIN certificate_application ca
ON c.citizen_id = ca.citizen_id;

/*14*/
SELECT c.citizen_id, c.full_name,
       ct.certificate_type_id, ct.certificate_name
FROM citizen c
CROSS JOIN certificate_type ct;
/*15*/
SELECT A.citizen_id AS Citizen1_ID,
       A.full_name AS Citizen1_Name,
       B.citizen_id AS Citizen2_ID,
       B.full_name AS Citizen2_Name,
       A.village_name
FROM citizen A
INNER JOIN citizen B
ON A.village_name = B.village_name
AND A.citizen_id < B.citizen_id;