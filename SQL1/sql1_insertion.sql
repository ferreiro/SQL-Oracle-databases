/********************************************/
-- Themes: IdTheme, Description */ 
INSERT INTO Theme VALUES(0, 'Amazing theme');
INSERT INTO Theme VALUES(1, 'Amazing theme 2');
INSERT INTO Theme VALUES(2, 'Amazing theme 3');

-- Publishers: Name, Address, Phone */
INSERT INTO Publisher VALUES('McGrah', 'Sol 20', 600400330);

-- Publication: ISBN, Title, Language, NamePublisher */
INSERT INTO Publication VALUES('A232', 'Zero to', 'English', 'McGrah');
INSERT INTO Publication VALUES('B232', 'Pull and bear', 'English', 'McGrah');

-- Clasifications: ISBN and ThemeID */
INSERT INTO Clasification VALUES('A232', 0);
INSERT INTO Clasification VALUES('B232', 1); 