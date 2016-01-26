
/* 
Write a stored procedure that lists for each department the name and salary of each employee whose salary is lower than the average of the department. 
For each department the procedure must show the total amount of these salaries by department.
*/
create or replace PROCEDURE MY_SALARIESPROC
IS

  CURSOR cursorDeparment is
  SELECT Name, SALARY
  FROM EMPLOYEES E
  WHERE SALARY<(
    SELECT AVG(SALARY) 
    FROM EMPLOYEES
    WHERE CodDept=E.CodDept
    GROUP BY (CodDept)
  );
  
  AUX NUMBER:=0;
  v_name VARCHAR(100);
  rEmployee cursorDeparment%ROWTYPE;

BEGIN

  OPEN cursorDeparment;
   
  LOOP
    FETCH cursorDeparment into rEmployee;
    EXIT WHEN cursorDeparment%NOTFOUND;
      dbms_output.put_line(rEmployee.Name || ', ' || rEmployee.Salary);
  END LOOP;
  
  CLOSE CursorDeparment;

END;