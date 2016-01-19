CREATE TABLE Contracts(Ref  VARCHAR(10) PRIMARY KEY,
                       Organization      VARCHAR(100),
                       ContDate        DATE,
                       NumRoutes NUMBER(2,0));

CREATE TABLE Routes(Ref VARCHAR(10) REFERENCES Contracts ON DELETE CASCADE,
                      Origin     	  VARCHAR(50),
                      Destination    VARCHAR(50),
                      Vehicle        VARCHAR(20),
                      PRIMARY KEY (Ref, Origin, Destination));
                            
/*insert into Routes values ('0123456789', 'Lisboa', 'oporto', 'mercedes');  */                         
/*insert into Routes values ('0123456789', 'Lisboa', 'Madrid', 'mercedes');  */                          
/*DELETE FROM Routes
WHERE Ref='0123456789' && Origin='Lisboa' && Destination='Madrid' && Vehicle='mercedes';*/

/* Creating a procedure */
create or replace 
PROCEDURE myContractProcedure
(ReferenceContract IN VARCHAR)
IS
    v_numberRoutes number:= 0;
    v_noValues boolean:= false;
    v_organizationName contracts.organization%type:= 'Name';
    noRoutes Exception;
    
BEGIN
  
    /* Print organization name */
    /* Cuando no exista la referencia que te pasan por parámetro, esto
      va a lanzar una excepción de no_Data_found, porque te lanzará NULL
    */
    SELECT Contracts.Organization INTO v_organizationName
    FROM Contracts
    WHERE Contracts.REF=ReferenceContract;
     
    /* Select the number of references that appears on Routes given a referenceContract pass by value */
    Select NVL(COUNT(ReferenceContract), 0) into v_numberRoutes
    from Routes
    where Ref=ReferenceContract;
    
    if (v_numberRoutes <= 0) then
        Raise noRoutes;
    else
      /* Count is greater than 0. 
        Update value of refernce contracts */
      UPDATE Contracts
      SET NumRoutes = v_numberRoutes
      WHERE Contracts.Ref=ReferenceContract;
    end if;
    
    /* Print the total number of routes founded */
    DBMS_OUTPUT.PUT_LINE(v_organizationName || ' ' ||v_numberRoutes ); 
   
    EXCEPTION
    WHEN noRoutes then
       DBMS_OUTPUT.PUT_LINE('No routes for this reference');
    WHEN NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Reference does not exist.');
END;


/* Creating a trigger */
CREATE OR REPLACE TRIGGER organizationTrigger
AFTER INSERT OR DELETE OR UPDATE ON Routes
for each row

BEGIN
    
    IF DELETING THEN
        UPDATE Contracts
        SET NumRoutes = NumRoutes-1
        WHERE Contracts.Ref=:old.Ref;
    ELSIF INSERTING THEN
        UPDATE Contracts
        SET NumRoutes = NumRoutes+1
        WHERE Contracts.Ref=:new.Ref;
    END IF;  
    
END;  
