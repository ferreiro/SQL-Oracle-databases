CREATE TABLE Contracts(Ref  VARCHAR(10) PRIMARY KEY,
                       Organization      VARCHAR(100),
                       ContDate        DATE,
                       NumRoutes NUMBER(2,0));

CREATE TABLE Routes(Ref VARCHAR(10) REFERENCES Contracts ON DELETE CASCADE,
                      Origin     	  VARCHAR(50),
                      Destination    VARCHAR(50),
                      Vehicle        VARCHAR(20),
                      PRIMARY KEY (Ref, Origin, Destination));

CREATE PROCEDURE myContractProcedure
(ReferenceContract IN VARCHAR)
IS
    v_numberRoutes number:= 0;
    v_noValues boolean:= false;
    v_organizationName varchar:= "Name";
    
BEGIN
  
    /* Print organization name */ 
    SELECT Contracts.Organization INTO v_organizationName
    FROM Contracts
    WHERE Contracts.REF=ReferenceContract;
     
    DBMS_OUTPUT.PUT_LINE(v_organizationName); /* Print Name of the organization */
    
    /* Select the number of references that appears on Routes given a referenceContract pass by value */
    Select NVL(COUNT(ReferenceContract), 0) into v_numberRoutes
    from Routes
    where Ref=ReferenceContract;
    
    if (v_numberRuotes <= 0) then
        v_noValues := true;  /* Throw an exception */
    else
      /* Count is greater than 0. 
        Update value of refernce contracts */
      UPDATE Contracts
      SET NumRoutes = v_numberRoutes
      WHERE Contracts.Ref=ReferenceContract;
    end if;
    
    /* Print the total number of routes founded */
    DBMS_OUTPUT.PUT_LINE(v_numberRoutes); /* Print Total number of associated with the contract */
      
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        if(v_noValues=true) then
            DBMS_OUTPUT.PUT_LINE('');
        end if;      
END;
