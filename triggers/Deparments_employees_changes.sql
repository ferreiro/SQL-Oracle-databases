drop table Departments cascade constraints; 
drop table Employees cascade constraints;
drop table Changes cascade constraints;

CREATE TABLE Departments (CodDept   CHAR(5) PRIMARY KEY,
                          Name      VARCHAR(100));

CREATE TABLE Employees (SSN       CHAR(9) PRIMARY KEY,
                        Name      VARCHAR(100),
                        CodDept    CHAR(5) REFERENCES Departments on    delete set NULL,
                        Salary	NUMBER(4,0));

CREATE TABLE Changes(IdChange 	VARCHAR(10) PRIMARY KEY,
                     UserId   	VARCHAR(8),
                     OldSalary	NUMBER(4,0),
                    NewSalary	NUMBER(4,0));

CREATE SEQUENCE CHANGEID
INCREMENT BY 1
START WITH 1;

INSERT INTO Departments VALUES('1', 'Department 1');
INSERT INTO Departments VALUES('2', 'Department 2');
INSERT INTO Departments VALUES('3', 'Department 3');

INSERT INTO Employees VALUES('123456789', 'PACO', '1', 3000);

UPDATE Employees
SET SALARY=2000
WHERE SSN='123456789';


/*
  Write a trigger that records in the table Changes any update of the salary of the employees. 
  The trigger must store the user, the date of the change, and both the salary before the change and the updated salary. 
  The ID will be obtained from a sequence called SEQChanges.
*/

create or replace TRIGGER UpdateRecords 
after update of Salary on Employees
for each row
begin
  INSERT INTO Changes values (CHANGEID.NEXTVAL, USER(), :OLD.Salary, :NEW.Salary);
end;

/* 
Write a stored procedure that lists for each department the name and salary of each employee whose salary is lower than the average of the department. 
For each department the procedure must show the total amount of these salaries by department.
*/
CREATE OR REPLACE PROCEDURE SALARIES
DECLARE

  CURSOR CursorDeparment is
  SELECT NAME, SALARY
  FROM EMPLOYEE E
  WHERE SALARY<(
    SELECT AVG(SALARY) 
    FROM EMPLOYEE 
    GROUP BY (CodDept)
    WHERE CodDept=E.CodDept
  );
IS
  AUX NUMBER:=0
  v_name varchar;
  v_salary
BEGIN
    
  OPEN CursorDeparment;
  
  LOOP
    FETCH Employee in CursorDeparment;
    EXIT WHEN CursorDeparment&NOTFOUND;
    DBMS.OUTPUT();
  END LOOP;
  
  CLOSE CursorDeparment;
  
END;