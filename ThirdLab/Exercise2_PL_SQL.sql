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
