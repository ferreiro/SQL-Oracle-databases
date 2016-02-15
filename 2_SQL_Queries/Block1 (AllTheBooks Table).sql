
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

select distinct client.name, Client.IdClient
from Client, Orders where
Client.IdClient=Orders.IdClient;

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

SELECT SUM(AMOUNT*(SALEPRICE-PURCHASEPRICE)) "Total"
FROM BOOKS_ORDER NATURAL JOIN BOOK;

-- 14. Total amount of each order (ordered by date) that  
-- have been placed after 01/12/2011 and have not been sent yet. 

SELECT TO_CHAR(DATEORDER, 'DD MONTH YYYY') "Date", SUM(AMOUNT*SALEPRICE) "Total"
FROM ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
WHERE DATEORDER>='1/12/2011' AND DATEEXPED IS NULL
GROUP BY DATEORDER
ORDER BY DATEORDER ASC;

-- 15. Detail of orders (Order number, client name, title, total amount, unit price and total). 

SELECT IDORDER, IDCLIENT, TITLE, AMOUNT, SALEPRICE "Unit Price", SUM(AMOUNT*SALEPRICE) "Total" 
FROM ORDERS NATURAL JOIN BOOKS_ORDER NATURAL JOIN BOOK
GROUP BY IDORDER, IDCLIENT, TITLE, AMOUNT, SALEPRICE
ORDER BY IDORDER ASC;

-- 16.  Orders whose total amount is greater than 100€. 

SELECT IDORDER, SUM(AMOUNT*SALEPRICE) "TOTAL"
FROM BOOKS_ORDER NATURAL JOIN BOOK
GROUP BY IDORDER
HAVING SUM(AMOUNT*SALEPRICE)>100
ORDER BY IDORDER;

-- 17. Orders and the total amount of each of them that contains more than a book (title). 

SELECT IDORDER, SUM(AMOUNT*SALEPRICE) "TOTAL"
FROM BOOKS_ORDER NATURAL JOIN BOOK
GROUP BY IDORDER
HAVING COUNT(TITLE)>1;

-- 18. Orders and the total amount of each of them that contains more than 4 copies

SELECT IDORDER, SUM(AMOUNT*SALEPRICE) "Total"
FROM BOOKS_ORDER NATURAL JOIN BOOK 
WHERE AMOUNT>4
GROUP BY IDORDER;

-- 19. List of the most expensive books. 

SELECT ISBN, TITLE, SALEPRICE
FROM BOOK
WHERE SALEPRICE IN (SELECT MAX(SALEPRICE) FROM BOOK);

-- 20. List of books that have not been sold or that have been sold but the profit per copy is less than 5€.   

SELECT ISBN, TITLE
FROM BOOK
WHERE(SALEPRICE-PURCHASEPRICE)<5 OR ISBN NOT IN(
  SELECT DISTINCT ISBN FROM BOOKS_ORDER
);

-- 21. List of clients that have bought more than one copy of a book sometime

SELECT NAME
FROM CLIENT NATURAL JOIN ORDERS
WHERE IDORDER IN (
  SELECT IDORDER
  FROM BOOKS_ORDER
  WHERE AMOUNT>1
);
 