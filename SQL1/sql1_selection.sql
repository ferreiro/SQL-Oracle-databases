  
  SELECT COUNT(ISBN)
  FROM CLASIFICATION
  WHERE ISBN='B232';
  
  SELECT *
  FROM PUBLICATION
  WHERE (SELECT COUNT(ISBN) FROM PUBLICATION WHERE ISBN='B232' ) >= 1 AND ISBN='B232';
    
  SELECT COUNT(IDTHEME) 
  FROM CLASIFICATION 
  WHERE ISBN='B232';
  
  SELECT DISTINCT COUNT(NPUBLISHER)
  FROM PUBLICATION
  WHERE NPUBLISHER='McGrah';
  

/*
  SELECT ISBN "The ISBN", IDTHEME "The Theme"
  FROM CLASIFICATION
  WHERE ISBN='B232';
  
  
  SELECT *
  FROM THEME
  WHERE DESCRIPTION NOT NULL;
*/



/*
  Trabajandocon la idea del select y select distinct.
*/
/*
  --- This will print all the pair (ISBN, Theme)
  SELECT *
  FROM CLASIFICATION
  WHERE ISBN='B232';
  
  --- This will print the SAME RESULT as the previous code
  -- WHY?? Aunque usemos disctinct, en este caso cada fila compueade (isbn, themeid) es diferente
  -- por tanto el distinct no actúa...
  SELECT DISTINCT *
  FROM CLASIFICATION
  WHERE ISBN='B232';
  
  --- Ahora... Si en el select únicamente elegimos el ISBN. AHORA SÍ!!! Vamos a tener una única entrada.
  -- PORQUE habría varios ISBN repetidos y le decimos que solo coja uno
  SELECT DISTINCT ISBN "Renombrar el nombre de la columna"
  FROM CLASIFICATION
  WHERE ISBN='B232';
*/

