/* Exercise 1 */

Select Title, Año, Name
from Book, author_book, author
where Book.ISBN = author_book.isbn and author_book.author=author.idauthor
order by año desc;

/* Esto está hecho sin natural join*/
/*Select author_book.isbn,name,año
from Book, Author_Book, author 
where book.isbn = author_book.isbn and author.idauthor=author_book.author
ORDER BY Año DESC;
*/ 

/* Exercise 2 */

Select Title, Año
from Book 
where Book.Año < 2000;

/* Exercise 3 */

select distinct client.name, Client.IdClient
from Client, Orders where
Client.IdClient=Orders.IdClient;

select distinct client.name, Client.IdClient
from Client join Orders on /* La sintaxis del join hace que tengas que poner no */
Client.IdClient=Orders.IdClient;

/* Exercise 4 */
/*
Select *
from client join books_order on
books_order.isbn=4554672899910;
*/
Select *
from client natural join orders natural join books_order
where books_order.isbn=4554672899910;

/*  Select * from client join orders on clients.idclient= orders.idclient join books_order on */

/* Exercise 5 */
/* List of clients whose name contains ‘Jo’ and the books that they have bought. */

Select Name, Title "Titulo"
from Client natural join Orders natural join Books_Order natural join Book
where Name like '%Jo%';

/* Exercise 6 */
/* List of clients that have bought at least a book whose price is greater than 10€ */

Select distinct Name
from Client natural join Orders /* Relatnig by ID Client */
            natural join Books_Order /* Filtering clients that have bought a book */
            natural join Book  /* Relating Books_order with book by the ISBN */
where Book.SalePrice>10;

/* Exercise 7 */
/* List of clients that have placed more than one order in the same date. */

Select count( DateOrder ) from
Client natural ;
Select distinct Name
from Client natural join Orders
            natural join Books_Order
            natural join Book where Book.SalePrice>10 ;
Select * from Client natural join Orders natural join Books_Order natural join Book;


/* 8. List of clients and dates in which they have placed orders that have not been sent yet.*/ 
Select NAME
from Client natural join Orders
where DateExped IS NULL;

/* 9. List of clients that have not bought books whose price is greater than 10€.*/ 

Select distinct idclient, name 
from Client natural join Orders
            natural join Books_order
            natural join book
where saleprice<10;

/* 10. List of books whose sale price is greater than 30€ or that were published before 2000.*/ 
/* 11. List of books and amount of copies of each of them that have been sold.*/ 
/* 12. List of clients and the total amount that they have spent in the bookstore.*/ 
/* 13. Profits obtained from sales of books*/ 
