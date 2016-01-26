CREATE TABLE Contracts(Ref  VARCHAR(10) PRIMARY KEY,
                       Organization      VARCHAR(100),
                       ContDate        DATE,
                       NumRoutes NUMBER(2,0));


CREATE TABLE Routes(Ref VARCHAR(10) REFERENCES Contracts ON DELETE CASCADE,
                      Origin     	  VARCHAR(50),
                      Destination    VARCHAR(50),
                      Vehicle        VARCHAR(20),
                      PRIMARY KEY (Ref, Origin, Destination));

INSERT INTO CONTRACTS VALUES('123', 'FDI', '1/1/1994', 0);
INSERT INTO Routes VALUES('123', 'MADRID', 'VALENCIA', 'SEAT');
INSERT INTO Routes VALUES('123', 'MADRID', 'SALAMANCA', 'SEAT');
INSERT INTO Routes VALUES('123', 'MADRID', 'BILBAO', 'SEAT');


/* 
  Write a stored procedure with a reference contract as input parameter. 
  
  1. The procedure must update the information in NumRoutes, according to the number of routes associated with the contract. 
  2. The procedure also must print the name of the organization and the total number of associated routes. You must declare 
  an exception that is thrown to show a message if the reference does not have associated any route.
*/

create or replace PROCEDURE updateNumRoutes 
(contractReference IN VARCHAR)
IS
  -- Get the number of routes associated with a contract
  newNumRoutes Contracts.NumRoutes%TYPE:= 0;
  orgName varchar(100);
  totalRoutes number:= 0;
  noAssociateRoute exception;
  
BEGIN

    SELECT count(Ref) INTO newNumRoutes
    from Routes
    where Ref=contractReference;
    
    if (newNumRoutes> 0) then
      UPDATE Contracts
      SET NumRoutes=newNumRoutes;
    else
      raise noAssociateRoute;
    end if;
    
    --  total number of associated routes
    SELECT COUNT(DISTINCT Ref) INTO totalRoutes
    FROM Contracts
    WHERE Ref=contractReference;
    
    -- name of the organization
    SELECT DISTINCT ORGANIZATION INTO orgName
    FROM CONTRACTS
    WHERE Ref=contractReference;
    
    DBMS_OUTPUT.PUT_LINE('Organization name ' || totalRoutes);
    DBMS_OUTPUT.PUT_LINE('Total Routes is ' || orgName); 
    
EXCEPTION
WHEN noAssociateRoute then
   DBMS_OUTPUT.PUT_LINE('No routes for this reference');
END;

/* Creating a trigger */
/*
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
*/
