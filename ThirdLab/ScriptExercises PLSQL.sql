drop table courses cascade constraints; 
drop table inscriptions cascade constraints;
drop table fees cascade constraints;

create sequence coursesC  MINVALUE 1 START WITH 1
    INCREMENT BY 1 NOCACHE;

create table fees (
 levelF varchar(20) DEFAULT 'Beginner' NOT NULL
                  CONSTRAINT levelF_CK CHECK (levelF IN ('Beginner','Intermediate', 'Advanced')),
 typeF  varchar(10) DEFAULT 'Regular' NOT NULL
                  CONSTRAINT Tip_CK CHECK (typeF IN ('Regular','Intensive', 'Private')),       
price  NUMBER(6,2) DEFAULT 0,
primary key (levelF,typeF));

create table courses (
 code char(8) PRIMARY KEY, 
 name varchar(50) NOT NULL,
 levelF varchar(20) NOT NULL,
 typeF  varchar(10) NOT NULL,
 hours NUMBER(3) NOT NULL,
 quota NUMBER(3) DEFAULT 12,
 foreign key (levelF,typeF) REFERENCES fees);

create table inscriptions (
 code char(8) NOT NULL,
 id_student varchar(10) NOT NULL,
 price NUMBER(6,2) DEFAULT 0,
 old_student NUMBER(1) DEFAULT 0
                 CONSTRAINT student_CK CHECK (old_student IN (0,1)),
 primary key(code,id_student),
 foreign key (code) references courses);

insert into fees values('Beginner', 'Regular', 675);
insert into fees values('Beginner', 'Intensive', 460);
insert into fees values('Beginner', 'Private', 50);
insert into fees values('Intermediate', 'Intensive', 500);
insert into fees values('Intermediate', 'Regular', 800);
insert into fees values('Intermediate', 'Private', 60);
insert into fees values('Advanced', 'Intensive', 750);
insert into fees values('Advanced', 'Regular', 1000);
insert into fees values('Advanced', 'Private', 90);

//
create or replace
procedure "LOADEVENTS" is

begin

delete from courses;

FOR curso_ingles in 1..5 LOOP

insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Beginner', 'Regular', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Beginner', 'Intensive', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Beginner', 'Private', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Intermediate', 'Regular', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Intermediate', 'Intensive', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Intermediate', 'Private', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Advanced', 'Regular', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Advanced', 'Intensive', 10+ (2*coursesC.CURRVAL));
insert into courses (code, name, levelF, typeF, hours) values('C'||coursesC.NEXTVAL,'Chinese course '||coursesC.CURRVAL,'Advanced', 'Private', 10+ (2*coursesC.CURRVAL));

END LOOP;
END;

//
create or replace 
FUNCTION isGreaterQuote(p_code CHAR)
RETURN BOOLEAN
IS

  /* Declarations */
  v_quota number(3);
  v_enrolled number(3);
  v_first boolean:=true; 
  v_second boolean:=true; 
  
BEGIN
  
  /* Take course quota by parameter */
  SELECT QUOTA into v_quota from Courses
  WHERE Courses.Code=p_code;
  v_first:=false; /* Esto se ha ejecutado sin problemas*/
  
  /* Select count number of incriptions with code of the parameter */
  SELECT COUNT(Code) into v_enrolled
  FROM Inscriptions
  WHERE Inscriptions.Code=p_code;
  v_second:=false; /* Esto se ha ejecutado sin problemas*/
  
  if (v_enrolled > v_quota) then
      return true;
  else
      return false;
  end if;
  
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    if (v_first=true) then
      DBMS_OUTPUT.PUT_LINE('Excepcion en la primera consulta... No hemos encontrado cursos con ese código');
      return false;
    end if;
    if (v_second=true) then
      DBMS_OUTPUT.PUT_LINE('Excepcion en la SEGUNDA consulta... No hemos encontrado estudiantes enrolled en ese curso');
      DBMS_OUTPUT.PUT_LINE('Por lo tanto. Todo esta bien :-)');
      return true;
    end if;
  /*WHEN TOO_MANY_ROWS THEN
    DBMS_OUTPUT.PUT_LINE ('Several organizations found'); 
  */
  
END;


/*
  b.	Write a stored procedure to enroll a student in a given course. 
  First, you must check that the quota has not been exceeded (invoke the function previously designed); 
  If the student cannot be enrolled, show a message that indicates it. 
  The procedure will receive 3 parameters: course code, student id and a boolean that indicates if 
  the student was enrolled previously in other course. In the case of regular and intensive courses 
  the total price of the course will be the one stored in the table Fees. The price associated with 
  the private courses is the price of one hour. In order to calculate the final price, you have to 
  multiply it by the number of hours of each course.  All the students that were enrolled previously 
  in a course will obtain a 5% discount.
*/

//
CREATE OR REPLACE PROCEDURE EnrollStudent
(p_code CHAR, p_IDStudent VARCHAR, p_oldStudent BOOLEAN)
IS
  
  v_enrolled number:=0;
  v_duplicated boolean:=true;
  v_availableInscriptions boolean:=false;
  
  v_total number(3); -- total price for a course
  v_type varchar(20);
  v_price number(3);
  v_hours number(3);

BEGIN
  
  -- Check if student has been alreadfy in the courase / Duplicate key (student enrolled previosly?): print and returns
  -- NVL= si nulo pones cero en v_enrolled
  
  SELECT NVL(COUNT(ID_STUDENT),0) into v_enrolled
  FROM INSCRIPTIONS 
  WHERE Inscriptions.Code = p_code and Inscriptions.ID_Student=p_IDStudent;
  
  if (v_enrolled=1) then
    DBMS_OUTPUT.PUT_LINE('This student has been already enrolled');    
  else
     if(isGreaterQuote(p_code)) then
        Select TypeF, price, hours into v_type, v_price,v_hours
        FROM Courses natural join fees
        WHERE Courses.code=p_code;
        
        -- Calculate price
         
        if (v_type='Private') then
          v_total:=v_price*v_hours; -- Private courses are hours by the price.
        else
          v_total:=v_price;
        end if;
        
        if (p_oldStudent=true) then
          v_total:=v_total*0.95) -- Apply disccount: 5% if p_oldStudent
        end if;
        
        
        -- TODO
        -- INSERT INTO TABLE
        
        
      else
        -- Show error: quota is exceded..
        -- Quota limite for this course?: print and return
     end if;
  end if;
   
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    if (v_duplicated=true) then
      DBMS_OUTPUT.PUT_LINE('This student has been already enrolled');
      return false;
    end if;
    
END;




