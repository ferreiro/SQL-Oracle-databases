
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

-- 8. List of clients and dates in which they have placed orders that have not been sent yet. 
SELECT IDCLIENT, NAME, DATEORDER
FROM CLIENT NATURAL JOIN ORDERS
WHERE DATEEXPED IS NULL;

-- 9. List of clients that have not bought books whose price is greater than 10€

SELECT DISTINCT IDCLIENT, NAME
FROM CLIENT
WHERE IDCLIENT NOT IN (
  SELECT IDCLIENT
  FROM ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
  WHERE SALEPRICE < 10
);

-- 10. List of books whose sale price is greater than 30€ or that were published before 2000. 
SELECT TITLE, AÑO, SALEPRICE
FROM BOOK
WHERE AÑO<'2000' OR SALEPRICE>30;

-- 11. List of books and amount of copies of each of them that have been sold. 
SELECT TITLE, ISBN, SUM(AMOUNT)
FROM BOOKS_ORDER NATURAL JOIN BOOK
GROUP BY TITLE, ISBN
ORDER BY SUM(AMOUNT) DESC;

-- 12. List of clients and the total amount that they have spent in the bookstore. 

SELECT IDCLIENT, NAME, SUM(AMOUNT*SALEPRICE) "Total"
FROM CLIENT NATURAL JOIN ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
GROUP BY IDCLIENT, NAME;

-- 13. Profits obtained from sales of books. 

/*
SELECT SUM(AMOUNT*(SALEPRICE-PURCHASEPRICE)) "TOTAL"
FROM CLIENT NATURAL JOIN ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
GROUP BY AMOUNT;
*/
