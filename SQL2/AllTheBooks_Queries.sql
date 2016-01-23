
-- 1. List of books, the publication year of each of them and their authors, ordered by publication year
 
SELECT TITLE, AÑO "YEAR", NAME "Author name"
FROM BOOK NATURAL JOIN AUTHOR_BOOK, AUTHOR
WHERE AUTHOR_BOOK.AUTHOR=AUTHOR.IDAUTHOR
ORDER BY AÑO;

-- 2. List of books that were published before 01-01-2000. 
SELECT TITLE, AÑO
FROM BOOK
WHERE AÑO<'2000';

-- 3. List of clients that have bought at least one book. 
-- Es ta facil como decir, muestrame qué clientes de mi lista de clientes 
-- aparece en la lista de orders
SELECT DISTINCT IDCLIENT, NAME
FROM CLIENT NATURAL JOIN ORDERS;

-- 4. List of clients that bought the book whose ISBN= 4554672899910. 
SELECT IDCLIENT, NAME
FROM CLIENT NATURAL JOIN ORDERS NATURAL JOIN BOOKS_ORDER
WHERE ISBN='4554672899910';

-- 5. List of clients whose name contains  ‘Jo’ and the books that they have bought. 
SELECT IDCLIENT, NAME, TITLE
FROM CLIENT NATURAL JOIN ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
WHERE NAME LIKE '%Jo%';

-- 6. List of clients that have bought at least a book whose price is greater than 10€. 
SELECT DISTINCT IDCLIENT, NAME
FROM CLIENT NATURAL JOIN ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
WHERE BOOK.SALEPRICE>10;

-- 7. List of clients that have placed more than one order in the same date. 
SELECT IDCLIENT, NAME
FROM CLIENT
WHERE IDCLIENT=(
  SELECT IDCLIENT
  FROM ORDERS
  GROUP BY(IDCLIENT,DATEORDER)
  HAVING COUNT(DATEORDER)>1
);
