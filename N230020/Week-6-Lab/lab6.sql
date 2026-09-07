USE gram_panchayat_db;

-- LEVEL 1
-- Task 1
SELECT MAX(application_date) AS latest_application_date
FROM Certificate_Application;

-- Task 2
SELECT MIN(application_date) AS earliest_application_date
FROM Certificate_Application;

-- Task 3
SELECT *
FROM Certificate_Application
WHERE application_date = (
    SELECT MAX(application_date)
    FROM Certificate_Application
);

-- Task 4
SELECT *
FROM Certificate_Application
WHERE application_date = (
    SELECT MIN(application_date)
    FROM Certificate_Application
);

-- Task 5
SELECT *
FROM Citizen
WHERE citizen_id IN (
    SELECT citizen_id
    FROM Certificate_Application
    WHERE application_status = 'Approved'
);


-- LEVEL 2

-- Task 1
SELECT *
FROM Certificate_Application
WHERE application_date > (
    SELECT MIN(application_date)
    FROM Certificate_Application
);

-- Task 2
SELECT *
FROM Certificate_Application
WHERE application_date < (
    SELECT MAX(application_date)
    FROM Certificate_Application
);

-- Task 3
SELECT *
FROM Citizen
WHERE citizen_id IN (
    SELECT citizen_id
    FROM Certificate_Application
);

-- Task 4
SELECT *
FROM Citizen
WHERE citizen_id NOT IN (
    SELECT citizen_id
    FROM Certificate_Application
    WHERE application_status = 'Approved'
);

-- Task 5
SELECT *
FROM Certificate_Type
WHERE certificate_name IN (
    SELECT certificate_name
    FROM Certificate_Application
    WHERE application_status = 'Approved'
);

-- Task 6
SELECT *
FROM Certificate_Type
WHERE certificate_name NOT IN (
    SELECT certificate_name
    FROM Certificate_Application
    WHERE application_status = 'Approved'
);

-- Task 7
SELECT *
FROM Certificate_Application
WHERE application_date > (
    SELECT MIN(application_date)
    FROM Certificate_Application
);

-- Task 8
SELECT certificate_name, application_date
FROM Certificate_Application
WHERE application_date = (
    SELECT MAX(application_date)
    FROM Certificate_Application
);


-- LEVEL 3

-- Task 1
SELECT certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY certificate_name
ORDER BY total_applications DESC
LIMIT 1;

-- Task 2
SELECT office_id, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY office_id
ORDER BY total_applications DESC
LIMIT 1;

-- Task 3
SELECT certificate_name, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY certificate_name
HAVING COUNT(*) > (
    SELECT AVG(application_count)
    FROM (
        SELECT COUNT(*) AS application_count
        FROM Certificate_Application
        GROUP BY certificate_name
    ) AS counts
);

-- Task 4
SELECT office_id, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY office_id
HAVING COUNT(*) > ANY (
    SELECT COUNT(*)
    FROM Certificate_Application
    GROUP BY office_id
);

-- Task 5
SELECT office_id, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY office_id
HAVING COUNT(*) > ALL (
    SELECT COUNT(*)
    FROM Certificate_Application
    GROUP BY office_id
);

-- Task 6
SELECT certificate_name, application_date
FROM Certificate_Application
WHERE application_date = (
    SELECT MAX(application_date)
    FROM Certificate_Application
);

-- Task 7
SELECT citizen_id, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY citizen_id
HAVING COUNT(*) > 1;

-- Task 8
SELECT application_status, COUNT(*) AS total_applications
FROM Certificate_Application
GROUP BY application_status
ORDER BY total_applications DESC
LIMIT 1;