
-- 1. List codes and names of pilots  that are certified to pilot Boeing aircrafts. 

SELECT DISTINCT EMPLOYEE.EID, EMPLOYEE.NAME
FROM EMPLOYEE, CERTIFICATE, AIRCRAFT
WHERE EMPLOYEE.EID=CERTIFICATE.EID AND 
      CERTIFICATE.AID=AIRCRAFT.AID AND 
      AIRCRAFT.NAME LIKE '%Boeing%';
      
-- 2. List codes of aircrafts that can fly from Los Angeles to Chicago without refueling. 

SELECT AID, NAME
FROM AIRCRAFT
WHERE DISTANCE>=1749;

-- 3. List pilots that have a certificate to pilot aircrafts with a range of 3,000 km. but cannot pilot Boeing aircrafts. 

/*
SELECT DISTINCT Employee.Name, Employee.EID
FROM EMPLOYEE, CERTIFICATE, AIRCRAFT
WHERE EMPLOYEE.EID=CERTIFICATE.EID AND CERTIFICATE.AID=AIRCRAFT.AID AND
      AIRCRAFT.DISTANCE <=3000
GROUP BY Employee.Name, Employee.EID 
HAVING AIRCRAFT.NAME!='%Boeing%'; 

SELECT DISTINCT EID
FROM EMPLOYEE, CERTIFICATE, AIRCRAFT
WHERE EMPLOYEE.EID=CERTIFICATE.EID AND CERTIFICATE.AID=AIRCRAFT.AID AND 
      AIRCRAFT.DISTANCE <= 3000
GROUP BY EID
HAVING Aircraft.Name NOT LIKE '%Boeing%'
ORDER BY EMPLOYEE.EID ASC;
*/

-- 4. List of employees that have the highest salary. 

SELECT EID, NAME
FROM EMPLOYEE
WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEE);
  
-- 5. List of employees that have the highest number of certificates. 

SELECT EID, COUNT(AID)
FROM EMPLOYEE NATURAL JOIN CERTIFICATE
GROUP BY EID
HAVING COUNT(AID)=(SELECT MAX(COUNT(AID)) FROM CERTIFICATE GROUP BY EID);

-- 6. List of employees that have at least 3 certificates. 

SELECT DISTINCT EID
FROM CERTIFICATE
GROUP BY EID
HAVING COUNT(AID)>=3; 
  
  -- si QUIERES meterle el nomre 
  SELECT EID, NAME
  FROM EMPLOYEE
  WHERE EID IN (
    SELECT EID
    FROM CERTIFICATE
    GROUP BY EID
    HAVING COUNT(AID)>=3
  );
  
-- 7. List of names of the aircrafts such that all the pilots that can pilot them  have a salary greater than 80.000€. 
/*
SELECT DISTINCT NAME, AID
FROM CERTIFICATE NATURAL JOIN AIRCRAFT
WHERE EID IS ALL ( SELECT EID FROM EMPLOYEE WHERE SALARY >= 80000 );

SELECT DISTINCT AIRCRAFT.NAME
FROM EMPLOYEE, CERTIFICATE, AIRCRAFT 
WHERE EMPLOYEE.EID=CERTIFICATE.EID AND CERTIFICATE.AID=AIRCRAFT.AID AND
      EMPLOYEE.SALARY>=80000;
*/

-- 8. For each pilot that can pilot more than 3 aircrafts, show the code of the pilot and the distance that these aircrafts can cover.

SELECT EID, MAX(DISTANCE)
FROM CERTIFICATE NATURAL JOIN AIRCRAFT
GROUP BY EID
HAVING COUNT(AID)>3;

-- 9. List the names of the pilots whose salary is less than the cheaper flight from Los Angeles to Honolulu. 

SELECT NAME
FROM EMPLOYEE
WHERE SALARY <(
  SELECT MIN(PRICE)
  FROM FLIGHT
  WHERE ORIGIN='Los Angeles' AND DESTINATION='Honolulu'
) AND EID IN (SELECT DISTINCT EID FROM CERTIFICATE);

-- 10. Show the difference  of the avarage salary of all the employees (pilots included) and the average salary of the pilots. 
/*
BAD
SELECT AVG(SALARY) - AVG(
  SELECT SALARY
  FROM EMPLOYEE
  WHERE EID IN (SELECT DISTINCT EID FROM CERTIFICATE)
)
FROM EMPLOYEE;
*/
-- 11. List of the names and salaries of the employees (no pilots) whose salary is greater than the average salary of the pilots. 

SELECT NAME, SALARY
FROM EMPLOYEE
WHERE EID NOT IN (SELECT DISTINCT EID FROM CERTIFICATE)
      AND SALARY>(
          SELECT AVG(SALARY) 
          FROM EMPLOYEE 
          WHERE EID IN (SELECT DISTINCT EID FROM CERTIFICATE
      )
);

-- 12. List the names of the pilots that can pilot ONLY aircrafts with a range greater than 1000Km. 
/*
SELECT EID, NAME
FROM EMPLOYEE
WHERE EID IN (
  SELECT EID
  FROM CERTIFICATE
  GROUP BY EID
  HAVING AID IN ALL(SELECT AID FROM AIRCRAFT WHERE DISTANCE > 1000)
);
*/