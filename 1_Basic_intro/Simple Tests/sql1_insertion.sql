CREATE SEQUENCE ThemesID_Sequence
MINVALUE 0
START WITH 0
INCREMENT BY +1
NOCACHE;

/********************************************/
-- Themes: IdTheme, Description */ 
INSERT INTO Theme VALUES(ThemesID_Sequence.NEXTVAL, 'Amazing theme');
INSERT INTO Theme VALUES(ThemesID_Sequence.NEXTVAL, 'Amazing theme 2');
INSERT INTO Theme VALUES(ThemesID_Sequence.NEXTVAL, 'Amazing theme 3');

-- Publishers: Name, Address, Phone */
INSERT INTO Publisher VALUES('McGrah', 'Sol 20', 600400330);

-- Publication: ISBN, Title, Language, NamePublisher */
INSERT INTO Publication VALUES('A232', 'Zero to', 'English', 'McGrah');
INSERT INTO Publication VALUES('B232', 'Pull and bear', 'English', 'McGrah');
INSERT INTO Publication VALUES('C232', 'YOOO', 'English', 'McGrah');
INSERT INTO Publication VALUES('D232', 'HAHAHAA', 'English', 'McGrah');
INSERT INTO Publication VALUES('E232', 'OXFORD', 'English', 'McGrah');
 
-- Clasifications: ISBN and ThemeID */
INSERT INTO Clasification VALUES('A232', 0);
INSERT INTO Clasification VALUES('B232', 1); 
INSERT INTO Clasification VALUES('B232', 2); 
INSERT INTO Clasification VALUES('C232', 3); 
INSERT INTO Clasification VALUES('C232', 4); 
INSERT INTO Clasification VALUES('D232', 5); 
